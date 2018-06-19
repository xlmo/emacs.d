;;elpa设置
(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
;;需要安装的包
(defvar my/packages '(
                      ;;上下移动文本
                      move-text
                      ;;自动将光标移动到新创建的窗口中
                      popwin
                      ;;macOS下在Finder中打开当前路径
                      reveal-in-osx-finder
                      ;;方便选择区域块C-=
                      expand-region
                      ;;显示当前组合键下的全部组合
                      which-key
		      php-mode
                      ))

(package-initialize)
(provide 'init-elpa)
