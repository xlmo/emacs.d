
;; https://github.com/manateelazycat/awesome-tray
;; (require 'awesome-tray)
;; (awesome-tray-mode 1)
;; (setq awesome-tray-active-modules '("buffer-name" "location" "awesome-tab" "battery" "date"))


;; doom-modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-buffer-file-name-style 'file-name)
  (setq doom-modeline-icon nil)
  )
(column-number-mode t)
(display-battery-mode t)
(setq display-time-format "%m-%d %H:%M")
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)

(use-package solarized-theme
  :init
;;  (load-theme 'solarized-light t) ;; 白天
  (load-theme 'solarized-dark t)  ;; 夜间
  )


;; 参考: https://github.com/DogLooksGood/dogEmacs/blob/master/elisp/init-font.el
;; 缺省字体（英文，如显示代码）。
(setq +font-family "Fira Code Retina")
(setq +modeline-font-family "Fira Code Retina")
;; 其它均使用 Sarasa Mono SC 字体。
(setq +fixed-pitch-family "Sarasa Mono SC")
(setq +variable-pitch-family "Sarasa Mono SC")
(setq +font-unicode-family "Sarasa Mono SC")
(setq +font-size 10)

;; 设置缺省字体。
(defun +load-base-font ()
  ;; 只为缺省字体设置 size, 其它字体都通过 :height 动态伸缩。
  (let* ((font-spec (format "%s-%d" +font-family +font-size)))
    (set-frame-parameter nil 'font font-spec)
    (add-to-list 'default-frame-alist `(font . ,font-spec))))

;; 设置各特定 face 的字体。
(defun +load-face-font (&optional frame)
  (let ((font-spec (format "%s" +font-family))
        (modeline-font-spec (format "%s" +modeline-font-family))
        (variable-pitch-font-spec (format "%s" +variable-pitch-family))
        (fixed-pitch-font-spec (format "%s" +fixed-pitch-family)))
    (set-face-attribute 'variable-pitch frame :font variable-pitch-font-spec :height 1.2)
    (set-face-attribute 'fixed-pitch frame :font fixed-pitch-font-spec :height 1.0)
    (set-face-attribute 'fixed-pitch-serif frame :font fixed-pitch-font-spec :height 1.0)
    (set-face-attribute 'tab-bar frame :font font-spec :height 1.0)
    (set-face-attribute 'mode-line frame :font modeline-font-spec :height 1.0)
    (set-face-attribute 'mode-line-inactive frame :font modeline-font-spec :height 1.0)))

;; 设置中文字体。
(defun +load-ext-font ()
  (when window-system
    (let ((font (frame-parameter nil 'font))
          (font-spec (font-spec :family +font-unicode-family)))
      (dolist (charset '(kana han hangul cjk-misc bopomofo symbol))
        (set-fontset-font font charset font-spec)))))

;; 设置 Emoji 字体。
(defun +load-emoji-font ()
  (when window-system
    (setq use-default-font-for-symbols nil)
    (set-fontset-font t '(#x1f000 . #x1faff) (font-spec :family "Apple Color Emoji"))
    (set-fontset-font t 'symbol (font-spec :family "Symbola"))))

(add-hook 'after-make-frame-functions 
          ( lambda (f) 
            (+load-face-font f)
            (+load-ext-font)
            (+load-emoji-font)))

(defun +load-font ()
  (+load-base-font)
  (+load-face-font)
  (+load-ext-font)
  (+load-emoji-font))

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



;; 切换透明背景。
(defun my/toggle-transparency ()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
  (add-to-list 'default-frame-alist '(alpha . (90 . 90))))

;; 在 frame 底部显示窗口。
(setq display-buffer-alist
      `((,(rx bos (or "*Apropos*" "*Help*" "*helpful" "*info*" "*Summary*" "*lsp-help*" "*vterm") (0+ not-newline))
         (display-buffer-reuse-mode-window display-buffer-below-selected)
         (window-height . 0.43)
         (mode apropos-mode help-mode helpful-mode Info-mode Man-mode))))


;; dired 显示高亮增强。
(use-package diredfl
  :defer t
  :config
  (diredfl-global-mode))

;; 美化org结构
;; (require 'org-bars)                     
;; (add-hook 'org-mode-hook #'org-bars-mode)

;; tab
(add-to-list 'load-path "~/.emacs.d/elisp/sort-tab")
(require 'sort-tab)
(sort-tab-mode 1)
(global-set-key (kbd "s-n") 'sort-tab-select-next-tab)
(global-set-key (kbd "s-p") 'sort-tab-select-prev-tab)
;; (require 'awesome-tab)
;; (awesome-tab-mode t)
;; (setq awesome-tab-show-tab-index t)
;; (setq awesome-tab-display-icon nil)
;; ;; 根据索引来切换tab
;; (global-set-key (kbd "s-1") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-2") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-3") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-4") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-5") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-6") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-7") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-8") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-9") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-0") 'awesome-tab-select-visible-tab)
;; (global-set-key (kbd "s-n") 'awesome-tab-forward-tab)
;; (global-set-key (kbd "s-p") 'awesome-tab-backward-tab)
;; (awesome-tab-build-helm-source)
;; (setq awesome-tab-height 100)


(provide 'init-theme)
