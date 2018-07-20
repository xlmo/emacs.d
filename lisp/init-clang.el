(add-to-list 'load-path "~/.emacs.d/clang")
;;@link http://tuhdo.github.io/c-ide.html
(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)

(provide 'init-clang)
