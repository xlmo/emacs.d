;; web
;; #+UPDATED_AT:2023-05-07T21:05:12+0800

;; CSS
(use-package css-mode
  :ensure nil
  :init (setq css-indent-offset 2))

;; JSON
(unless (fboundp 'js-json-mode)
  (use-package json-mode))

(use-package js2-mode
  :mode (("\\.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode))
  :interpreter (("node" . js2-mode)
                ("node" . js2-jsx-mode))
  :hook ((js2-mode . js2-imenu-extras-mode)
         (js2-mode . js2-highlight-unused-variables-mode))
  :config

  (with-eval-after-load 'flycheck
    (when (or (executable-find "eslint_d")
              (executable-find "eslint")
              (executable-find "jshint"))
      (setq js2-mode-show-strict-warnings nil))))

(use-package typescript-mode
  :mode ("\\.ts[x]\\'" . typescript-mode))

;; Major mode for editing web templates
(use-package web-mode
  :mode "\\.\\(phtml\\|php\\|[gj]sp\\|as[cp]x\\|erb\\|djhtml\\|html?\\|hbs\\|ejs\\|jade\\|swig\\|tm?pl\\|vue\\)$"
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))


(use-package haml-mode)
(use-package php-mode)

(use-package go-mode)
(use-package yaml-mode)
(use-package es-mode)
(use-package magit)



(provide 'init-develop)
