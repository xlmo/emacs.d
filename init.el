;;emacs 主配置文件

(let (
      ;; 加载的时候临时增大`gc-cons-threshold'以加速启动速度。
      (gc-cons-threshold most-positive-fixnum)
      ;; 清空避免加载远程文件的时候分析文件。
      (file-name-handler-alist nil))
  ;; (require 'benchmark-init-modes)
  ;; (require 'benchmark-init)
  ;; (benchmark-init/activate)


  ;; 自定义文件
  (setq custom-file "~/.emacs.d/custom.el")
  (unless (file-exists-p custom-file)  ;; 如果文件不存在
    (write-region "" nil custom-file)) ;; 创建文件
  (load custom-file)


  ;;路径设置
  (add-to-list 'load-path "~/.emacs.d/lisp/")
  (add-to-list 'load-path "~/.emacs.d/elisp/")

  (with-temp-message ""
    (require 'init-accelerate) ;; 加速
    (require 'init-elpa) ;; 包管理
    (require 'init-func)
    (require 'init-compat)
    (require 'init-func)
    (require 'init-agenda)
    (require 'init-theme)
    (require 'init-misc)
    (require 'init-demo)
    )

  ;; 可以延后加载的
  (run-with-idle-timer
   1 nil
   #'(lambda ()
       (require 'init-packages) ;; 所需扩展包
       (require 'init-calendar)
       (require 'init-lsp)
       (require 'init-pyim)  
       (require 'init-org)
       (require 'init-custom-key)
       )))


