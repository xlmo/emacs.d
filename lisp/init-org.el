;; org
(global-set-key (kbd "C-c c") 'org-capture)

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

;; 默认展开两级
(setq org-startup-folded 'show2levels)

(setq org-startup-indented t)
(setq org-startup-indented t)
(setq org-fontify-todo-headline t)
(setq org-fontify-done-headline t)
(setq org-fontify-whole-heading-line t)
(setq org-fontify-quote-and-verse-blocks t)

(setq org-imenu-depth 4)
(setq org-clone-delete-id t)
(setq org-use-sub-superscripts '{})
(setq org-yank-adjusted-subtrees t)
(setq org-ctrl-k-protect-subtree 'error)
(setq org-catch-invisible-edits 'smart)
(setq org-insert-heading-respect-content t)
 ;; call C-c C-o explicitly
(setq org-return-follows-link nil)
(setq org-enforce-todo-checkbox-dependencies t)
;;1.当任务还有子任务未完成时，阻止任务从未完成状态到完成状态的改变
;;2.对基于 headline 的任务而言，若其上一级任务设置了 ":ORDERED:" 属性，则在其前面的同级任务完成前，无法被设置为完成状态
(setq org-enforce-todo-dependencies t)

;; ; 使用状态快捷键
(setq org-use-fast-todo-selection t)
;; 存储着作用于全局的状态序列
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "WAITING(w@/!)" "SOMEDAY(m@/!)" "SUSPEND(s@/!)" "DOING(i)"  "DONE(d)")
;              (sequence "PROJECT(p)" "|" "DONE(d)" "CANCELLED(c@/!)")
;              (sequence "BUG(b)" "|" "FIXED(f)")
;              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "MEETING")
              )))

;; ;定义进入状态和离开状态时的额外动作，可用的动作包含两个:
;; ; 1.添加笔记和状态变更信息(包括时间信息)，用"@"表示
;; ; 2.只添加状态变更信息，用"!"表示
(setq org-todo-keyword-faces
      (quote (("DOING" :foreground "red" :weight bold)
              ("SOMEDAY" :foreground "green" :weight bold)
              ("WAITING" :foreground "brown" :weight bold)
              ("SUSPEND" :foreground "gray" :weight bold)
;              ("DONE" :foreground "green" :weight bold)
              )))
;; (setq org-todo-keyword-faces
;;       (quote (("TODO" :foreground "red" :weight bold)
;;               ("NEXT" :foreground "blue" :weight bold)
;;               ("DONE" :foreground "forest green" :weight bold)
;;              ("WAITING" :foreground "orange" :weight bold)
;;               ("HOLD" :foreground "magenta" :weight bold)
;;               ("CANCELLED" :foreground "forest green" :weight bold)
;;               ("MEETING" :foreground "forest green" :weight bold)
;;               )))


;; (setq org-treat-S-cursor-todo-selection-as-state-change nil)



;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates nil)

(add-to-list 'org-capture-templates
	     '("t" "Task" entry (file+headline org-task-file "Task")
               "* TODO %?\n\n"))

(add-to-list 'org-capture-templates
             '("n" "Note" entry (file org-inbox-file)
               "* %?\n\n"))


(defun get-year-and-month ()
(list (format-time-string "%Y年") (format-time-string "%m月")))

(defun find-month-tree ()
  (let* ((path (get-year-and-month))
         (level 1)
         end)
    (unless (derived-mode-p 'org-mode)
      (error "Target buffer \"%s\" should be in Org mode" (current-buffer)))
    (goto-char (point-min))             ;移动到 buffer 的开始位置
    ;; 先定位表示年份的 headline，再定位表示月份的 headline
    (dolist (heading path)
      (let ((re (format org-complex-heading-regexp-format
                        (regexp-quote heading)))
            (cnt 0))
        (if (re-search-forward re end t)
            (goto-char (point-at-bol))  ;如果找到了 headline 就移动到对应的位置
          (progn                        ;否则就新建一个 headline
            (or (bolp) (insert "\n"))
            (if (/= (point) (point-min)) (org-end-of-subtree t t))
            (insert (make-string level ?*) " " heading "\n"))))
      (setq level (1+ level))
      (setq end (save-excursion (org-end-of-subtree t t))))
    (org-end-of-subtree)))


;; ; 代码高亮
;; (setq org-src-fontify-natively t)

;; ; 链接缩写
;; (setq org-link-abbrev-alist
;;       '(("google"   . "http://www.google.com/search?q=")
;;         ("dict" . "http://dict.cn/")))

