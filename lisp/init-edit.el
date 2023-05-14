;; 编辑相关配置


;; Emacs默认选择文本后直接输入，是不会直接删除所选择的文本进行替换的。通过内置的 delsel 插件来实现这个行为
(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

;; 文件发生改变的时候自动重载文件
(use-package autorevert
  :ensure nil
  :hook (after-init . global-auto-revert-mode)
  :bind ("s-u" . revert-buffer)
  :custom
  (auto-revert-interval 10)
  (auto-revert-avoid-polling t)
  (auto-revert-verbose nil)
  (auto-revert-remote-files t)
  (auto-revert-check-vc-info t)
  (global-auto-revert-non-file-buffers t))

;;自动记住每个文件的最后一次访问的光标位置
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))
;; 记住最近打开的文件历史
(use-package recentf
  :ensure nil
  :bind (("C-c h" . recentf-open-files))
  :defines no-littering-etc-directory no-littering-var-directory
  :hook (after-init . recentf-mode)
  :custom
  (recentf-max-saved-items 300)
  (recentf-auto-cleanup 'never)
  ;; `recentf-add-file' will apply handlers first, then call `string-prefix-p'
  ;; to check if it can be pushed to recentf list.
  (recentf-filename-handlers '(abbreviate-file-name))
  (recentf-exclude `(,@(cl-loop for f in `(,package-user-dir
                                           ,no-littering-var-directory
                                           ,no-littering-etc-directory)
                                collect (abbreviate-file-name f))
                     ;; Folders on MacOS start
                     "^/private/tmp/"
                     "^/var/folders/"
                     ;; Folders on MacOS end
                     ".cache"
                     ".cask"
                     ".elfeed"
                     "elfeed"
                     "bookmarks"
                     "cache"
                     "ido.*"
                     "persp-confs"
                     "recentf"
                     "undo-tree-hist"
                     "url"
                     "^/tmp/"
                     "/ssh\\(x\\)?:"
                     "/su\\(do\\)?:"
                     "^/usr/include/"
                     "/TAGS\\'"
                     "COMMIT_EDITMSG\\'")))

;; 自动更新时间
(setq time-stamp-start "#\\+UPDATED_AT:[ \t]*"
      time-stamp-end  "$"
      time-stamp-format "%Y-%m-%dT%02H:%02m:%02S%5z")
(add-hook 'before-save-hook 'time-stamp)

;; 扩展选择区
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; undo tree
(use-package vundo
  :bind ("C-x u" . vundo)
  :config (setq vundo-glyph-alist vundo-unicode-symbols))

;; 跳转到最后修改位置
(use-package goto-chg
  :bind ("C-," . goto-last-change))

;; Preview when `goto-char'
;; (use-package goto-char-preview
;;   :bind ([remap goto-char] . goto-char-preview))

;; Preview when `goto-char'
;; (use-package goto-char-preview
;;   :bind ([remap goto-char] . goto-char-preview))

