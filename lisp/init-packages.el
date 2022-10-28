

(use-package php-mode)

(use-package go-mode
  :config
  (progn
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    )
  :init
  (autoload 'go-mode "go-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
  )
(use-package go-eldoc
  :config
  (progn
    (add-hook 'go-mode-hook 'go-eldoc-setup)
    ))

(use-package go-guru
  :defer t
  :hook (go-mode . go-guru-hl-identifier-mode))

(use-package yaml-mode)
(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" "\\.css\\'" "\\.js\\'" "\\.vue\\'")
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2))

(use-package js2-mode)

;; 统一管理弹出窗口
(use-package popper
  :defer t
  :ensure t ; or :straight t
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))

;; 扩展区域
(use-package expand-region
  :bind ("C-=" . er/expand-region))


;; 窗口跳转 用M-数字键来切换窗口
(use-package window-numbering
  :config
  (window-numbering-mode 1)
  )
;; 自动完成框架
(use-package helm
  ;; 等价于 ((bind-key "M-x" #'helm-M-x)
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-c h" . helm-recentf))
  :config
  ; 全局启用  Helm minor mode
  (helm-mode 1))

;; 项目内搜索
(use-package helm-ag)

;; buffer内搜索
(use-package helm-swoop
  ;; 更多关于它的配置方法: https://github.com/ShingoFukuyama/helm-swoop
  ;; 以下我的配置仅供参考
  :bind
  (("M-i" . helm-swoop)
   ("M-I" . helm-swoop-back-to-last-point)
   ("C-c M-i" . helm-multi-swoop)
   ("C-x M-i" . helm-multi-swoop-all)
   :map isearch-mode-map
   ("M-i" . helm-swoop-from-isearch)
   :map helm-swoop-map
   ("M-i" . helm-multi-swoop-all-from-helm-swoop)
   ("M-m" . helm-multi-swoop-current-mode-from-helm-swoop))
  :config
  ;; 它像 helm-ag 一样，可以直接修改搜索结果 buffer 里的内容并 apply
  (setq helm-multi-swoop-edit-save t)
  ;; 如何给它新开分割窗口
  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows t))



;; 项目管理
(use-package projectile
  :config
  ;; 把它的缓存挪到 ~/.emacs.d/.cache/ 文件夹下，让 gitignore 好做
;  (setq projectile-cache-file (expand-file-name "projectile.cache" local-cache-directory))
  ;; 全局 enable 这个 minor mode
  (projectile-mode 1)
  ;; 定义和它有关的功能的 leader key
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map))

