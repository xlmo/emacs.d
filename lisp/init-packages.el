;; 如果use-package没安装
(unless (package-installed-p 'use-package)
  ;; 更新本地缓存
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; 永远按需安装
(setq use-package-always-ensure t)

;; 性能测试
;; (use-package benchmark-init
;;   :ensure t
;;   :config
;;   ;; To disable collection of benchmark data after init is done.
;;   (add-hook 'after-init-hook 'benchmark-init/deactivate))

;; 各种mode
(use-package php-mode)
(use-package go-mode)
(use-package yaml-mode)


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

;; 文本补全
(use-package company
  ;; 等价于 (add-hook 'after-init-hook #'global-company-mode)
  :hook (after-init . global-company-mode)
  :config
  ;; setq 可以像这样连着设置多个变量的值
  (setq company-tooltip-align-annotations t ; 注释贴右侧对齐
        company-tooltip-limit 20            ; 菜单里可选项数量
        company-show-numbers t              ; 显示编号（然后可以用 M-数字 快速选定某一项）
        company-idle-delay .2               ; 延时多少秒后弹出
        company-minimum-prefix-length 1     ; 至少几个字符后开始补全
        ))

;; 项目管理
(use-package projectile
  :config
  ;; 把它的缓存挪到 ~/.emacs.d/.cache/ 文件夹下，让 gitignore 好做
  (setq projectile-cache-file (expand-file-name ".cache/projectile.cache" user-emacs-directory))
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


;; lsp
(use-package lsp-mode
  ;; 延时加载：仅当 (lsp) 函数被调用时再 (require)
  :commands (lsp)
  ;; 在哪些语言 major mode 下启用 LSP
  :hook (((
           php-mode
           go-mode
           ) . lsp))
  :init ;; 在 (reuqire) 之前执行
  (setq lsp-auto-configure t ;; 尝试自动配置自己
        lsp-auto-guess-root t ;; 尝试自动猜测项目根文件夹
        lsp-idle-delay 0.500 ;; 多少时间idle后向服务器刷新信息
        lsp-session-file "~/.emacs/.cache/lsp-sessions") ;; 给缓存文件换一个位置
  )

;; 内容呈现
(use-package lsp-ui
  ;; 仅在某软件包被加载后再加载
  :after (lsp-mode)
  ;; 延时加载
  :commands (lsp-ui-mode)
  :bind
  (:map lsp-ui-mode-map
        ;; 查询符号定义：使用 LSP 来查询。通常是 M-.
        ([remap xref-find-references] . lsp-ui-peek-find-references)
        ;; 查询符号引用：使用 LSP 来查询。通常是 M-?
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ;; 该文件里的符号列表：类、方法、变量等。前提是语言服务支持本功能。
        ("C-c u" . lsp-ui-imenu))
  ;; 当 lsp 被激活时自动激活 lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :init
  ;; lsp-ui 有相当细致的功能开关。具体参考：
  ;; https://github.com/emacs-lsp/lsp-mode/blob/master/docs/tutorials/how-to-turn-off.md
  (setq lsp-enable-symbol-highlighting t
        lsp-ui-doc-enable t
        lsp-lens-enable t))



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

;; 修正默认配置的一些不合理配置
(use-package better-defaults)


;; 窗口管理
;; C-x r b 打开  C-x r w 保存
(use-package burly
  :bind
  ("C-x r w" . burly-bookmark-windows)
  :custom
  (burly-bookmark-prefix "WG:")
  )



;; dashboard的可选功能
(use-package page-break-lines)

;; dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo))

(provide 'init-packages)
