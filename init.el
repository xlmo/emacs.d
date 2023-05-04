;; 配置文件
;; #+UPDATED_AT:2023-05-04T18:05:39+0800

;;package 设置
(require 'package)
;; (setq package-archives
;;     '(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;;       ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
;;       ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))

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

;; 加载各模块化配置
;; 不要在`*message*'缓冲区显示加载模块化配置的信息
(with-temp-message ""
  (require 'init-base)
  (require 'init-edit)
  (require 'init-ui)
  (require 'init-window)
  (require 'init-misc)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(mwim ivy-hydra amx counsel rg popper ace-window markdown-toc markdown-mode nerd-icons-ibuffer ibuffer-project pretty-hydra hydra goto-char-preview goto-chg vundo expand-region all-the-icons doom-modeline ef-themes which-key helpful no-littering use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
