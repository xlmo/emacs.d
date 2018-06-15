;;dired递归删除
(setq dired-recursive-deletes 'top)

;buffer中更好的区分同名文件
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)


;;ibuffer
(add-hook 'ibuffer-hook 'ibuffer-set-up-preferred-filters)

(eval-after-load 'ibuffer
  '(progn
     ;; Use human readable Size column instead of original one
     (define-ibuffer-column size-h
       (:name "Size" :inline t)
       (cond
        ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
        ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
        (t (format "%8d" (buffer-size)))))))

;; Explicitly require ibuffer-vc to get its column definitions, which
;; can't be autoloaded
(eval-after-load 'ibuffer
  '(require 'ibuffer-vc))

;; 修改ibuffer的显示方式
(setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 18 18 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              (vc-status 16 16 :left)
              " "
              filename-and-process)))

(setq ibuffer-filter-group-name-face 'font-lock-doc-face)
;(setq uniquify-ignore-buffers-re "^\\*")


;;recentf
(recentf-mode 1)
(setq recentf-max-saved-items 1000
      recentf-exclude '("/tmp/" "/ssh:"))


;;ido
;; Use C-f during file selection to switch to regular find-file
(ido-mode t)  ; use 'buffer rather than t to use only buffer switching
(ido-everywhere t)
;(ido-ubiquitous-mode t) ;;启用之后minibuff有问题
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)

;; Allow the same buffer to be open in different frames
(setq ido-default-buffer-method 'selected-window)

(winner-mode 1)


;;session
;; save a list of open files in ~/.emacs.d/.emacs.desktop
;; save the desktop file automatically if it already exists
(setq desktop-path '("~/.emacs.d"))
(setq desktop-save 'if-exists)
(desktop-save-mode 1)
(defadvice desktop-read (around trace-desktop-errors)
  (let ((debug-on-error t))
    ad-do-it))


;;----------------------------------------------------------------------------
;; Restore histories and registers after saving
;;----------------------------------------------------------------------------
(setq session-save-file (expand-file-name "~/.emacs.d/.session"))
(add-hook 'after-init-hook 'session-initialize)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (ido-last-directory-list  . 100)
                (ido-work-directory-list  . 100)
                (ido-work-file-list       . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (comint-input-ring        . 50)
                (shell-command-history    . 50)
                desktop-missing-file-warning
                tags-file-name
                register-alist)))


;; ido completion in M-x
(smex-initialize)


;;系统设置
(setq-default
 blink-cursor-delay 0
 blink-cursor-interval 0.4
 bookmark-default-file "~/.emacs.d/.bookmarks.el"
 buffers-menu-max-size 30
 case-fold-search t
 compilation-scroll-output t
 grep-highlight-matches t
 grep-scroll-output t
 indent-tabs-mode nil
 line-spacing 0.2
 make-backup-files nil
 mouse-yank-at-point t
 set-mark-command-repeat-pop t
 show-trailing-whitespace t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell t)

(transient-mark-mode t)
;(paren-activate)

;;切换buffer时保存光标位置
(global-pointback-mode)

;(global-page-break-lines-mode)


(whole-line-or-region-mode t)
;(diminish 'whole-line-or-region-mode)
;(make-variable-buffer-local 'whole-line-or-region-mode)

(fset 'yes-or-no-p 'y-or-n-p)
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(add-hook 'find-file-hooks 'goto-address-prog-mode)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(setq goto-address-mail-face 'link)

(column-number-mode 1)
(setq-default regex-tool-backend 'perl)

(defvar my-savefile-dir "~/.emacs.savefile"
  "The savefile dir of the Emacs.")

;;golden ratio
(setq golden-ratio-exclude-modes '("shell-mode"
                                   "calendar-mode"
                                   "gud-mode"
                                   "ediff-mode"
                                   "eshell-mode"))
(setq golden-ratio-exclude-buffer-names
      '(" *org tags*"
        " *Org todo*"
        ))

;;恢复窗口
;;; windows.el keybind
(setq win:switch-prefix "\C-z")

;; 布局文件保存位置
(setq win:configuration-file "~/.windows")
(require 'windows)
(setq win:use-frame nil)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)

;; 启动时恢复
(add-hook 'after-init-hook (lambda() (run-with-idle-timer 0 nil 'my-resume-windows)))
;; 关闭时保存
(add-hook 'kill-emacs-hook 'win-save-all-configurations)
;;定时保存
(run-with-timer 1800 1800 'win-save-all-configurations)
(run-with-timer 600 600 'desktop-save)


(require 'session)
(add-hook 'after-init-hook        'session-initialize)
;;backup
(setq
 backup-by-copying t                    ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/Backup/emacs"))
 delete-old-versions t
 kept-new-versions 5
 kept-old-versions 2
 version-control t)

;; savehist keeps track of some history
(setq savehist-additional-variables
      ;; search entries
      '(search ring regexp-search-ring)
      ;; save every minute
      savehist-autosave-interval 60
      ;; keep the home clean
      savehist-file (expand-file-name "savehist" my-savefile-dir))
(savehist-mode t)

;; save recent files
(setq recentf-save-file (expand-file-name "recentf" my-savefile-dir)
      recentf-max-saved-items 200
      recentf-max-menu-items 15)
(recentf-mode t)
;; highlight the current line
(global-hl-line-mode +1)

 ;; make a shell script executable automatically on save
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

(global-undo-tree-mode)


;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " xlmo - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

;; move window
(require 'window-numbering)
(window-numbering-mode 1)

(global-linum-mode t)


                                        ;http://stackoverflow.com/questions/3875213/ \
                                        ;turning-on-linum-mode-when-in-python-c-mode
(setq linum-mode-inhibit-modes-list '(eshell-mode
                                      shell-mode
                                      erc-mode
                                      jabber-roster-mode
                                      jabber-chat-mode
                                      twittering-mode
                                      compilation-mode
                                      weibo-timeline-mode
                                      woman-mode
                                      gnus-group-mode
                                      inf-ruby-mode
                                      gud-mode
                                      w3m-mode
                                      gnus-summary-mode
                                      gnus-article-mode
                                      calendar-mode))
(defadvice linum-on (around linum-on-inhibit-for-modes)
  "Stop the load of linum-mode for some major modes."
  (unless (member major-mode linum-mode-inhibit-modes-list)
    ad-do-it))
(ad-activate 'linum-on)

(require 'expand-region)

(highlight-indentation-mode t)
;(set-face-background 'highlight-indentation-face "#e3e3d3")
;(set-face-background 'highlight-indentation-current-column-face "#c3b3b3")

(scroll-bar-mode 0)
(flyspell-mode t)
(tool-bar-mode 0)
(menu-bar-mode 0)

(package-initialize)
(smartparens-global-mode t)

(provide 'init-misc)
