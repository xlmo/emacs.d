;; lsp-bridge

(use-package posframe)

(add-to-list 'load-path (expand-file-name "module/lsp-bridge"  user-emacs-directory))

(require 'yasnippet)
(yas-global-mode 1)

(require 'lsp-bridge)

(if sys/win32p
    (setq lsp-bridge-python-command "python.exe"))

(global-lsp-bridge-mode)

(provide 'init-lsp)
