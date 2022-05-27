;; org

(setq org-directory (concat local-cloud-directory "OrgFiles/"))
(setq org-inbox-file (concat org-directory "inbox.org"))
(setq org-default-notes-file org-inbox-file)
(setq org-task-file (concat org-directory "task.org"))
(setq org-journals-file (concat org-directory "journals.org"))
(setq org-billing-file (concat org-directory "billing.org"))

;; 自动换行
(global-visual-line-mode 1) 
(global-set-key (kbd "C-c c") 'org-capture)


;; (require 'org-protocol)
;; (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

;; (global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)

;; (global-set-key (kbd "<f10>") 'org-agenda)
;; ;(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
;; (global-set-key (kbd "<f9> c") 'calendar)
;; (global-set-key (kbd "<f9> f") 'boxquote-insert-file)
;; (global-set-key (kbd "<f9> r") 'boxquote-region)
;; (global-set-key (kbd "<f9> v") 'visible-mode)
;; (global-set-key (kbd "<f9> l") 'org-toggle-link-display)
;; (global-set-key (kbd "C-<f9>") 'previous-buffer)
;; (global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
;; (global-set-key (kbd "C-x n r") 'narrow-to-region)
;; (global-set-key (kbd "C-<f10>") 'next-buffer)
;; (global-set-key (kbd "<f7>") 'org-clock-goto)
;; (global-set-key (kbd "C-<f7>") 'org-clock-in)

;; ; 使用状态快捷键
(setq org-use-fast-todo-selection t)
;; 存储着作用于全局的状态序列
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "DOING(i@/!)"  "DONE(d)")
;              (sequence "PROJECT(p)" "|" "DONE(d)" "CANCELLED(c@/!)")
;              (sequence "BUG(b)" "|" "FIXED(f)")
;              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "MEETING")
              )))

;; ;定义进入状态和离开状态时的额外动作，可用的动作包含两个:
;; ; 1.添加笔记和状态变更信息(包括时间信息)，用"@"表示
;; ; 2.只添加状态变更信息，用"!"表示

(setq org-todo-keyword-faces
      (quote (("DOING" :foreground "red" :weight bold))))

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

;;1.当任务还有子任务未完成时，阻止任务从未完成状态到完成状态的改变
;;2.对基于 headline 的任务而言，若其上一级任务设置了 ":ORDERED:" 属性，则在其前面的同级任务完成前，无法被设置为完成状态
(setq org-enforce-todo-dependencies t)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates nil)

(add-to-list 'org-capture-templates '("t" "Tasks"))
(add-to-list 'org-capture-templates
             '("tp" "Personal Task" entry (file+headline org-task-file "Personal Task")
               "* TODO %? :Personal:\n%U\n\n" :clock-in t :clock-resume t))
(add-to-list 'org-capture-templates
	     '("tw" "Work Task" entry (file+headline org-task-file "Work Task")
               "* TODO %? :Work:\n%U\n\n"))
(add-to-list 'org-capture-templates             
             '("j" "Journals" entry (file+datetree org-journals-file)
               "* %?\n\n"))
(add-to-list 'org-capture-templates             
             '("i" "Inbox" entry (file org-inbox-file)
               "* %?\n\n"))

(add-to-list 'org-capture-templates
             '("b" "Billing" plain
               (file+function org-billing-file  find-month-tree)
               " | %U | %^{类别} | %^{描述} | %^{金额} |" :kill-buffer t))


;; (add-to-list 'org-capture-templates '("l" "List")) ;
;; (add-to-list 'org-capture-templates
;; 	     '("l" "List(books,movie...etc)" entry (file+headline "~/Nutstore Files/OrgFiles/list.org" "List")
;;                "* %? %^g\n%U\n\n"))
;; (add-to-list 'org-capture-templates
;;              '("n" "note" entry (file "~/Nutstore Files/OrgFiles/inbox.org")
;;                "* %? :NOTE:\n%U\n\n" :clock-in t :clock-resume t))
;; (add-to-list 'org-capture-templates             
;;              '("c" "Collect Items" entry (file "~/Nutstore Files/OrgFiles/collect.org")
;;                "* TODO Review %^C\n%U\n" :immediate-finish t))


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
(setq org-log-done 'time)
;; ;记录todo完成备注
;; ;(setq org-log-done 'note) 


(setq org-agenda-files
      (list (concat org-directory "/task.org")
;;	    "~/Nutstore Files/OrgFiles/collect.org"
;;	    "~/Nutstore Files/OrgFiles/inbox.org"
            ))

;; ;自定义agenda快捷功能键
;; (setq org-agenda-custom-commands
;;       '(("p" tags-todo "+personal")
;;         ("w" tags-todo "+work")))

;; (setq org-export-coding-system 'utf-8)

(setq org-agenda-time-grid
      (quote ((daily today require-timed)
              (300 600 900 1200 1500 1800 2100 2400)
              "......"
              "-----------------------------------------------------"
              )))

(setq org-agenda-start-day "-7d")
(setq org-agenda-span 21)
(setq org-agenda-include-diary t)

;; 获取经纬度：https://www.latlong.net/
(setq calendar-latitude +28.228209)
(setq calendar-longitude +112.938812)
(setq calendar-location-name "长沙")
(setq calendar-remove-frame-by-deleting t)

(setq calendar-remove-frame-by-deleting t)

; 每周第一天是周一。
(setq calendar-week-start-day 1)
;; 标记有记录的日期。
(setq mark-diary-entries-in-calendar t)
;; 标记节假日。
(setq mark-holidays-in-calendar nil)
;; 不显示节日列表。
(setq view-calendar-holidays-initially nil)
(setq org-agenda-include-diary t)

;; 除去基督徒、希伯来和伊斯兰教的节日。
(setq christian-holidays nil
      hebrew-holidays nil
      islamic-holidays nil
      solar-holidays nil
      bahai-holidays nil)

(setq mark-diary-entries-in-calendar t
      appt-issue-message nil
      mark-holidays-in-calendar t
      view-calendar-holidays-initially nil)

(setq diary-date-forms '((year "/" month "/" day "[^/0-9]"))
      calendar-date-display-form '(year "/" month "/" day)
      calendar-time-display-form '(24-hours ":" minutes (if time-zone " (") time-zone (if time-zone ")")))

(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

(autoload 'chinese-year "cal-china" "Chinese year data" t)

;; (setq calendar-load-hook '(lambda ()
;;                             (set-face-foreground 'diary-face   "skyblue")
;;                             (set-face-background 'holiday-face "slate blue")
;;                             (set-face-foreground 'holiday-face "white")))

(use-package org-super-agenda)

(provide 'init-org)
