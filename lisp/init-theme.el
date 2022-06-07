
;; https://github.com/manateelazycat/awesome-tray
;; (require 'awesome-tray)
;; (awesome-tray-mode 1)
;; (setq mode-line-format nil)

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

(load-theme 'modus-vivendi) ;; 夜间
;; (load-theme 'modus-operandi) ;; 白天

;; (use-package doom-themes
;;   :demand
;;   ;; 添加 "extensions/*" 后才支持 visual-bell/treemacs/org 配置。
;; ;  :straight (:files ("*.el" "themes/*" "extensions/*"))
;;   :custom-face
;;   (doom-modeline-buffer-file ((t (:inherit (mode-line bold)))))
;;   :custom
;;   (doom-themes-enable-bold t)
;;   (doom-themes-enable-italic t)
;;   (doom-themes-treemacs-theme "doom-colors")
;;   ;; modeline 两边各加 4px 空白。
;;   (doom-themes-padded-modepline t)
;;   :config
;;   (doom-themes-visual-bell-config)
;;   (load-theme 'doom-palenight t)
;;   ;; 为 treemacs 关闭 variable-pitch 模式，否则显示的较丑！
;;   ;; 必须在执行 doom-themes-treemacs-config 前设置该变量为 nil, 否则不生效。
;;   (setq doom-themes-treemacs-enable-variable-pitch nil)
;;   (doom-themes-treemacs-config)
;;   (doom-themes-org-config))


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

(provide 'init-theme)
