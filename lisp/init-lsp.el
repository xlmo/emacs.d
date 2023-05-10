;; #+TITLE: lsp
;; #+UPDATED_AT:2023-05-10T23:05:18+0800

(use-package posframe)

(add-to-list 'load-path (expand-file-name "module/lsp-bridge"  user-emacs-directory))

(require 'yasnippet)
(yas-global-mode 1)

(require 'lsp-bridge)

(if sys/win32p
    (setq lsp-bridge-python-command "python.exe"))

(global-lsp-bridge-mode)

(provide 'init-lsp)
