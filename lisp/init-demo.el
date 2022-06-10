;; 这里用来做新包或新配置的试验地

(add-to-list 'load-path "~/.emacs.d/elisp/lsp-bridge")
(require 'lsp-bridge)
(global-lsp-bridge-mode)

(provide 'init-demo)
