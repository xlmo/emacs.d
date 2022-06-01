
(global-set-key "\C-ca" 'org-agenda)

(setq org-agenda-files
      (list org-task-file
            org-journal-dir
            ))
(setq org-agenda-include-diary t)



(provide 'init-agenda)
