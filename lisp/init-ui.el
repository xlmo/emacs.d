
;; doom-modeline
;; (use-package doom-modeline
;;   :ensure t
;;   :init (doom-modeline-mode 1)
;;   :config
;;   (setq doom-modeline-buffer-file-name-style 'file-name)
;;   (setq doom-modeline-icon nil)
;;   )


;; (use-package modus-themes
;;   :ensure
;;   :init
;;   ;; Add all your customizations prior to loading the themes
;;   (setq modus-themes-italic-constructs t
;;         modus-themes-bold-constructs nil
;;         modus-themes-region '(bg-only no-extend))

;;   ;; Load the theme files before enabling a theme
;;   (modus-themes-load-themes)
;;   :config
;;   ;; Load the theme of your choice:
;;   (modus-themes-load-operandi) ;; OR (modus-themes-load-vivendi)
;;   :bind ("<f12>" . modus-themes-toggle))

;; ;; modeline
(use-package telephone-line
  :init
  (telephone-line-mode 1)
  :config
  (setq display-time-format "%m-%d %H:%M")
  (setq display-time-default-load-average nil) ;; 不显示sytem load
  (display-time-mode t)
  )

;; 终端下使用终端自己的主题
(when (display-graphic-p)
  (use-package zenburn-theme
    :config
    (load-theme 'zenburn)))

;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-one t)
;; ;;  (load-theme 'doom-one-light t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)


;;   (doom-modeline-mode)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

(use-package solaire-mode
  :init
  (solaire-global-mode +1))

;(require 'lazycat-theme)
;(lazycat-theme-load)
;;(lazycat-theme-load-dark)
;;(lazycat-theme-load-light)

;(global-set-key [f12] 'lazycat-theme-toggle)
;(use-package solarized-theme
;  :init
;;  (load-theme 'solarized-light t) ;; 白天
;  (load-theme 'solarized-dark t)  ;; 夜间
;  )


;; 参考: https://github.com/DogLooksGood/dogEmacs/blob/master/elisp/init-font.el
;; 缺省字体（英文，如显示代码）。
;; (setq +font-family "Fira Code Retina")
;; (setq +modeline-font-family "Fira Code Retina")
;; ;; 其它均使用 Sarasa Mono SC 字体。
;; (setq +fixed-pitch-family "Sarasa Mono SC")
;; (setq +variable-pitch-family "Sarasa Mono SC")
;; (setq +font-unicode-family "Sarasa Mono SC")
;; (setq +font-size 10)


;; (add-hook 'after-make-frame-functions
;;           ( lambda (f)
;;             (+load-face-font f)
;;             (+load-ext-font)
;;             (+load-emoji-font)))

;; (+load-font)

(use-package all-the-icons
  :defer t
  :demand)



;; 设置缩放模式, 避免最大化窗口后右边和下边有空隙
(setq frame-inhibit-implied-resize t)
(setq frame-resize-pixelwise t)


;; 在 frame 底部显示窗口。
(setq display-buffer-alist
      `((,(rx bos (or "*Apropos*" "*Help*" "*helpful" "*info*" "*Summary*" "*lsp-help*" "*vterm") (0+ not-newline))
         (display-buffer-reuse-mode-window display-buffer-below-selected)
         (window-height . 0.43)
         (mode apropos-mode help-mode helpful-mode Info-mode Man-mode))))

;; 美化org结构
;; (require 'org-bars)
;; (add-hook 'org-mode-hook #'org-bars-mode)

;; 「平铺式 WM」
;; 它把窗口分为「主窗口」和「副窗口」两种，主窗口默认占满左半屏作为你的工作重心，副窗口叠放在右半屏。你可以随时交换主副窗口的位置。
(use-package edwina
  :config
  ;; 让所有 display-buffer 动作都新增一个 window （而不是复用已经打开此 buffer 的 window）
  (setq display-buffer-base-action '(display-buffer-below-selected))
  ;; 以下定义会被 (edwina-setup-dwm-keys) 增加 'M-' 修饰。
  ;; 我自定义了一套按键，因为原版会把我很常用的 M-d 覆盖掉。
  (setq edwina-dwm-key-alist
        '(("r" edwina-arrange)
          ("j" edwina-select-next-window)
          ("k" edwina-select-previous-window)
          ("J" edwina-swap-next-window)
          ("K" edwina-swap-previous-window)
          ("h" edwina-dec-mfact)    ;; 主窗口缩窄
          ("l" edwina-inc-mfact)    ;; 主窗口拉宽
          ("D" edwina-dec-nmaster)  ;; 减少主窗口的数量
          ("I" edwina-inc-nmaster)  ;; 增加主窗口的数量
          ("C" edwina-delete-window) ;; 关闭窗口
          ("RET" edwina-zoom t)     ;; 交换「主窗口」和「副窗口」
          ("return" edwina-zoom t)
          ("S-RET" edwina-clone-window t) ;; 复制一个本窗口
          ("S-return" edwina-clone-window t)))
  (edwina-setup-dwm-keys)
  (edwina-mode 1))


(provide 'init-ui)