;; ;记录todo完成时间
;; (setq org-log-done 'time)
;; ;记录todo完成备注
;; ;(setq org-log-done 'note)

;; (setq org-export-coding-system 'utf-8)


(setq org-journal-prefix-key "C-c j")
(use-package org-journal
  :demand
  :disabled
  :commands org-journal-new-entry
  :init
  (defun org-journal-save-entry-and-exit()
    (interactive)
    (save-buffer)
    (kill-buffer-and-window))
  :config
  (setq org-journal-file-type 'monthly)
  (setq org-journal-find-file 'find-file)
  (setq org-journal-date-format "%Y-%m-%d, %A")
  (setq org-journal-file-format "%Y-%m.org")

  ;; 加密 journal 文件。
;  (setq org-journal-enable-encryption t)
;  (setq org-journal-encrypt-journal t)
  ;; (defun my-old-carryover (old_carryover)
  ;;   (save-excursion
  ;;     (let ((matcher (cdr (org-make-tags-matcher org-journal-carryover-items))))
  ;;       (dolist (entry (reverse old_carryover))
  ;;         (save-restriction
  ;;           (narrow-to-region (car entry) (cadr entry))
  ;;           (goto-char (point-min))
  ;;           (org-scan-tags '(lambda ()
  ;;                             (org-set-tags ":carried:"))
  ;;                          matcher org--matcher-tags-todo-only))))))
  ;; (setq org-journal-handle-old-carryover 'my-old-carryover)

  ;; journal 文件头。
  (defun org-journal-file-header-func (time)
    "Custom function to create journal header."
    (concat
     (pcase org-journal-file-type
       (`daily "#+TITLE: Daily Journal\n#+STARTUP: showeverything")
       ;; (`weekly "#+TITLE: Weekly Journal\n#+STARTUP: folded")
       ;; (`monthly "#+TITLE: Monthly Journal\n#+STARTUP: overview")
       ;; (`yearly "#+TITLE: Yearly Journal\n#+STARTUP: folded")
      (`weekly (concat "#+TITLE: Weekly Journal - " (format-time-string "%Y-W%V") "\n#+STARTUP: folded"))
      (`monthly (concat "#+TITLE: Monthly Journal - " (format-time-string "%Y-%m") "\n#+STARTUP: overview"))
      (`yearly (concat "#+TITLE: Yearly Journal - " (format-time-string "%Y") "\n#+STARTUP: folded"))
       )))
  (setq org-journal-file-header 'org-journal-file-header-func)

  ;; org-agenda 集成。
  ;; automatically adds the current and all future journal entries to the agenda
  ;;(setq org-journal-enable-agenda-integration t)
  ;; When org-journal-file-pattern has the default value, this would be the regex.
  (setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
  (add-to-list 'org-agenda-files org-journal-dir)

  ;; org-capture 集成。
  (defun org-journal-find-location ()
    (org-journal-new-entry t)
    (unless (eq org-journal-file-type 'daily)
      (org-narrow-to-subtree))
    (goto-char (point-max)))
  (setq org-capture-templates
        (cons '("j" "Journal" plain (function org-journal-find-location)
                "** %(format-time-string org-journal-time-format)%^{Title}\n%i%?"
                :jump-to-captured t :immediate-finish t) org-capture-templates)))

(global-set-key (kbd "C-c C-j") 'org-journal-new-entry)
(global-set-key (kbd "C-c C-e") 'org-journal-save-entry-and-exit)


(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
;; 为 #+begin_quote 和  #+begin_verse 添加特殊 face 。
(setq org-fontify-quote-and-verse-blocks t)
;; 不自动缩进。
(setq org-src-preserve-indentation t)
(setq org-edit-src-content-indentation 0)
;; 在当前窗口编辑 SRC Block.
(setq org-src-window-setup 'current-window)


;; org 里执行代码
(require 'org)
(use-package ob-go)
(use-package ob-php)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (js . t)
   (go . t)
   (php . t)
   (emacs-lisp . t)
   (python . t)
   (dot . t)
   (css . t)))


;; 预览  `org-preview-html-mode`
(use-package org-preview-html)
;; 导出
(use-package ox-pandoc)

;; 导入图片
(use-package org-download
;  :ensure-system-package pngpaste
  :bind
;  ("<f6>" . org-download-screenshot)
  :config
  (setq-default org-download-image-dir org-static-images-file-dir)
  ;; 默认会将图片保存到所在 headline 为文件夹名称的目录下，下面的设置是取消这种行为
  (setq-default org-download-heading-lvl nil)
  (defun dummy-org-download-annotate-function (link)
  "")
  (setq org-download-annotate-function
      #'dummy-org-download-annotate-function)
  (setq org-download-method 'directory
        org-download-display-inline-images 'posframe
;        org-download-screenshot-method "pngpaste %s"
        org-download-image-attr-list '("#+ATTR_HTML: :width 400 :align center"))
  (add-hook 'dired-mode-hook 'org-download-enable)
  (org-download-enable))



;; 浏览器捕获
(require 'org-protocol)
(require 'org-capture)
(defun transform-square-brackets-to-round-ones(string-to-transform)
  "Transforms [ into ( and ] into ), other chars left unchanged."
  (concat
  (mapcar #'(lambda (c) (if (equal c ?[) ?\( (if (equal c ?]) ?\) c))) string-to-transform))
  )

;; (add-to-list 'org-capture-templates
;; 	     '("c" "Captured via org protocol" entry (file+headline org-capture-file "Inbox")
;;                "* %T %(transform-square-brackets-to-round-ones \"%:description\") \n link:%:link \n\n%i\n" :immediate-finish t))

;; refile
;; refile 的位置是 agenda 文件的前三层 headline 。
(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
;; 使用文件路径的形式显示 filename 和 headline, 方便在文件的 top-head 添加内容。
(setq org-refile-use-outline-path 'file)
;; 必须设置为 nil 才能显示 headline, 否则只显示文件名 。
(setq org-outline-path-complete-in-steps nil)
;; 支持为 subtree 在 refile target 文件指定一个新的父节点 。
(setq org-refile-allow-creating-parent-nodes 'confirm)


;; 归档设置
;(setq org-archive-location (concat org-directory "gtd/_archive/" (format-time-string "%Y%m") "_archive.org::datetree/* Archive from %s"))

;;information added to property when a subtree is moved
(setq org-archive-save-context-info '(time file ltags itags todo category olpath))


(setq org-agenda-files
      (list org-task-file
            ;; org-journal-dir             
            ;; org-capture-file
;;            org-inbox-file
            ))

;; head 美化
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; 修改默认省略号
(setq org-ellipsis "⤵")

(provide 'init-org)
