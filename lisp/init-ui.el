;; #+TITLE: 界面配置
;; #+UPDATED_AT:2023-05-08T17:05:56+0800

;; Optimization
(setq-default cursor-in-non-selected-windows nil)

;; Suppress GUI features
(setq use-file-dialog nil
      use-dialog-box nil  ;; 鼠标操作不使用对话框
      inhibit-default-init t ;; 不加载 `default' 库
      inhibit-startup-screen t  ;; 不加载启动画面
      inhibit-startup-message t ;; 不加载启动消息
      inhibit-startup-buffer-menu t ;; 不显示缓冲区列表
      idle-update-delay 1.0
      highlight-nonselected-windows nil
      fast-but-imprecise-scrolling t
      frame-inhibit-implied-resize t
      frame-resize-pixelwise t
      inhibit-startup-echo-area-message user-login-name
      initial-scratch-message (concat ";; Happy hacking, "
                      (capitalize user-login-name) " - Emacs ♥ you!\n\n") ;; 草稿缓冲区默认文字设置
      bidi-paragraph-direction 'left-to-right ;; 设置缓冲区的文字方向为从左到右
      large-file-warning-threshold 100000000 ;; 设置大文件阈值为100MB，默认10MB
      display-raw-bytes-as-hex t ;; 以16进制显示字节数
      redisplay-skip-fontification-on-input t ;; 有输入时禁止 `fontification' 相关的函数钩子，能让滚动更顺滑
      ring-bell-function 'ignore ;; 禁止响铃
      mouse-yank-at-point t ;; 在光标处而非鼠标所在位置粘贴
      auto-window-vscroll nil ;; 对于高的行禁止自动垂直滚动
      split-width-threshold (assoc-default 'width default-frame-alist) ;; 设置新分屏打开的位置的阈值
      split-height-threshold nil
      scroll-step 2 ;; 鼠标滚动设置
      scroll-margin 2
      hscroll-step 2
      hscroll-margin 2
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      scroll-preserve-screen-position 'always
      original-y-or-n-p 'y-or-n-p ;; yes或no提示设置，通过下面这个函数设置当缓冲区名字匹配到预设的字符串时自动回答yes
      confirm-kill-emacs 'y-or-n-p ;; 退出Emacs时进行确认
      ;; 设置位置记录长度为6，默认为16
      ;; 可以使用 `counsel-mark-ring' or `consult-mark' (C-x j) 来访问光标位置记录
      ;; 使用 C-x C-SPC 执行 `pop-global-mark' 直接跳转到上一个全局位置处
      ;; 使用 C-u C-SPC 跳转到本地位置处
      mark-ring-max 6
      global-mark-ring-max 6
      frame-title-format '("Emacs - %b") ;; 设置标题
      icon-title-format frame-title-format
      initial-scratch-message nil)

(unless (daemonp)
  (advice-add #'display-startup-echo-area-message :override #'ignore))


;; 设置自动折行宽度为80个字符，默认值为70
(setq-default fill-column 80)

;; 禁止闪烁光标
(blink-cursor-mode -1)

;; TAB键设置，在Emacs里不使用TAB键，所有的TAB默认为4个空格
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


;; 在命令行里支持鼠标
(xterm-mouse-mode 1)

;; 在模式栏上显示当前光标的列号
(column-number-mode t)

;; Fonts
(defun custom-setup-fonts ()
  "Setup fonts."
  (when (display-graphic-p)
    ;; Set default font
    (cl-loop for font in '("Cascadia Code" "Fira Code" "Jetbrains Mono"
               "SF Mono" "Hack" "Source Code Pro" "Menlo"
               "Monaco" "DejaVu Sans Mono" "Consolas")
         when (font-installed-p font)
         return (set-face-attribute 'default nil
                    :family font
                    :height (cond (sys/macp 130)
                              (sys/win32p 110)
                              (t 100))))

    ;; Set mode-line font
    ;; (cl-loop for font in '("Menlo" "SF Pro Display" "Helvetica")
    ;;          when (font-installed-p font)
    ;;          return (progn
    ;;                   (set-face-attribute 'mode-line nil :family font :height 120)
    ;;                   (when (facep 'mode-line-active)
    ;;                     (set-face-attribute 'mode-line-active nil :family font :height 120))
    ;;                   (set-face-attribute 'mode-line-inactive nil :family font :height 120)))

    ;; Specify font for all unicode characters
    (cl-loop for font in '("Segoe UI Symbol" "Symbola" "Symbol")
         when (font-installed-p font)
         return (if (< emacs-major-version 27)
            (set-fontset-font "fontset-default" 'unicode font nil 'prepend)
              (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend)))

    ;; Emoji
    (cl-loop for font in '("Noto Color Emoji" "Apple Color Emoji" "Segoe UI Emoji")
         when (font-installed-p font)
         return (cond
             ((< emacs-major-version 27)
              (set-fontset-font "fontset-default" 'unicode font nil 'prepend))
             ((< emacs-major-version 28)
              (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend))
             (t
              (set-fontset-font t 'emoji (font-spec :family font) nil 'prepend))))

    ;; Specify font for Chinese characters
    (cl-loop for font in '("WenQuanYi Micro Hei" "PingFang SC" "Microsoft Yahei" "STFangsong")
         when (font-installed-p font)
         return (progn
              (setq face-font-rescale-alist `((,font . 1.3)))
              (set-fontset-font t '(#x4e00 . #x9fff) (font-spec :family font))))))

(custom-setup-fonts)
(add-hook 'window-setup-hook #'custom-setup-fonts)
(add-hook 'server-after-make-frame-hook #'custom-setup-fonts)


;; 主题包
(use-package ef-themes
  :ensure t
  :bind ("C-c t" . ef-themes-toggle)
  :init
  ;; set two specific themes and switch between them
  (setq ef-themes-to-toggle '(ef-light ef-winter))
  ;; set org headings and function syntax
  (setq ef-themes-headings
    '((0 . (bold 1))
      (1 . (bold 1))
      (2 . (rainbow bold 1))
      (3 . (rainbow bold 1))
      (4 . (rainbow bold 1))
      (t . (rainbow bold 1))))
  (setq ef-themes-region '(intense no-extend neutral))
  ;; Disable all other themes to avoid awkward blending:
  (mapc #'disable-theme custom-enabled-themes)

  ;; Load the theme of choice:
  ;; The themes we provide are recorded in the `ef-themes-dark-themes',
  ;; `ef-themes-light-themes'.

  ;; 随机挑选一款主题，如果是命令行打开Emacs，则随机挑选一款黑色主题
  (if (display-graphic-p)
      (ef-themes-select 'ef-light) ;; (ef-themes-load-random)
    (ef-themes-load-random 'dark))

  :config
  ;; auto change theme, aligning with system themes.
  (defun my/apply-theme (appearance)
    "Load theme, taking current system APPEARANCE into consideration."
    (mapc #'disable-theme custom-enabled-themes)
    (pcase appearance
      ('light (if (display-graphic-p) (ef-themes-load-random 'light) (ef-themes-load-random 'dark)))
      ('dark (ef-themes-load-random 'dark))))

  (if (eq system-type 'darwin)
      ;; only for emacs-plus
      (add-hook 'ns-system-appearance-change-functions #'my/apply-theme)
    ;;(ef-themes-select 'ef-summer)
    )
  )
;; doom用的图标
(use-package nerd-icons
  :ensure t)


;; modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :init
  (setq doom-modeline-icon t
        doom-modeline-window-width-limit 110
        doom-modeline-buffer-file-name-style 'auto
        doom-modeline-time-icon t
        doom-modeline-time t
        doom-modeline-buffer-name t
        doom-modeline-enable-word-count nil
        doom-modeline-workspace-name t
        doom-modeline-modal-icon t
        doom-modeline-minor-modes t)
  )


(use-package hide-mode-line
  :hook (((completion-list-mode
       completion-in-region-mode
       eshell-mode shell-mode
       term-mode vterm-mode
       treemacs-mode
       lsp-ui-imenu-mode
       pdf-annot-list-mode) . hide-mode-line-mode)))

;; A minor-mode menu for mode-line
(use-package minions
  :hook (doom-modeline-mode . minions-mode))

;; 图标设置
(use-package all-the-icons
  :ensure t
  :when (display-graphic-p)
  :commands all-the-icons-install-fonts
  )

;; 高亮当前行
(global-hl-line-mode)
;; 匹配括号
(show-paren-mode)

;; buffer menu替代
(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer)
  :init (setq ibuffer-filter-group-name-face '(:inherit (font-lock-string-face bold)))
  :config
  ;; Display icons for buffers
  (use-package nerd-icons-ibuffer
    :hook (ibuffer-mode . nerd-icons-ibuffer-mode)
    :init (setq nerd-icons-ibuffer-icon t))

  (with-eval-after-load 'counsel
    (with-no-warnings
      (defun my-ibuffer-find-file ()
        (interactive)
        (let ((default-directory (let ((buf (ibuffer-current-buffer)))
                                   (if (buffer-live-p buf)
                                       (with-current-buffer buf
                                         default-directory)
                                     default-directory))))
          (counsel-find-file default-directory)))
      (advice-add #'ibuffer-find-file :override #'my-ibuffer-find-file)))
  )

;; Group ibuffer's list by project
(use-package ibuffer-project
  :hook (ibuffer . (lambda ()
                     (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
                     (unless (eq ibuffer-sorting-mode 'project-file-relative)
                       (ibuffer-do-sort-by-project-file-relative))))
  :init (setq ibuffer-project-use-cache t)
  :config
  (add-to-list 'ibuffer-project-root-functions '(file-remote-p . "Remote"))
  (add-to-list 'ibuffer-project-root-functions '("\\*.+\\*" . "Default")))


(provide 'init-ui)
