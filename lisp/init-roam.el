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
  (setq org-roam-capture-templates
        `(("d" "Main" plain
           "%?"
           :target
           (file+head
            "Main/${slug}.org"
            "#+title: ${title}\n\n")
           :unnarrowed t)
          ("p" "Porject" plain
           "%?"
           :target
           (file+head
            "Project/${slug}.org"
            "#+title: ${title}\n\n")
           :unnarrowed t)
          ("c" "Extract" plain
           (file ,(concat xlmo-note-dir "/Template/extract.org"))
           :target
           (file+head
            "Extract/${slug}.org"
            "#+title: ${title}\n\n")
           :unnarrowed t)
          ("t" "问题排查" plain
           (file ,(concat xlmo-note-dir "/Template/trouble_shooting.org"))
           :target
           (file+head "trace:${slug}.org"
                      "#+title: ${title}\n\n")
           :unnarrowed t)))
  ;; 显示笔记类型
  (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
        (file-name-nondirectory
         (directory-file-name
          (file-name-directory
           (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (error "")))
  (setq org-roam-node-display-template
        (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

  ;; (add-to-list 'org-agenda-files (format "%s/%s" org-roam-directory "roam"))
  (org-roam-db-autosync-enable))






(provide 'init-roam)
