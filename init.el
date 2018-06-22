;;emacs 主配置文件

;;路径设置
(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'better-defaults)

(require 'init-elpa)

(require 'init-exec-path)

(require 'init-misc)

(require 'init-func)

(require 'init-compat)

(require 'init-org)

(require 'server)

(unless (server-running-p)
  (server-start))

(require 'init-custom-key)

(require 'init-theme)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (htmlize window-numbering doom-themes php-mode which-key expand-region reveal-in-osx-finder popwin move-text))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
