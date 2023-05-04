;; 一些工具和配置
;; #+UPDATED_AT:2023-05-04T18:05:03+0800

;; Fast search tool `ripgrep'
(use-package rg
  :hook (after-init . rg-enable-default-bindings)
  :bind (:map rg-global-map
         ("c" . rg-dwim-current-dir)
         ("f" . rg-dwim-current-file)
         ("m" . rg-menu))
  :init (setq rg-group-result t
              rg-show-columns t)
  :config
  (cl-pushnew '("tmpl" . "*.tmpl") rg-custom-type-aliases))


(use-package counsel
  :ensure t
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  :bind(
        ("C-s" . swiper-isearch)
        ("C-x C-f" . counsel-find-file)
        ("M-x" . counsel-M-x)
        ("C-x b" . ivy-switch-buffer)
        ("C-c g" . counsel-rg)))

;; 将M-x操作时最常用的显示在前面
(use-package amx
  :ensure t
  :init (amx-mode))

(provide 'init-misc)
