;;emacs 主配置文件

(let (;; 加载的时候临时增大`gc-cons-threshold'以加速启动速度。
      (gc-cons-threshold most-positive-fixnum)
      ;; 清空避免加载远程文件的时候分析文件。
      (file-name-handler-alist nil))

    ;; Emacs配置文件内容写到下面.

  )

;;路径设置
(add-to-list 'load-path "~/.emacs.d/lisp/")


;; 包管理
(require 'init-elpa)

;; 所需扩展包
(require 'init-packages)


;; (require 'init-exec-path)

(require 'init-func)

(require 'init-compat)

;; (require 'init-org)

;; (require 'server)

;; (unless (server-running-p)
;;  (server-start))

;(require 'init-custom-key)

(require 'init-theme)

(require 'init-misc)

;; 自定义文件
(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)  ;; 如果文件不存在
  (write-region "" nil custom-file)) ;; 创建文件
(load custom-file)

;; (require 'init-pyim)
