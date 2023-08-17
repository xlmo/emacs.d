;; org-roam

(use-package org-roam
  :diminish
  :defines org-roam-graph-viewer
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("<f6>" . org-roam-dailies-capture-today)
         ("<f5>" . org-roam-dailies-capture-yesterday)
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
        `(("i" "Inbox - Main" plain
           "%?"
           :target
           (file+head
            "Inbox/${slug}.org"
            "#+title: ${title}\n\n")
           :unnarrowed t)
          ("p" "P.A.R.A. - Project " plain
           "%?"
           :target
           (file+head
            "PARA-Project/${slug}.org"
            "#+title: ${title}\n\n")
           :unnarrowed t)
          ("a" "P.A.R.A. - Area " plain
           "%?"
           :target
           (file+head
            "PARA-Area/${slug}.org"
            "#+title: ${title}\n\n")
           :unnarrowed t)
          ("r" "P.A.R.A. - Resource " plain
           "%?"
           :target
           (file+head
            "PARA-Resource/${slug}.org"
            "#+title: ${title}\n\n")
           :unnarrowed t)
          ("t" "Inbox - Trouble" plain
           (file ,(concat xlmo-note-dir "/Template/trouble_shooting.org"))
           :target
           (file+head
            "Inbox/trace_${slug}.org"
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


(use-package org-roam-ui
  :after org-roam
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))



(provide 'init-roam)
