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

;;显示当前组合键下的全部组合
(require 'which-key)
(which-key-mode)

(provide 'init-misc)
