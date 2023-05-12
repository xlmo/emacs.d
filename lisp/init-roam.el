;; org-roam

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
  (setq org-roam-directory (file-truename (expand-file-name "Notes" xlmo-note-dir))
        ;; (setq org-roam-directory (file-truename "~/Temp/roam") ;; for test
        org-roam-dailies-directory (expand-file-name "Daily" xlmo-note-dir)
        ;; org-roam-dailies-directory (expand-file-name "Daily" org-roam-directory) ;; for test
        org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag))
        org-roam-graph-viewer (if (featurep 'xwidget-internal)
                                  #'xwidget-webkit-browse-url
                                #'browse-url)
        org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y>/%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))
  :config
  ;; (add-to-list 'org-agenda-files (format "%s/%s" org-roam-directory "roam"))
  (org-roam-db-autosync-enable))

(setq org-roam-capture-templates
      `(("d" "默认" plain
         "%?"
         :target
         (file+head
          "%<%Y%m%d%H%M%S>-${slug}.org"
          "#+title: ${title}\n\n")
         :unnarrowed t)
        ("p" "项目" plain
         "%?"
         :target
         (file+head
          "Project/${slug}.org"
          "#+title: ${title}\n\n")
         :unnarrowed t)
        ("c" "摘抄" plain
         "%?"
         :target
         (file+head
          "Extract/${slug}.org"
          "#+title: ${title}\n\n")
         :unnarrowed t)
        ("t" "问题排查" plain
         (file ,(concat xlmo-note-dir "/Template/trouble_shooting.org"))
         :target
         (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                    "#+title: ${title}\n\n")
         :unnarrowed t)))

;; (when emacs/>=27p
;;   (use-package org-roam-ui
;;     :bind ("C-c n u" . org-roam-ui-mode)
;;     :init (when (featurep 'xwidget-internal)
;;             (setq org-roam-ui-browser-function #'xwidget-webkit-browse-url))))

(provide 'init-roam)
