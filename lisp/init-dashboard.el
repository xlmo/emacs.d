
;; dashboard的可选功能
(use-package page-break-lines)

;; dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome to Emacs!")
  (setq dashboard-set-footer nil)
  (setq dashboard-items '((recents  . 9)
                          (bookmarks . 5)
                          (agenda . 6)))
  (setq dashboard-startup-banner 1))

(provide 'init-dashboard)
