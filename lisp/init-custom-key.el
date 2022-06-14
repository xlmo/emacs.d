;;resize window
;; (global-set-key (kbd "M-s-<left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "M-s-<right>") 'enlarge-window-horizontally)
;; (global-set-key (kbd "M-s-<down>") 'shrink-window)
;; (global-set-key (kbd "M-s-<up>") 'enlarge-window)


;; Font size
;; (global-set-key (kbd "C-+") 'text-scale-increase)
;; (global-set-key (kbd "C--") 'text-scale-decrease)

;; 重复当前行
(global-set-key (kbd "C-c d") 'my-duplicate-current-line-or-region)


;; 移动行
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)



;; (global-set-key (kbd "M-o") 'copy-word)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; 关闭当前buffer
(global-set-key (kbd "s-w") 'kill-current-buffer)

;; 搜索
;; ;; 指定目录下搜索
(global-set-key [f5] 'xlmo/search-root-dir)
(global-set-key [f6] 'xlmo/search-work-dir)
(global-set-key [f7] 'xlmo/search-note-dir)
(global-set-key [f8] 'helm-do-ag)

;; 搜索所有buffer
(global-set-key [f10] 'helm-swoop)

;; 跳转匹配括号
(global-set-key (kbd "C-M-f") 'forward-list)
(global-set-key (kbd "C-M-b") 'backward-list)



(provide 'init-custom-key)
