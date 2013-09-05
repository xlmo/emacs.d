;;emccs 主配置文件

;;路径设置
(defvar root-path "~/.emacs.d")
(defvar site-lisp-path (expand-file-name  "site-lisp" root-path))

(add-to-list 'load-path root-path)

; Which functionality to enable (use t or nil for true and false)
(defconst *spell-check-support-enabled* nil)
(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-carbon-emacs* (eq window-system 'mac))
(defconst *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))

(require 'init-elpa)

(setq multi-term-program "/bin/bash")
(setq multi-term-dedicated-select-after-open-p t)

(require 'init-func)

(require 'init-w3m)

(require 'init-misc)

(require 'init-org)

(require 'init-develop)

;; ;(load-theme 'zenburn t)

(require 'weibo)

(require 'server)

(unless (server-running-p)
  (server-start))

;(require 'init-mew)

(require 'init-custom-key)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("27470eddcaeb3507eca2760710cc7c43f1b53854372592a3afa008268bcf7a75" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(safe-local-variable-values (quote ((eval when (fboundp (quote rainbow-mode)) (rainbow-mode 1)))))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
