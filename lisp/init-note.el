;; 笔记

;; https://protesilaos.com/emacs/denote
(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode-in-directories)
  :bind (("C-c n n" . denote)
         ("C-c n d" . denote-date)
         ("C-c n t" . denote-create-note-with-template)
         ("C-c n s" . denote-subdirectory)
         ("C-c n o" . denote-open-or-create)
         ("C-c n r" . denote-dired-rename-file))
  :init
  ;;   (setq denote-org-front-matter
  ;;         "#+title:      %s
  ;; #+date:       %s
  ;; #+filetags:   %s
  ;; #+identifier: %s
  ;; #+UPDATED_AT: %s
  ;; \n")
  :config
  (setq denote-directory (expand-file-name "Note/" xlmo-note-dir))
  (setq denote-known-keywords '("技术" "摘抄" "阅读" "学习" "工作" "个人" "游戏" "问题排查"))
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
  ;; 设置模板
  (setq denote-templates
        `((trouble_shooting . ,(concat "* *[问题]*" ;; 问题排查模板
                                       "\n\n"
                                       "* *[问题来源]*"
                                       "\n\n"
                                       "* *[版本]*"
                                       "\n\n"
                                       "* *[定位历程]*"
                                       "\n\n"
                                       "* *[原因]*"
                                       "\n\n"
                                       "* *[如何发现]*"
                                       "\n\n"
                                       "* *[如何修复]*"
                                       "\n\n"
                                       "* *[遗留问题]*"
                                       "\n\n"
                                       "* *[总结]*"
                                       "\n\n"
                                       "* *[追问]*"
                                       "\n\n"
                                       "* *[关联问题]*"
                                       "\n\n"
                                       "* *[参考资料]*"
                                       "\n\n"
                                       "* *[关键词]*"
                                       "\n\n"))
          (demo . "* Some heading\n\n* Another heading")))

  ;; OR if only want it in `denote-dired-directories':
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)
  )
;; https://orgmode.org/manual/Initial-visibility.html
;; startup : overview | content | showall | show2levels | show3levels | show4levels | show5levels | showeverything

(use-package consult-notes
  :commands (consult-notes
             consult-notes-search-in-all-notes)
  :bind ("C-c n f" . consult-notes)
  :config
  (setq consult-notes-file-dir-sources
        `(
          ("Denote"  ?d ,(expand-file-name "Note" xlmo-note-dir))))
  (consult-notes-org-headings-mode)
  (when (locate-library "denote")
    (consult-notes-denote-mode))
  )

(provide 'init-note)
