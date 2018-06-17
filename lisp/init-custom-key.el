(global-set-key (kbd "C-x C-b") 'ibuffer)

;(global-set-key "\M-x" 'smex)

(global-set-key (kbd "M-/") 'hippie-expand)

(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Vimmy alternatives to M-^ and C-u M-^
(global-set-key (kbd "C-c j") 'join-line)
(global-set-key (kbd "C-c J") (lambda () (interactive) (join-line 1)))

(global-set-key (kbd "M-T") 'transpose-lines)
(global-set-key (kbd "C-.") 'set-mark-command)
(global-set-key (kbd "C-x C-.") 'pop-global-mark)


(global-unset-key [M-left])
(global-unset-key [M-right])

;;window jump
(global-set-key (kbd "s-k") 'windmove-up)
(global-set-key (kbd "s-j") 'windmove-down)
(global-set-key (kbd "s-h") 'windmove-left)
(global-set-key (kbd "s-l") 'windmove-right)

;;resize window
(global-set-key (kbd "M-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-s-<down>") 'shrink-window)
(global-set-key (kbd "M-s-<up>") 'enlarge-window)


;; Font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


(global-set-key (kbd "C-c d") 'my-duplicate-current-line-or-region)
(global-set-key (kbd "C-c k") 'my-kill-other-buffers)


;;move-text stuff, move line up/down by pressing hotkey
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)


(global-set-key (kbd "M-g o") 'golden-ratio-enable)
(global-set-key (kbd "M-g f") 'golden-ratio-disable)

(global-set-key (kbd "M-o") 'copy-word)

(global-set-key (kbd "C-x ,") 'multi-term-dedicated-close)


(provide 'init-custom-key)
