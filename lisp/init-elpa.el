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
                      ;; 主题
                      doom-theme
                      ;; 窗口切换
                      window-numbering
                      htmlize
                      exec-path-from-shell
                      w3m
                      ;;　输入法
                      pyim
                      use-package
                      ;;c相关 start
                      zygospore
                      helm-gtags
                      helm yasnippet
                      ws-butler
                      volatile-highlights
                      undo-tree
                      iedit
                      dtrt-indent
                      counsel-projectile
                      company
                      clean-aindent-mode
                      anzu
                      helm-projectile
                      ;;c相关 end
                      ))

(package-initialize)
(provide 'init-elpa)
