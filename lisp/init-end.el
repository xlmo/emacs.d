;; 最后加载的文件
;; 全局开启 company
(global-company-mode)

;; pyim 初始化 dbcaches 如果这里不初始化，而又没有使用过pyim的话，就无法使用 pyim-forward-word和 pyim-backward-word
;; (pyim-process-init-dcaches)

;; 隐藏modeline
;(setq-default mode-line-format nil)

(provide 'init-end)
