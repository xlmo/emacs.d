(let (;; 加载的时候临时增大`gc-cons-threshold'以加速启动速度。
      (gc-cons-threshold most-positive-fixnum)
      ;; 清空避免加载远程文件的时候分析文件。
      (file-name-handler-alist nil))

    ;; Emacs配置文件内容写到下面.

  )

;; 提升 IO 性能。
(setq process-adaptive-read-buffering nil)
;; 增加单次读取进程输出的数据量（缺省 4KB) 。
(setq read-process-output-max (* 4 1024 1024))

;; 提升长行处理性能。
(setq bidi-inhibit-bpa t)
(setq-default bidi-display-reordering 'left-to-right)
(setq-default bidi-paragraph-direction 'left-to-right)

;; 缩短 fontify 时间。
(setq jit-lock-defer-time nil)
(setq jit-lock-context-time 0.1)
;; 更积极的 fontify 。
(setq fast-but-imprecise-scrolling nil)
(setq redisplay-skip-fontification-on-input nil)

;; 缩短更新 screen 的时间。
(setq idle-update-delay 0.1)

;; 使用字体缓存，避免卡顿。
(setq inhibit-compacting-font-caches t)

;; Garbage Collector Magic Hack
;; (use-package gcmh
;;   :demand
;;   :init
;;   ;; 在 minibuffer 显示 GC 信息。
;;   ;;(setq garbage-collection-messages t)
;;   ;;(setq gcmh-verbose t)
;;   (setq gcmh-idle-delay 5)
;;   (setq gcmh-high-cons-threshold (* 64 1024 1024))
;;   (gcmh-mode 1)
;;   (gcmh-set-high-threshold))

(provide 'init-tuning)
