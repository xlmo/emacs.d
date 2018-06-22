(require 'cl)

;;当你选中一段文字 之后输入一个字符会替换掉你选中部分的文字
(delete-selection-mode 1)
;;关闭自动保存文件
(setq auto-save-default nil)
;;关闭备份文件
(setq make-backup-files nil)

;;自动将光标移动到新创建的窗口中
(require 'popwin)
(popwin-mode 1)
;;关闭警告音
(setq ring-bell-function 'ignore)

(fset 'yes-or-no-p 'y-or-n-p)

(require 'dired-x)
;;当一个窗口（frame）中存在两个分屏 （window）时，将另一个分屏自动设置成拷贝地址的目标
(setq dired-dwin-target 1)
;;高亮当前行
(global-hl-line-mode 1)

(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;;显示当前组合键下的全部组合
(require 'which-key)
(which-key-mode)

;;保存窗口布局
(desktop-save-mode t)
;;启动时加载布局
(setq desktop-dir "~/.emacs.d")
(desktop-read desktop-dir)

;;用M-数字键来切换窗口
(require 'window-numbering)
(window-numbering-mode 1)

;; eshell path
(add-hook 'eshell-mode-hook 'eshell-mode-hook-func)

;; 自动重新加载已修改文件
(global-auto-revert-mode t)

(provide 'init-misc)
