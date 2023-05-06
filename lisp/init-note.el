;; 笔记
;; #+UPDATED_AT:2023-05-06T17:05:21+0800

(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode-in-directories)
  :bind (("C-c n n" . denote)
         ("C-c n d" . denote-date)
         ("C-c n t" . denote-type)
         ("C-c n s" . denote-subdirectory)
         ("C-c n o" . denote-open-or-create)
         ("C-c n r" . denote-dired-rename-file))
  :config
  (setq denote-directory (expand-file-name "Note/" xlmo-note-dir))
  (setq denote-known-keywords '("技术" "摘抄" "阅读" "学习" "工作" "个人"))
  (setq denote-infer-keywords t)
  (setq denote-sort-keywords t)
  ;; org is default, set others such as text, markdown-yaml, markdown-toml
  (setq denote-file-type nil)
  (setq denote-prompts '(title keywords))

  ;; We allow multi-word keywords by default.  The author's personal
  ;; preference is for single-word keywords for a more rigid workflow.
  (setq denote-allow-multi-word-keywords t)
  (setq denote-date-format nil)

  ;; If you use Markdown or plain text files (Org renders links as buttons
  ;; right away)
  (add-hook 'find-file-hook #'denote-link-buttonize-buffer)
  (setq denote-dired-rename-expert nil)

  ;; OR if only want it in `denote-dired-directories':
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)
  )


(use-package consult-notes
  :commands (consult-notes
             consult-notes-search-in-all-notes)
  :bind ("C-c n f" . consult-notes)
  :config
  (setq consult-notes-file-dir-sources
        '(
          ;;          ("denote" ?d ,(concat xlmo-note-dir "/Note/"))
          ("denote" ?d  '(xlmo-note-dir))
          ))
  (consult-notes-org-headings-mode)
  (when (locate-library "denote")
    (consult-notes-denote-mode))
  )

(setq consult-notes-file-dir-sources
      '(
        ("denote" ?d '(expand-file-name xlmo-note-dir "/Note/"))

        ))
(provide 'init-note)