(use-package helm-projectile
  :if (functionp 'helm) ;; 如果使用了 helm 的话，让 projectile 的选项菜单使用 Helm 呈现
  :config
  (helm-projectile-on))

;; 版本管理
(use-package magit)


;; C-s增强 C-s 替换成ctrlf
(use-package ctrlf
  :config
  (ctrlf-mode t))

;;
;; (use-package popwin
;;   :config
;;   (popwin-mode 1))

;;显示当前组合键下的全部组合
(use-package which-key
  :config
   (which-key-mode)
   )

;; hydra
;;(use-package hydra)


;; 窗口管理
;; C-x r b 打开  C-x r w 保存
(use-package burly
  :bind
  ("C-x r w" . burly-bookmark-windows)
  :custom
  (burly-bookmark-prefix "WG:")
  )

;; 用eww代替
;;(use-package w3m)

;; 设置代码片断路径，这里必须先设置，不然会默认添加 ~/.emacs.d/snippets 这个路径并创建目录
(setq yas-snippet-dirs '("~/.emacs.d/data/snippets"))
(use-package yasnippet
  :init
  (yas-global-mode 1))
(print yas-snippet-dirs)

;; org markdown 表格对齐
(use-package valign
  :ensure t
  :hook ((markdown-mode org-mode) . valign-mode))

(use-package markdown-mode
  :ensure t
  :init
  (advice-add #'markdown--command-map-prompt :override #'ignore)
  (advice-add #'markdown--style-map-prompt   :override #'ignore)
  :mode ("README\\(?:\\.md\\)?\\'" . gfm-mode)
  :hook (markdown-mode . visual-line-mode)
  :bind (:map markdown-mode-style-map
         ("r" . markdown-insert-ruby-tag)
         ("d" . markdown-insert-details))
  :config
  (defun markdown-insert-ruby-tag (text ruby)
    "Insert ruby tag with `TEXT' and `RUBY' quickly."
    (interactive "sText: \nsRuby: \n")
    (insert (format "<ruby>%s<rp>(</rp><rt>%s</rt><rp>)</rp></ruby>" text ruby)))

  (defun markdown-insert-details (title)
    "Insert details tag (collapsible) quickly."
    (interactive "sTitle: ")
    (insert (format "<details><summary>%s</summary>\n\n</details>" title)))
  :custom
  (markdown-header-scaling t)
  (markdown-enable-wiki-links t)
  (markdown-italic-underscore t)
  (markdown-asymmetric-header t)
  (markdown-gfm-uppercase-checkbox t)
  (markdown-fontify-code-blocks-natively t))


;; 增强 emacs help
(use-package helpful
  :ensure t
  :preface
  (defun helpful-at-point-dwim ()
    (interactive)
    (let ((symbol (symbol-at-point)))
      (if symbol (helpful-symbol symbol)
        (call-interactively #'helpful-symbol))))

  :bind (([remap describe-variable] . helpful-variable)
         ([remap describe-function] . helpful-callable)
         ([remap describe-key] . helpful-key)
         :map emacs-lisp-mode-map
         ("C-c C-d" . helpful-at-point-dwim))

  :init
  (setq helpful-max-buffers 10)

  :config
  (defun helpful-reuse-window-function (buf)
    (if-let ((window (display-buffer-reuse-mode-window buf '((mode . helpful-mode)))))
        (select-window window)
      (pop-to-buffer buf)))
  (setq helpful-switch-buffer-function #'helpful-reuse-window-function)

  (defun helpful-previous-helpful-buffer ()
    (interactive)
    (let ((bufname (buffer-name)))
      (previous-buffer)
      (while (and (not (eq major-mode 'helpful-mode))
                  (not (string= (buffer-name) bufname)))
        (previous-buffer))))

  (defun helpful-next-helpful-buffer ()
    (interactive)
    (let ((bufname (buffer-name)))
      (next-buffer)
      (while (and (not (eq major-mode 'helpful-mode))
                  (not (string= (buffer-name) bufname)))
        (next-buffer))))

  (bind-keys :map helpful-mode-map
             ("," . beginning-of-buffer)
             ("." . end-of-buffer)
             ("b" . helpful-previous-helpful-buffer)
             ("f" . helpful-next-helpful-buffer)
             ("q" . delete-window)))


(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

(use-package posframe)

;; 窗口移动
;; (use-package windmove
;;   :ensure nil
;;   :bind
;;   (("<f2> <right>" . windmove-right)
;;    ("<f2> <left>" . windmove-left)
;;    ("<f2> <up>" . windmove-up)
;;    ("<f2> <down>" . windmove-down)
;;    ))

;; 这个包有内存泄露的问题
;;(use-package transpose-frame)

;; 窗口跳转操作
(defvar aw-dispatch-alist
    '((?x aw-delete-window "Delete Window")
      (?m aw-swap-window "Swap Windows")
      (?M aw-move-window "Move Window")
      (?c aw-copy-window "Copy Window")
      (?j aw-switch-buffer-in-window "Select Buffer")
;;      (?n aw-flip-window)
;;      (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
      (?c aw-split-window-fair "Split Fair Window")
      (?v aw-split-window-vert "Split Vert Window")
      (?b aw-split-window-horz "Split Horz Window")
      (?o delete-other-windows "Delete Other Windows")
      (?? aw-show-dispatch-help))
    "List of actions for `aw-dispatch-default'.")


(use-package ace-window
  :config
  ;; 排除sort-tab
  (add-to-list 'aw-ignored-buffers "*sort-tab*")
  :bind (("M-o" . 'ace-window)))

;; dired 显示高亮增强。
(use-package diredfl
  :config
  (diredfl-global-mode))

;; tab
;(require 'sort-tab)
;(sort-tab-mode 1)
;(global-set-key (kbd "s-n") 'sort-tab-select-next-tab)
;(global-set-key (kbd "s-p") 'sort-tab-select-prev-tab)



;; Recently opened files
(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :custom
  (recentf-max-saved-items 300)
  (recentf-auto-cleanup 'never)
  (recentf-exclude '(;; Folders on MacOS start
                     "^/private/tmp/"
                     "^/var/folders/"
                     ;; Folders on MacOS end
                     "^/tmp/"
		     "~/.emacs.d/var/"
		     "~/.emacs.d/etc/"
                     "/ssh\\(x\\)?:"
                     "/su\\(do\\)?:"
                     "^/usr/include/"
                     "/TAGS\\'"
                     "COMMIT_EDITMSG\\'")))


;; 多光标编辑
(use-package multiple-cursors
  :bind (("C-S-c" . mc/edit-lines) ;; 每行一个光标
         ("C->" . mc/mark-next-like-this-symbol) ;; 全选光标所在单词并在下一个单词增加一个光标。通常用来启动一个流程
         ("C-M->" . mc/skip-to-next-like-this) ;; 跳过当前单词并跳到下一个单词，和上面在同一个流程里。
         ("C-<" . mc/mark-previous-like-this-symbol) ;; 同样是开启一个多光标流程，但是是「向上找」而不是向下找。
         ("C-M-<" . mc/skip-to-previous-like-this) ;; 跳过当前单词并跳到上一个单词，和上面在同一个流程里。
         ("C-c C->" . mc/mark-all-symbols-like-this))) ;; 直接多选本 buffer 所有这个单词

;; 终端
(use-package vterm
  ;; https://github.com/akermu/emacs-libvterm
  ;; 请务必参照项目 README 作配置，以下不是我的完整配置。
  ;; 比如，如果你要和 shell 双向互动（对，它可以双向互动），
  ;; 那么 shell 需要做一点配置以解析 vterm 传递过来的信号
  :config
  (setq vterm-kill-buffer-on-exit t)) ;; shell 退出时 kill 掉这个 buffer
;; 使用 M-x vterm 新建一个 terminal
;; 在 terminal 中使用 C-c C-t 进入「选择」模式（类似 Tmux 里的 C-b [ ）

(use-package obsidian
  :ensure t
  :demand t
  :config
  (obsidian-specify-path obsidian-vault-dir)
  (global-obsidian-mode t)
  :custom
  ;; This directory will be used for `obsidian-capture' if set.
  (obsidian-inbox-directory "Inbox")
  :bind (:map obsidian-mode-map
              ;; 笔记跳转
              ("C-c o j" . obsidian-jump)
              ;; 新建笔记
              ("C-c o c" . obsidian-capture)
              ;; Replace C-c C-o with Obsidian.el's implementation. It's ok to use another
key binding.
              ;; 跳转链接
              ("C-c o f" . obsidian-follow-link-at-point)
              ;; Jump to backlinks
              ;; 跳转到引用
              ("C-c o b" . obsidian-backlink-jump)
              ;; If you prefer you can use `obsidian-insert-link'
or 'obsidian-insert-wikilink'
              ;; 插入内链
              ("C-c o l" . obsidian-insert-link)))

(provide 'init-packages)
