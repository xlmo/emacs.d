(setq
 ;; 不要缩放frame.
 frame-inhibit-implied-resize t
 ;; 默认用最简单的模式
 initial-major-mode 'fundamental-mode
 ;; 不要自动启用package
 package-enable-at-startup nil
 package--init-file-ensured t
 ;; 提升 IO 性能。
 process-adaptive-read-buffering nil
 ;; 增加单次读取进程输出的数据量（缺省 4KB) 。
 read-process-output-max (* 1024 1024)
 ;; 提升长行处理性能。
 bidi-inhibit-bpa t
 ;; 缩短 fontify 时间。
jit-lock-defer-time nil
jit-lock-context-time 0.1
;; 更积极的 fontify 。
fast-but-imprecise-scrolling nil
redisplay-skip-fontification-on-input nil
;; 缩短更新 screen 的时间。
idle-update-delay 0.1
;; 使用字体缓存，避免卡顿。
inhibit-compacting-font-caches t
)

;; Disable garbage collection when entering commands.
(defun max-gc-limit ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun reset-gc-limit ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'max-gc-limit)
(add-hook 'minibuffer-exit-hook #'reset-gc-limit)

;; Improve the performance of rendering long lines.
(setq-default bidi-display-reordering nil)
(setq-default bidi-paragraph-direction 'left-to-right)

(provide 'init-accelerate)
