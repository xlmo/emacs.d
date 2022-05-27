;;emacs 主配置文件

;; 自定义文件
(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)  ;; 如果文件不存在
  (write-region "" nil custom-file)) ;; 创建文件
(load custom-file)


;;路径设置
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/elisp/")


;; 包管理
(require 'init-elpa)


;; 所需扩展包
(require 'init-packages)

;; 性能优化
(require 'init-tuning)

;; (require 'init-exec-path)

(require 'init-func)

(require 'init-compat)

(require 'init-func)

(require 'init-org)

;; (require 'server)

;; (unless (server-running-p)
;;  (server-start))

(require 'init-custom-key)

(require 'init-theme)

(require 'init-misc)



;; (require 'init-pyim)
