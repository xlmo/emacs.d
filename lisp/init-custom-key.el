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


(provide 'init-custom-key)
