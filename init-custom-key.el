(global-set-key (kbd "C-x C-b") 'ibuffer)


(global-set-key [(meta f11)] 'steve-ido-choose-from-recentf)
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
(global-set-key (kbd "C-;") 'ace-jump-mode)
(global-set-key (kbd "C-:") 'ace-jump-word-mode)


;; multiple-cursors
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-+") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; From active region to multiple cursors:
(global-set-key (kbd "C-c c r") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c c c") 'mc/edit-lines)
(global-set-key (kbd "C-c c e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c c a") 'mc/edit-beginnings-of-lines)


(global-set-key (kbd "C-c p") 'duplicate-line)

(global-unset-key [M-left])
(global-unset-key [M-right])


(global-set-key [(meta f12)] 'magit-status)
(global-set-key [(shift meta f12)] 'magit-status-somedir)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)


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

(global-set-key (kbd "<f11>") 'ns-toggle-fullscreen)

;; Font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


(global-set-key (kbd "C-c h") 'my-helm)
(global-set-key (kbd "C-c f")  'my-recentf-ido-find-file)
(global-set-key (kbd "C-c s") 'my-swap-windows)
(global-set-key (kbd "C-c d") 'my-duplicate-current-line-or-region)
(global-set-key (kbd "C-c k") 'my-kill-other-buffers)

;;move-text stuff, move line up/down by pressing hotkey
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

(global-set-key [f8] 'calendar)
(global-set-key [f12] 'list-bookmarks)

(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

(global-set-key (kbd "M-g o") 'golden-ratio-enable)
(global-set-key (kbd "M-g f") 'golden-ratio-disable)

(provide 'init-custom-key)