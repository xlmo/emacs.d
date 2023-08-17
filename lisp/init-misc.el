;; 一些工具和配置

;; Fast search tool `ripgrep'
(use-package rg
  :hook (after-init . rg-enable-default-bindings)
  :bind (:map rg-global-map
              ("c" . rg-dwim-current-dir)
              ("f" . rg-dwim-current-file)
              ("m" . rg-menu))
  :init (setq rg-group-result t
              rg-show-columns t)
  :config
  (cl-pushnew '("tmpl" . "*.tmpl") rg-custom-type-aliases))




;; 为 Emacs minibuffer 中的选项添加注解
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;; 中文日历
;; (use-package cal-china-x
;;   :after calendar
;;   :autoload cal-china-x-setup
;;   :init (cal-china-x-setup)
;;   :config
;;   ;; Holidays
;;   (setq calendar-mark-holidays-flag t
;;         cal-china-x-important-holidays cal-china-x-chinese-holidays
;;         cal-china-x-general-holidays '((holiday-lunar 1 15 "元宵节")
;;                                        (holiday-lunar 7 7 "七夕节")
;;                                        (holiday-fixed 3 8 "妇女节")
;;                                        (holiday-fixed 3 12 "植树节")
;;                                        (holiday-fixed 5 4 "青年节")
;;                                        (holiday-fixed 6 1 "儿童节")
;;                                        (holiday-fixed 9 10 "教师节"))
;;         holiday-other-holidays '((holiday-fixed 2 14 "情人节")
;;                                  (holiday-fixed 4 1 "愚人节")
;;                                  (holiday-fixed 12 25 "圣诞节")
;;                                  (holiday-float 5 0 2 "母亲节")
;;                                  (holiday-float 6 0 3 "父亲节")
;;                                  (holiday-float 11 4 4 "感恩节"))
;;         calendar-holidays (append cal-china-x-important-holidays
;;                                   cal-china-x-general-holidays
;;                                   holiday-other-holidays)))

;; 目录文件操作
(use-package dired
  :ensure nil
  :bind (:map dired-mode-map
         ("C-c C-p" . wdired-change-to-wdired-mode))
  :config
  ;; Guess a default target directory
  (setq dired-dwim-target t)

  ;; Always delete and copy recursively
  (setq dired-recursive-deletes 'always
        dired-recursive-copies 'always)

  ;; Show directory first
  (setq dired-listing-switches "-alh --group-directories-first")

  ;; Quick sort dired buffers via hydra
  (use-package dired-quick-sort
    :bind (:map dired-mode-map
           ("S" . hydra-dired-quick-sort/body)))

  ;; Show git info in dired
  (use-package dired-git-info
    :bind (:map dired-mode-map
           (")" . dired-git-info-mode)))

  ;; Allow rsync from dired buffers
  (use-package dired-rsync
    :bind (:map dired-mode-map
           ("C-c C-r" . dired-rsync)))

  ;; Colorful dired
  (use-package diredfl
    :hook (dired-mode . diredfl-mode))

  ;; Shows icons
  (use-package nerd-icons-dired
    :diminish
    :commands nerd-icons-dired-mode
    :custom-face
    (nerd-icons-dired-dir-face ((t (:inherit nerd-icons-dsilver :foreground unspecified))))
    :hook (dired-mode . nerd-icons-dired-mode))

  ;; Extra Dired functionality
  (use-package dired-aux :ensure nil)
  (use-package dired-x
    :ensure nil
    :demand t
    :config
    (let ((cmd (cond (sys/mac-x-p "open")
                     (sys/linux-x-p "xdg-open")
                     (sys/win32p "start")
                     (t ""))))
      (setq dired-guess-shell-alist-user
            `(("\\.pdf\\'" ,cmd)
              ("\\.docx\\'" ,cmd)
              ("\\.\\(?:djvu\\|eps\\)\\'" ,cmd)
              ("\\.\\(?:jpg\\|jpeg\\|png\\|gif\\|xpm\\)\\'" ,cmd)
              ("\\.\\(?:xcf\\)\\'" ,cmd)
              ("\\.csv\\'" ,cmd)
              ("\\.tex\\'" ,cmd)
              ("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|rm\\|rmvb\\|ogv\\)\\(?:\\.part\\)?\\'" ,cmd)
              ("\\.\\(?:mp3\\|flac\\)\\'" ,cmd)
              ("\\.html?\\'" ,cmd)
              ("\\.md\\'" ,cmd))))

    (setq dired-omit-files
          (concat dired-omit-files
                  "\\|^.DS_Store$\\|^.projectile$\\|^.git*\\|^.svn$\\|^.vscode$\\|\\.js\\.meta$\\|\\.meta$\\|\\.elc$\\|^.emacs.*"))))

