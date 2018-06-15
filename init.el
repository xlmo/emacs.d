;;emccs 主配置文件

;;路径设置
(defvar root-path "~/.emacs.d")
(defvar site-lisp-path (expand-file-name  "lisp" root-path))

(add-to-list 'load-path site-lisp-path)

(require 'init-elpa)

(require 'better-defaults)

(require 'init-func)


(require 'init-compat)


;(require 'init-org)

(require 'server)

(unless (server-running-p)
  (server-start))


(require 'init-custom-key)