;; markdown
(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode))
  :init
  (setq markdown-enable-wiki-links t
        markdown-italic-underscore t
        markdown-asymmetric-header t
        markdown-make-gfm-checkboxes-buttons t
        markdown-gfm-uppercase-checkbox t
        markdown-fontify-code-blocks-natively t
        markdown-gfm-additional-languages "Mermaid")

  ;; `multimarkdown' is necessary for `highlight.js' and `mermaid.js'
  :config
  (with-no-warnings
    ;; Use `which-key' instead
    (advice-add #'markdown--command-map-prompt :override #'ignore)
    (advice-add #'markdown--style-map-prompt   :override #'ignore)
    )
  ;; Table of contents
  (use-package markdown-toc
    :diminish
    :bind (:map markdown-mode-command-map
           ("r" . markdown-toc-generate-or-refresh-toc))
    :hook (markdown-mode . markdown-toc-mode)
    :init (setq markdown-toc-indentation-space 2
                markdown-toc-header-toc-title "\n## Table of Contents"
                markdown-toc-user-toc-structure-manipulation-fn 'cdr)
    :config
    (with-no-warnings
      (define-advice markdown-toc-generate-toc (:around (fn &rest args) lsp)
        "Generate or refresh toc after disabling lsp."
        (cond
         ((bound-and-true-p lsp-managed-mode)
          (lsp-managed-mode -1)
          (apply fn args)
          (lsp-managed-mode 1))
         ((bound-and-true-p eglot--manage-mode)
          (eglot--manage-mode -1)
          (apply fn args)
          (eglot--manage-mode 1))
         (t
          (apply fn args)))))))

;; 按一次 C-a 时移动到代码文字开头，再按一次则是移动到整行的行首，如此反复
;; (use-package mwim
;;   :ensure t
;;   :bind
;;   ("C-a" . mwim-beginning-of-code-or-line)
;;   ("C-e" . mwim-end-of-code-or-line))

;; Minor mode to aggressively keep your code always indented
(use-package aggressive-indent
  :diminish
  :hook ((after-init . global-aggressive-indent-mode)
         ;; NOTE: Disable in large files due to the performance issues
         ;; https://github.com/Malabarba/aggressive-indent-mode/issues/73
         (find-file . (lambda ()
                        (when (too-long-file-p)
                          (aggressive-indent-mode -1)))))
  :config
  ;; Disable in some modes
  (dolist (mode '(gitconfig-mode asm-mode web-mode html-mode css-mode go-mode scala-mode prolog-inferior-mode))
    (push mode aggressive-indent-excluded-modes))

  ;; Disable in some commands
  (add-to-list 'aggressive-indent-protected-commands #'delete-trailing-whitespace t)
  ;; Be slightly less aggressive in C/C++/C#/Java/Go/Swift
  (add-to-list 'aggressive-indent-dont-indent-if
               '(and (derived-mode-p 'php-mode 'c-mode 'c++-mode 'csharp-mode
                                     'java-mode 'go-mode 'swift-mode)
                     (null (string-match "\\([;{}]\\|\\b\\(if\\|for\\|while\\)\\b\\)"
                                         (thing-at-point 'line))))))

;;无需鼠标的快速光标跳转
(use-package avy
  :ensure t
  :bind
  (("C-j g" . avy-goto-char-timer)))


;; 多行光标
(use-package multiple-cursors
  :bind (("C-c m" . multiple-cursors-hydra/body)
         ("C-S-c C-S-c"   . mc/edit-lines)
         ("C->"           . mc/mark-next-like-this)
         ("C-<"           . mc/mark-previous-like-this)
         ("C-c C-<"       . mc/mark-all-like-this)
         ("C-M->"         . mc/skip-to-next-like-this)
         ("C-M-<"         . mc/skip-to-previous-like-this)
         ("s-<mouse-1>"   . mc/add-cursor-on-click)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)
         :map mc/keymap
         ("C-|" . mc/vertical-align-with-space))
  :pretty-hydra
  ((:title (pretty-hydra-title "Multiple Cursors" 'mdicon "nf-md-border_all")
           :color amaranth :quit-key ("q" "C-g"))
   ("Up"
    (("p" mc/mark-previous-like-this "prev")
     ("P" mc/skip-to-previous-like-this "skip")
     ("M-p" mc/unmark-previous-like-this "unmark")
     ("|" mc/vertical-align "align with input CHAR"))
    "Down"
    (("n" mc/mark-next-like-this "next")
     ("N" mc/skip-to-next-like-this "skip")
     ("M-n" mc/unmark-next-like-this "unmark"))
    "Misc"
    (("l" mc/edit-lines "edit lines" :exit t)
     ("a" mc/mark-all-like-this "mark all" :exit t)
     ("s" mc/mark-all-in-region-regexp "search" :exit t)
     ("<mouse-1>" mc/add-cursor-on-click "click"))
    "% 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")"
    (("0" mc/insert-numbers "insert numbers" :exit t)
     ("A" mc/insert-letters "insert letters" :exit t)))))

;; 中英文之间加空格
(use-package pangu-spacing)

;; 代码片段
(use-package yasnippet
  :defer 10
  :config
  (require 'yasnippet)
  (add-to-list
   'yas-snippet-dirs (concat user-emacs-directory "snippets"))
  (yas-global-mode 1)
  ;;  (use-package warnings)
  (setq warning-suppress-types '((yasnippet backquote-change))))


(provide 'init-edit)
