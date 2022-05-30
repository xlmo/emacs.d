
;; doom-theme
;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-one t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))


;; https://github.com/manateelazycat/awesome-tray
;(require 'awesome-tray)
;(awesome-tray-mode 1)
;(setq mode-line-format nil)

;; doom-modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-buffer-file-name-style 'file-name)
  )
(column-number-mode t)
(display-battery-mode t)
(setq display-time-format "%m-%d %H:%M")
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)


(use-package doom-themes
  :demand
  ;; 添加 "extensions/*" 后才支持 visual-bell/treemacs/org 配置。
;  :straight (:files ("*.el" "themes/*" "extensions/*"))
  :custom-face
  (doom-modeline-buffer-file ((t (:inherit (mode-line bold)))))
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  (doom-themes-treemacs-theme "doom-colors")
  ;; modeline 两边各加 4px 空白。
  (doom-themes-padded-modepline t)
  :config
  (doom-themes-visual-bell-config)
  (load-theme 'doom-palenight t)
  ;; 为 treemacs 关闭 variable-pitch 模式，否则显示的较丑！
  ;; 必须在执行 doom-themes-treemacs-config 前设置该变量为 nil, 否则不生效。
  (setq doom-themes-treemacs-enable-variable-pitch nil)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; 设置中文字体
;(set-fontset-font "fontset-default" 'han "Microsoft YaHei UI")
;; (defun font-installed-p (font-name)
;;   "Check if font with FONT-NAME is available."
;;   (find-font (font-spec :name font-name)))
;; (when (display-graphic-p)
;;   (cl-loop for font in '("Cascadia Code" "SF Mono" "Source Code Pro"
;;                          "Fira Code" "Menlo" "Monaco" "Dejavu Sans Mono"
;;                          "Lucida Console" "Consolas" "SAS Monospace")
;;            when (font-installed-p font)
;;            return (set-face-attribute
;;                    'default nil
;;                    :font (font-spec :family font
;;                                     :weight 'normal
;;                                     :slant 'normal
;;                                     :size (cond ((eq system-type 'gnu/linux) 12.0)
;;                                                 ((eq system-type 'windows-nt) 10.0)))))
;;   (cl-loop for font in '("OpenSansEmoji" "Noto Color Emoji" "Segoe UI Emoji"
;;                          "EmojiOne Color" "Apple Color Emoji" "Symbola" "Symbol")
;;            when (font-installed-p font)
;;            return (set-fontset-font t 'unicode
;;                                     (font-spec :family font
;;                                                :size (cond ((eq system-type 'gnu/linux) 14.5)
;;                                                            ((eq system-type 'windows-nt) 12.5)))
;;                                     nil 'prepend))
;;   (cl-loop for font in '("思源黑体 CN" "思源宋体 CN" "微软雅黑 CN"
;;                          "Source Han Sans CN" "Source Han Serif CN"
;;                          "WenQuanYi Micro Hei" "文泉驿等宽微米黑"
;;                          "Microsoft Yahei UI" "Microsoft Yahei")
;;            when (font-installed-p font)
;;            return (set-fontset-font t '(#x4e00 . #x9fff)
;;                                     (font-spec :name font
;;                                                :weight 'normal
;;                                                :slant 'normal
;;                                                :size (cond ((eq system-type 'gnu/linux) 14.5)
;;                                                            ((eq system-type 'windows-nt) 12.5)))))
;;   (cl-loop for font in '("HanaMinB" "SimSun-ExtB")
;;            when (font-installed-p font)
;;            return (set-fontset-font t '(#x20000 . #x2A6DF)
;;                                     (font-spec :name font
;;                                                :weight 'normal
;;                                                :slant 'normal
;;                                                :size (cond ((eq system-type 'gnu/linux) 14.5)
;;                                                            ((eq system-type 'windows-nt) 12.5))))))





;; 参考: https://github.com/DogLooksGood/dogEmacs/blob/master/elisp/init-font.el
;; 缺省字体（英文，如显示代码）。
(setq +font-family "Fira Code Retina")
(setq +modeline-font-family "Fira Code Retina")
;; 其它均使用 Sarasa Mono SC 字体。
(setq +fixed-pitch-family "Sarasa Mono SC")
(setq +variable-pitch-family "Sarasa Mono SC")
(setq +font-unicode-family "Sarasa Mono SC")
(setq +font-size 14)

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
  (use-package all-the-icons :demand)
  (use-package fira-code-mode
    :custom
    (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x"))
    :hook prog-mode))




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
  :config
  (diredfl-global-mode))

;; 美化org结构
;; (require 'org-bars)                     
;; (add-hook 'org-mode-hook #'org-bars-mode)

(provide 'init-theme)
