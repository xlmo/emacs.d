;; (require 'cl)

;; ;;当你选中一段文字 之后输入一个字符会替换掉你选中部分的文字
;; (delete-selection-mode 1)
;; ;;关闭自动保存文件
(setq auto-save-default nil)
;; ;;关闭备份文件
(setq make-backup-files nil)

;; ;;关闭警告音
(setq ring-bell-function 'ignore)

(fset 'yes-or-no-p 'y-or-n-p)

;; (setq dired-dwin-target 1)
;; ;;高亮当前行
(global-hl-line-mode 1)

(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))


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

(provide 'init-misc)
