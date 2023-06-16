;; init-emacs.el
;; emacs -Q -l init-mini.el

(setq package-enable-at-startup nil)
(setq package-archives
      '(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("nongnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")))
;; 指定包临时下载目录
(setq package-user-dir "~/.emacs.d/tmp_elpa")
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package quelpa-use-package)

;; 1. 添加要测试的包的配置, use-package 用法参见 https://github.com/jwiegley/use-package
;; 测试 melpa, gnu, nongnu上的包，如下，包会自动安装。
;; (use-package xxx
;;  :config
;;  xxx
;;  )

;; 测试 github 上的包，比如 copilot，如下填写github repo地址，包会自动下载安装。
;; (use-package copilot
;;  :quelpa (copilot :fetcher github :repo "zerolfx/copilot.el"
;;                   :files ("*"))
;;  :config
;;  xxx
;;  )

;; 测试本地路径下的包。先通过git 将github上的包克隆到本地，在load-path 中填写包的路径。
;; (use-package xxx
;;  :load-path "path-to-package"
;;  :config
;;  xxx
;;  )

;; 测试任何你想测试的。直接将配置加在下面

;; 2. 运行 emacs -Q -l init-mini.el
