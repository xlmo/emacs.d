
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

(use-package w3m)

(use-package yasnippet)



(provide 'init-packages)
