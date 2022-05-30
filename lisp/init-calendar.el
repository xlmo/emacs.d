
(require 'cal-china-x)
(setq mark-holidays-in-calendar t)
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
(setq calendar-holidays
      (append cal-china-x-important-holidays
              cal-china-x-general-holidays
              ))

;; ;; ;; 除去基督徒、希伯来和伊斯兰教的节日。
(setq christian-holidays nil
      hebrew-holidays nil
      islamic-holidays nil
      solar-holidays nil
      bahai-holidays nil)


;; 获取经纬度：https://www.latlong.net/
(setq calendar-latitude +28.228209)
(setq calendar-longitude +112.938812)
(setq calendar-location-name "长沙")
(setq calendar-remove-frame-by-deleting t)

;; (setq calendar-remove-frame-by-deleting t)

;; ;; ; 每周第一天是周一。
(setq calendar-week-start-day 1)
;; ;; ;; 标记有记录的日期。
(setq mark-diary-entries-in-calendar t)
;; ;; ;; 不显示节日列表。
(setq view-calendar-holidays-initially nil)

(setq mark-diary-entries-in-calendar t
      appt-issue-message nil
      mark-holidays-in-calendar t
      view-calendar-holidays-initially nil)

(setq diary-date-forms '((year "/" month "/" day "[^/0-9]"))
      calendar-date-display-form '(year "/" month "/" day)
      calendar-time-display-form '(24-hours ":" minutes (if time-zone " (") time-zone (if time-zone ")")))

;; (add-hook 'today-visible-calendar-hook 'calendar-mark-today)



;(autoload 'chinese-year "cal-china" "Chinese year data" t)

(provide 'init-calendar)
