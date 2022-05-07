;; 综合设置

;;当你选中一段文字 之后输入一个字符会替换掉你选中部分的文字
(delete-selection-mode 1)
;;关闭自动保存文件
(setq auto-save-default nil)
;;关闭备份文件
(setq make-backup-files nil)

;;关闭警告音
(setq ring-bell-function 'ignore)
;; 简化yes or no 的回答
(fset 'yes-or-no-p 'y-or-n-p)


;;高亮当前行
(global-hl-line-mode 1)

;; 显示行号
(global-display-line-numbers-mode 1)

;; title 显示文件全路径
(setq frame-title-format
      '((:eval( if (buffer-file-name)
                  (abbreviate-file-name (buffer-file-name))
                "%b"))))

;; 更改光标样式
(setq-default cursor-type 'bar)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; 翻页之后光标位置不变
(setq scroll-preserve-screen-position t)




;; 编码设置 来源自purcell
(defun sanityinc/utf8-locale-p (v)
  "Return whether locale string V relates to a UTF-8 locale."
  (and v (string-match "UTF-8" v)))

(defun sanityinc/locale-is-utf8-p ()
  "Return t iff the \"locale\" command or environment variables prefer UTF-8."
  (or (sanityinc/utf8-locale-p (and (executable-find "locale") (shell-command-to-string "locale")))
      (sanityinc/utf8-locale-p (getenv "LC_ALL"))
      (sanityinc/utf8-locale-p (getenv "LC_CTYPE"))
      (sanityinc/utf8-locale-p (getenv "LANG"))))

(when (or window-system (sanityinc/locale-is-utf8-p))
  (set-language-environment 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system (if (eq system-type 'windows-nt) 'utf-16-le 'utf-8))
  (prefer-coding-system 'utf-8))

;; 设置字体大小
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;;(set-face-attribute 'default nil :height 90)

;; 更好的滚动
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)


;; 统一管理弹出窗口
(use-package popper
  :ensure t ; or :straight t
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1)) 

;; ;;保存窗口布局
;; (desktop-save-mode t)
;; ;;启动时加载布局
;; (setq desktop-dir "~/.emacs.d")
;; (desktop-read desktop-dir)

;; ;;用M-数字键来切换窗口
;; (require 'window-numbering)
;; (window-numbering-mode 1)

;; ;; eshell path
;; (add-hook 'eshell-mode-hook 'eshell-mode-hook-func)

;; ;; 自动重新加载已修改文件
;; (global-auto-revert-mode t)


;; 显示菜单栏
(menu-bar-mode 1)

;; dired 大小用KB/MB/GB来显示
(setq dired-listing-switches "-alh")

(provide 'init-misc)
