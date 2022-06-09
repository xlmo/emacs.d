(use-package parse-time
  :after org-agenda
  :ensure nil
  :config

  (setq parse-time-months
        (append '(("yiy" . 1) ("ery" . 2) ("sany" . 3)
                  ("siy" . 4) ("wuy" . 5) ("liuy" . 6)
                  ("qiy" . 7) ("bay" . 8) ("jiuy" . 9)
                  ("shiy" . 10) ("shiyiy" . 11) ("shiery" . 12)
                  ("yiyue" . 1) ("eryue" . 2) ("sanyue" . 3)
                  ("siyue" . 4) ("wuyue" . 5) ("liuyue" . 6)
                  ("qiyue" . 7) ("bayue" . 8) ("jiuyue" . 9)
                  ("shiyue" . 10) ("shiyiyue" . 11) ("shieryue" . 12))
                parse-time-months))

  (setq parse-time-weekdays
        (append '(("zri" . 0) ("zqi" . 0)
                  ("zyi" . 1) ("zer" . 2) ("zsan" . 3)
                  ("zsi" . 4) ("zwu" . 5) ("zliu" . 6)
                  ("zr" . 0) ("zq" . 0)
                  ("zy" . 1) ("ze" . 2) ("zs" . 3)
                  ("zsi" . 4) ("zw" . 5) ("zl" . 6))
                parse-time-weekdays)))

;; 日历
(use-package cal-china-x
  :after org-agenda
  :ensure nil
  :config
  (defvar eh-calendar-holidays nil)
  (setq eh-calendar-holidays
        '(;;公历节日
          (holiday-fixed 1 1 "元旦")
          (holiday-fixed 2 14 "情人节")
          (holiday-fixed 3 8 "妇女节")
          (holiday-fixed 3 14 "白色情人节")
          (holiday-fixed 4 1 "愚人节")
          (holiday-fixed 5 1 "劳动节")
          (holiday-fixed 5 4 "青年节")
          (holiday-float 5 0 2 "母亲节")
          (holiday-fixed 6 1 "儿童节")
          (holiday-float 6 0 3 "父亲节")
          (holiday-fixed 9 10 "教师节")
          (holiday-fixed 10 1 "国庆节")
          (holiday-fixed 10 24 "程序员节")
          (holiday-fixed 12 25 "圣诞节")
          ;; 农历节日
          (holiday-lunar 1 1 "春节" 0)
          (holiday-lunar 1 2 "春节" 0)
          (holiday-lunar 1 3 "春节" 0)
          (holiday-lunar 1 15 "元宵节" 0)
          (holiday-solar-term "清明" "清明节")
          ;; (holiday-solar-term "小寒" "小寒")
          ;; (holiday-solar-term "大寒" "大寒")
          ;; (holiday-solar-term "立春" "立春")
          ;; (holiday-solar-term "雨水" "雨水")
          ;; (holiday-solar-term "惊蛰" "惊蛰")
          ;; (holiday-solar-term "春分" "春分")
          ;; (holiday-solar-term "谷雨" "谷雨")
          ;; (holiday-solar-term "立夏" "立夏")
          ;; (holiday-solar-term "小满" "小满")
          ;; (holiday-solar-term "芒种" "芒种")
          ;; (holiday-solar-term "夏至" "夏至")
          ;; (holiday-solar-term "小暑" "小暑")
          ;; (holiday-solar-term "大暑" "大暑")
          ;; (holiday-solar-term "立秋" "立秋")
          ;; (holiday-solar-term "处暑" "处暑")
          ;; (holiday-solar-term "白露" "白露")
          ;; (holiday-solar-term "秋分" "秋分")
          ;; (holiday-solar-term "寒露" "寒露")
          ;; (holiday-solar-term "霜降" "霜降")
          ;; (holiday-solar-term "立冬" "立冬")
          ;; (holiday-solar-term "小雪" "小雪")
          ;; (holiday-solar-term "大雪" "大雪")
          ;; (holiday-solar-term "冬至" "冬至")
          (holiday-lunar 5 5 "端午节" 0)
          (holiday-lunar 8 15 "中秋节" 0)
          (holiday-lunar 7 7 "七夕情人节" 0)
          (holiday-lunar 12 8 "腊八节" 0)
          (holiday-lunar 9 9 "重阳节" 0)))
  (setq calendar-holidays eh-calendar-holidays))

(use-package calendar
  :after org-agenda
  :ensure nil
  :config
  (setq calendar-week-start-day 0) ; 一周第一天，0表示星期天, 1表示星期一
  (setq calendar-month-name-array
        ["一月" "二月" "三月" "四月" "五月" "六月"
         "七月" "八月" "九月" "十月" "十一月" "十二月"])
  (setq calendar-day-name-array
        ["周日" "周一" "周二" "周三" "周四" "周五" "周六"])

  (defun eh-org-chinese-anniversary (year lunar-month lunar-day &optional mark)
    (if year
        (let* ((d-date (diary-make-date lunar-month lunar-day year))
               (a-date (calendar-absolute-from-gregorian d-date))
               (c-date (calendar-chinese-from-absolute a-date))
               (cycle (car c-date))
               (yy (cadr c-date))
               (y (+ (* 100 cycle) yy)))
          (diary-chinese-anniversary lunar-month lunar-day y mark))
      (diary-chinese-anniversary lunar-month lunar-day year mark))))

;(require 'cal-china-x)
;; (setq mark-holidays-in-calendar t)
;; (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
;; (setq calendar-holidays
;;       (append cal-china-x-important-holidays
;;               cal-china-x-general-holidays
;;               ))

;; ;; ;; ;; 除去基督徒、希伯来和伊斯兰教的节日。
;; (setq christian-holidays nil
;;       hebrew-holidays nil
;;       islamic-holidays nil
;;       solar-holidays nil
;;       bahai-holidays nil)


;; 获取经纬度：https://www.latlong.net/
(setq calendar-latitude +28.228209)
(setq calendar-longitude +112.938812)
(setq calendar-location-name "长沙")
(setq calendar-remove-frame-by-deleting t)




;; (setq calendar-remove-frame-by-deleting t)

;; ;; ; 每周第一天是周一。
;; (setq calendar-week-start-day 1)
;; ;; ;; ;; 标记有记录的日期。
;; (setq mark-diary-entries-in-calendar t)
;; ;; ;; ;; 不显示节日列表。
;; (setq view-calendar-holidays-initially nil)

;; (setq mark-diary-entries-in-calendar t
;;       appt-issue-message nil
;;       mark-holidays-in-calendar t
;;       view-calendar-holidays-initially nil)

;; (setq diary-date-forms '((year "/" month "/" day "[^/0-9]"))
;;       calendar-date-display-form '(year "/" month "/" day)
;;       calendar-time-display-form '(24-hours ":" minutes (if time-zone " (") time-zone (if time-zone ")")))

;; (add-hook 'today-visible-calendar-hook 'calendar-mark-today)



;(autoload 'chinese-year "cal-china" "Chinese year data" t)

(provide 'init-calendar)
