
;; https://github.com/manateelazycat/awesome-tray
(require 'awesome-tray)
(awesome-tray-mode 1)
(setq awesome-tray-active-modules '("buffer-name" "location" "awesome-tab" "mode-name" "date"))

;; doom-modeline
;; (use-package doom-modeline
;;   :ensure t
;;   :init (doom-modeline-mode 1)
;;   :config
;;   (setq doom-modeline-buffer-file-name-style 'file-name)
;;   (setq doom-modeline-icon nil)
;;   )

;; (column-number-mode t)
;; (display-battery-mode t)
;; (setq display-time-format "%m-%d %H:%M")
;; (setq display-time-day-and-date t)
;; (setq display-time-24hr-format t)
;; (display-time-mode t)

(require 'lazycat-theme)
(lazycat-theme-load-dark)
;;(lazycat-theme-load-light)
; 切换主题
(global-set-key [f12] 'lazycat-theme-toggle)
;(use-package solarized-theme
;  :init
;;  (load-theme 'solarized-light t) ;; 白天
;  (load-theme 'solarized-dark t)  ;; 夜间
;  )


;; 参考: https://github.com/DogLooksGood/dogEmacs/blob/master/elisp/init-font.el
;; 缺省字体（英文，如显示代码）。
(setq +font-family "Fira Code Retina")
(setq +modeline-font-family "Fira Code Retina")
;; 其它均使用 Sarasa Mono SC 字体。
(setq +fixed-pitch-family "Sarasa Mono SC")
(setq +variable-pitch-family "Sarasa Mono SC")
(setq +font-unicode-family "Sarasa Mono SC")
(setq +font-size 10)


(add-hook 'after-make-frame-functions
          ( lambda (f)
            (+load-face-font f)
            (+load-ext-font)
            (+load-emoji-font)))

(+load-font)

;; all-the-icons 和 fire-code-mode 只能在 GUI 模式下使用。
(when (display-graphic-p)
  (use-package all-the-icons
    :defer t
    :demand)
  ;; (use-package fira-code-mode
  ;;   :defer t
  ;;   :custom
  ;;   (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x"))
  ;;   :hook prog-mode)
  )


;; 设置缩放模式, 避免最大化窗口后右边和下边有空隙
(setq frame-inhibit-implied-resize t)
(setq frame-resize-pixelwise t)


;; 在 frame 底部显示窗口。
(setq display-buffer-alist
      `((,(rx bos (or "*Apropos*" "*Help*" "*helpful" "*info*" "*Summary*" "*lsp-help*" "*vterm") (0+ not-newline))
         (display-buffer-reuse-mode-window display-buffer-below-selected)
         (window-height . 0.43)
         (mode apropos-mode help-mode helpful-mode Info-mode Man-mode))))


;; dired 显示高亮增强。
(use-package diredfl
  :config
  (diredfl-global-mode))

;; 美化org结构
;; (require 'org-bars)
;; (add-hook 'org-mode-hook #'org-bars-mode)

;; tab
(require 'sort-tab)
(sort-tab-mode 1)
(global-set-key (kbd "s-n") 'sort-tab-select-next-tab)
(global-set-key (kbd "s-p") 'sort-tab-select-prev-tab)


(provide 'init-theme)
