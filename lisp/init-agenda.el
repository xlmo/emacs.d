
(global-set-key "\C-ca" 'org-agenda)


(setq org-agenda-include-diary t)
(setq org-agenda-insert-diary-extract-time t)
(setq org-agenda-inhibit-startup t)

(setq org-agenda-span 'day)
(setq org-agenda-window-setup 'current-window)
(setq org-agenda-include-diary nil)
(setq org-agenda-remove-tags t)
(setq org-agenda-columns-add-appointments-to-effort-sum t)
(setq org-agenda-restore-windows-after-quit t)

(setq org-agenda-todo-ignore-scheduled t)
(setq org-agenda-todo-ignore-deadlines t)
(setq org-agenda-time-leading-zero nil)

(setq org-agenda-todo-list-sublevels t)
(setq org-agenda-todo-ignore-scheduled t)

(setq org-agenda-time-grid
      '((daily today require-timed)
        (800 1000 1200 1400 1600 1800 2000)
        ""
        "----------------"))

(setq  org-agenda-current-time-string
       "now - - - - - - - - - - - - -")

  ;; Set it to 'auto can not work well for Chinese user.
;(setq org-agenda-tags-column -120)
;;(setq org-agenda-tags-column 'auto)
;(setq org-agenda-align-tags-to-column -80)

(setq org-agenda-prefix-format
      '((agenda  . " %i %-10:c %5t %s")
        (todo  . " %i %-10:c ")
        (tags  . " %i %-10:c ")
        (search . " %i %-10:c ")))

(setq org-agenda-scheduled-leaders
      '("预 " "应%02d天前开始 "))

(setq org-agenda-deadline-leaders
      '("止 " "过%02d天后到期 " "已经过期%02d天 "))

(setq org-agenda-format-date 'eh-org-agenda-format-date-aligned)
(defun eh-org-agenda-format-date-aligned (date)
    (require 'cal-iso)
    (let* ((dayname (calendar-day-name date))
           (day (cadr date))
           (day-of-week (calendar-day-of-week date))
           (month (car date))
           (monthname (calendar-month-name month))
           (year (nth 2 date))
           (iso-week (org-days-to-iso-week
                      (calendar-absolute-from-gregorian date)))
           (weekyear (cond ((and (= month 1) (>= iso-week 52))
                            (1- year))
                           ((and (= month 12) (<= iso-week 1))
                            (1+ year))
                           (t year)))
           (cn-date (calendar-chinese-from-absolute
                     (calendar-absolute-from-gregorian date)))
           (cn-year (cadr cn-date))
           (cn-month (cl-caddr cn-date))
           (cn-day (cl-cadddr cn-date))
           (cn-month-name
            ["正月" "二月" "三月" "四月" "五月" "六月"
             "七月" "八月" "九月" "十月" "冬月" "腊月"])
           (cn-day-name
            ["初一" "初二" "初三" "初四" "初五" "初六" "初七" "初八" "初九" "初十"
             "十一" "十二" "十三" "十四" "十五" "十六" "十七" "十八" "十九" "二十"
             "廿一" "廿二" "廿三" "廿四" "廿五" "廿六" "廿七" "廿八" "廿九" "三十"
             "卅一" "卅二" "卅三" "卅四" "卅五" "卅六" "卅七" "卅八" "卅九" "卅十"])
           (extra (format "(%s%s%s%s)"
                          (if (or (eq org-agenda-current-span 'day)
                                  (= day-of-week 1)
                                  (= cn-day 1))
                              (aref cn-month-name (1-  (floor cn-month)))
                            "")
                          (if (or (= day-of-week 1)
                                  (= cn-day 1))
                              (if (integerp cn-month) "" "[闰]")
                            "")
                          (aref cn-day-name (1- cn-day))
                          (if (or (= day-of-week 1)
                                  (eq org-agenda-current-span 'day))
                              (format "，第%02d周" iso-week)
                            ""))))
      (format "%04d-%02d-%02d %s %s"
              year month day dayname extra)))

(provide 'init-agenda)
