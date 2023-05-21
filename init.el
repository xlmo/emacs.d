;;  init file

;;package 设置
(require 'package)
;; (setq package-archives
;;       '(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;;         ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
;;         ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))

(setq package-archives '(("gnu"    . "http://mirrors.bfsu.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.bfsu.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.bfsu.edu.cn/elpa/melpa/")))

;; 如果use-package没安装
(unless (package-installed-p 'use-package)
  ;; 更新本地缓存
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; 永远按需安装
(setq use-package-always-ensure t)


;; 将lisp目录放到加载路径的前面以加快启动速度
(let ((dir (locate-user-emacs-file "lisp")))
  (add-to-list 'load-path (file-name-as-directory dir)))

;; load custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; 加载各模块化配置
;; 不要在`*message*'缓冲区显示加载模块化配置的信息
(with-temp-message ""
  (require 'init-const)
  (require 'init-func)
  (require 'init-base)
  (require 'init-edit)
  (require 'init-window)
  (require 'init-ui)
  ;; (require 'init-company) ;; replace by lsp-bridge
  (require 'init-lsp)
  (require 'init-ivy)
  (require 'init-misc)
  (require 'init-develop)
  (require 'init-org)
  ;; (require 'init-note) ;; replace by org-roam
  (require 'init-roam)
  (require 'init-treemacs)
  ;; (require 'init-pyim) ;; 和counsel一起使用有问题，新建文件等场景下不能激活
  )
