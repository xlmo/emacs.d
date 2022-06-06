
(global-set-key "\C-ca" 'org-agenda)

(setq org-agenda-files
      (list org-task-file
            org-journal-dir
            org-notes-dir
            org-technology-notes-dir
            org-capture-file
            org-inbox-file
            ))
(setq org-agenda-include-diary t)



(provide 'init-agenda)