;; `find-dired' alternative using `fd'
(when (executable-find "fd")
  (use-package fd-dired))

;; Emacs command shell
;; (use-package eshell
;;   :ensure nil
;;   :defines eshell-prompt-function
;;   :bind (:map eshell-mode-map
;;               ([remap recenter-top-bottom] . eshell/clear))
;;   :config
;;   (with-no-warnings
;;     (defun eshell/clear ()
;;       "Clear the eshell buffer."
;;       (interactive)
;;       (let ((inhibit-read-only t))
;;         (erase-buffer)
;;         (eshell-send-input)))

;;     (defun eshell/emacs (&rest args)
;;       "Open a file (ARGS) in Emacs.  Some habits die hard."
;;       (if (null args)
;;           ;; If I just ran "emacs", I probably expect to be launching
;;           ;; Emacs, which is rather silly since I'm already in Emacs.
;;           ;; So just pretend to do what I ask.
;;           (bury-buffer)
;;         ;; We have to expand the file names or else naming a directory in an
;;         ;; argument causes later arguments to be looked for in that directory,
;;         ;; not the starting directory
;;         (mapc #'find-file (mapcar #'expand-file-name (flatten-tree (reverse args))))))
;;     (defalias 'eshell/e #'eshell/emacs)
;;     (defalias 'eshell/ec #'eshell/emacs)

;;     (defun eshell/ebc (&rest args)
;;       "Compile a file (ARGS) in Emacs. Use `compile' to do background make."
;;       (if (eshell-interactive-output-p)
;;           (let ((compilation-process-setup-function
;;                  (list 'lambda nil
;;                        (list 'setq 'process-environment
;;                              (list 'quote (eshell-copy-environment))))))
;;             (compile (eshell-flatten-and-stringify args))
;;             (pop-to-buffer compilation-last-buffer))
;;         (throw 'eshell-replace-command
;;                (let ((l (eshell-stringify-list (flatten-tree args))))
;;                  (eshell-parse-command (car l) (cdr l))))))
;;     (put 'eshell/ebc 'eshell-no-numeric-conversions t)

;;     (defun eshell-view-file (file)
;;       "View FILE.  A version of `view-file' which properly rets the eshell prompt."
;;       (interactive "fView file: ")
;;       (unless (file-exists-p file) (error "%s does not exist" file))
;;       (let ((buffer (find-file-noselect file)))
;;         (if (eq (get (buffer-local-value 'major-mode buffer) 'mode-class)
;;                 'special)
;;             (progn
;;               (switch-to-buffer buffer)
;;               (message "Not using View mode because the major mode is special"))
;;           (let ((undo-window (list (window-buffer) (window-start)
;;                                    (+ (window-point)
;;                                       (length (funcall eshell-prompt-function))))))
;;             (switch-to-buffer buffer)
;;             (view-mode-enter (cons (selected-window) (cons nil undo-window))
;;                              'kill-buffer)))))

;;     (defun eshell/less (&rest args)
;;       "Invoke `view-file' on a file (ARGS).

;; \"less +42 foo\" will go to line 42 in the buffer for foo."
;;       (while args
;;         (if (string-match "\\`\\+\\([0-9]+\\)\\'" (car args))
;;             (let* ((line (string-to-number (match-string 1 (pop args))))
;;                    (file (pop args)))
;;               (eshell-view-file file)
;;               (forward-line line))
;;           (eshell-view-file (pop args)))))
;;     (defalias 'eshell/more #'eshell/less))

;;   ;;  Display extra information for prompt
;;   (use-package eshell-prompt-extras
;;     :after esh-opt
;;     :defines eshell-highlight-prompt
;;     :autoload (epe-theme-lambda epe-theme-dakrone epe-theme-pipeline)
;;     :init (setq eshell-highlight-prompt nil
;;                 eshell-prompt-function #'epe-theme-lambda))

;;   ;; `eldoc' support
;;   (use-package esh-help
;;     :init (setup-esh-help-eldoc))

;;   ;; `cd' to frequent directory in `eshell'
;;   (use-package eshell-z
;;     :hook (eshell-mode . (lambda () (require 'eshell-z)))))

;; 项目
(use-package projectile
  :ensure t
  :bind (("C-c p" . projectile-command-map))
  :config
  (setq projectile-mode-line "Projectile")
  (setq projectile-track-known-projects-automatically nil))

(use-package counsel-projectile
  :ensure t
  :after (projectile)
  :init (counsel-projectile-mode))

(provide 'init-misc)
