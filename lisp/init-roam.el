;; #+TITLE: org-roam
;; #+UPDATED_AT:2023-05-11T17:05:24+0800

(use-package org-roam
  :diminish
  :defines org-roam-graph-viewer
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today))
  :init
  (setq org-roam-directory (file-truename "~/Temp/roam") ;; for test
        org-roam-dailies-directory "daily/"
        org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag))
        org-roam-graph-viewer (if (featurep 'xwidget-internal)
                                  #'xwidget-webkit-browse-url
                                #'browse-url))
  :config
  (add-to-list 'org-agenda-files (format "%s/%s" org-roam-directory "roam"))
  (org-roam-db-autosync-enable))


;; (when emacs/>=27p
;;   (use-package org-roam-ui
;;     :bind ("C-c n u" . org-roam-ui-mode)
;;     :init (when (featurep 'xwidget-internal)
;;             (setq org-roam-ui-browser-function #'xwidget-webkit-browse-url))))

(provide 'init-roam)
