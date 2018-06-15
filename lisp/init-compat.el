; Which functionality to enable (use t or nil for true and false)
(defconst *spell-check-support-enabled* nil)
(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-carbon-emacs* (eq window-system 'mac))
(defconst *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))

(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super)
  (setq default-input-method "MacOSX")
  ;; Make mouse wheel / trackpad scrolling less jerky
  (setq mouse-wheel-scroll-amount '(0.001))
  (when *is-cocoa-emacs*
    ;; Woohoo!!
    (global-set-key (kbd "M-`") 'ns-next-frame)
    (global-set-key (kbd "M-h") 'ns-do-hide-emacs)
    (eval-after-load 'nxml-mode
      '(define-key nxml-mode-map (kbd "M-h") nil))
    (global-set-key (kbd "M-c") 'ns-copy-including-secondary)
    (global-set-key (kbd "M-v") 'scroll-down-command)))

;;编码设置
(when (or window-system (locale-is-utf8-p))
  (setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
  (set-language-environment 'utf-8)
  (when *is-carbon-emacs*
    (set-keyboard-coding-system 'utf-8-mac))
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8))
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect)
;; ??????????????????
;; (setq garbage-collection-messages t)
(provide 'init-compat)
