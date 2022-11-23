;;resize window
;; (global-set-key (kbd "C-c l") 'shrink-window-horizontally)
;; (global-set-key (kbd "C-c h") 'enlarge-window-horizontally)
;; (global-set-key (kbd "C-c k") 'shrink-window)
;; (global-set-key (kbd "C-c j") 'enlarge-window)


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

;; 打开当日日志文件
(global-set-key [f7] 'xlmo/open-dialy-file)

;; 跳转匹配括号
(global-set-key (kbd "C-M-f") 'forward-list)
(global-set-key (kbd "C-M-b") 'backward-list)


;; 词典翻译
(global-set-key [f2] 'sdcv-search-pointer+)


(provide 'init-custom-key)
