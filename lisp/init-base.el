;; 基本配置
;; #+UPDATED_AT:2023-05-05T17:05:29+0800

;; 配置目录保持简洁
(use-package no-littering
  :ensure t)

(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (fset 'yes-or-no-p 'y-or-n-p))

;; 拷贝粘贴设置
(setq select-enable-primary nil)        ; 选择文字时不拷贝
(setq select-enable-clipboard t)        ; 拷贝时使用剪贴板

;; 设置剪贴板历史长度300，默认为60
(setq kill-ring-max 200)

;; 在剪贴板里不存储重复内容
(setq kill-do-not-save-duplicates t)

;; 设置 emacs-lisp 的限制
(setq max-lisp-eval-depth 10000)        ; 默认值为 800
(setq max-specpdl-size 10000)           ; 默认值为 1600

;; 启用 `list-timers', `list-threads' 这两个命令
(put 'list-timers 'disabled nil)
(put 'list-threads 'disabled nil)

;;自动清除行位空格
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)

(setq make-backup-files nil)                                  ; 不自动备份
(setq auto-save-default nil)                                  ; 不使用Emacs自带的自动保存

;; 配置所有的编码为UTF-8，参考：
;; https://thraxys.wordpress.com/2016/01/13/utf-8-in-emacs-everywhere-forever/
(setq locale-coding-system 'utf-8)
;; Set UTF-8 as the default coding system
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(setq system-time-locale "C")
(unless sys/win32p
  (set-selection-coding-system 'utf-8))
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;; 解除不常用的快捷键定义
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "s-q") nil)
(global-set-key (kbd "M-z") nil)
(global-set-key (kbd "M-m") nil)
(global-set-key (kbd "C-x C-z") nil)
(global-set-key [mouse-2] nil)
(global-set-key (kbd "C-j") nil)

;; 帮助增强
(use-package helpful
  :ensure t
  :commands (helpful-callable helpful-variable helpful-command helpful-key helpful-mode)
  :bind (([remap describe-command] . helpful-command)
         ("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h s" . helpful-symbol)
         ("C-h S" . describe-syntax)
         ("C-h m" . describe-mode)
         ("C-h F" . describe-face)
         ([remap describe-key] . helpful-key))
  )

;; 提示快捷键
(use-package which-key
  :ensure t
  :hook (after-init . which-key-mode)
  :config
  (which-key-add-key-based-replacements
    "C-c !" "flycheck"
    "C-c @" "hideshow"
    "C-c i" "ispell"
    "C-c t" "hl-todo"
    "C-x a" "abbrev"
    "C-x n" "narrow"
    "C-x t" "tab")
  :custom
  (which-key-idle-delay 0.7)
  (which-key-add-column-padding 1))

;;记住迷你缓冲区历史
(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :init (setq enable-recursive-minibuffers t ; Allow commands in minibuffers
              history-length 1000
              savehist-additional-variables '(mark-ring
                                              global-mark-ring
                                              search-ring
                                              regexp-search-ring
                                              extended-command-history)
              savehist-autosave-interval 300))

(use-package hydra
  :hook (emacs-lisp-mode . hydra-add-imenu))

(use-package pretty-hydra
  :init
  (cl-defun pretty-hydra-title (title &optional icon-type icon-name
                                      &key face height v-adjust)
    "Add an icon in the hydra title."
    (let ((face (or face `(:foreground ,(face-background 'highlight))))
          (height (or height 1.2))
          (v-adjust (or v-adjust 0.0)))
      (concat
       (propertize title 'face face)))))


;; Windows/buffers sets shared among frames + save/load.
(use-package persp-mode
  :diminish
  :defines (recentf-exclude ivy-ignore-buffers)
  :autoload (get-current-persp persp-contain-buffer-p)
  :hook ((after-init . persp-mode)
         (persp-mode . persp-load-frame)
         (kill-emacs . persp-save-frame))
  :init (setq persp-keymap-prefix (kbd "C-x p")
              persp-nil-name "default"
              persp-set-last-persp-for-new-frames nil
              persp-kill-foreign-buffer-behaviour 'kill
              persp-auto-resume-time 1.0 )
  :config
  ;; Save and load frame parameters (size & position)
  (defvar persp-frame-file (expand-file-name "persp-frame" persp-save-dir)
    "File of saving frame parameters.")

  (defun persp-save-frame ()
    "Save the current frame parameters to file."
    (interactive)
    (when (and (display-graphic-p) persp-mode)
      (condition-case error
          (with-temp-buffer
            (erase-buffer)
            (insert
             ";;; -*- mode: emacs-lisp; coding: utf-8-unix -*-\n"
             ";;; This is the previous frame parameters.\n"
             ";;; Last generated " (current-time-string) ".\n"
             "(setq initial-frame-alist\n"
             (format "      '((top . %d)\n" (eval (frame-parameter nil 'top)))
             (format "        (left . %d)\n" (eval (frame-parameter nil 'left)))
             (format "        (width . %d)\n" (eval (frame-parameter nil 'width)))
             (format "        (height . %d)\n" (eval (frame-parameter nil 'height)))
             (format "        (fullscreen . %s)))\n" (frame-parameter nil 'fullscreen)))
            (write-file persp-frame-file))
        (error
         (warn "persp frame: %s" (error-message-string error))))))

  (defun persp-load-frame ()
    "Load frame with the previous frame's geometry."
    (interactive)
    (when (and (display-graphic-p) persp-mode)
      (condition-case error
          (progn
            ;; (fix-fullscreen-cocoa)
            (load persp-frame-file nil t)

            ;; NOTE: Only usable in `emacs-startup-hook' while not `window-setup-hook'.
            (add-hook 'emacs-startup-hook
                      (lambda ()
                        "Adjust initial frame position."
                        ;; Handle multiple monitors gracefully
                        (when (or (>= (eval (frame-parameter nil 'top)) (display-pixel-height))
                                  (>= (eval (frame-parameter nil 'left)) (display-pixel-width)))
                          (set-frame-parameter nil 'top 0)
                          (set-frame-parameter nil 'left 0)))))
        (error
         (warn "persp frame: %s" (error-message-string error))))))

  (with-no-warnings
    ;; Don't save if the state is not loaded
    (defvar persp-state-loaded nil
      "Whether the state is loaded.")

    (defun my-persp-after-load-state (&rest _)
      (setq persp-state-loaded t))
    (advice-add #'persp-load-state-from-file :after #'my-persp-after-load-state)
    (add-hook 'emacs-startup-hook
              (lambda ()
                (add-hook 'find-file-hook #'my-persp-after-load-state)))

    (defun my-persp-asave-on-exit (fn &optional interactive-query opt)
      (if persp-state-loaded
          (funcall fn interactive-query opt)
        t))
    (advice-add #'persp-asave-on-exit :around #'my-persp-asave-on-exit))

  ;; Don't save dead or temporary buffers
  (add-hook 'persp-filter-save-buffers-functions
            (lambda (b)
              "Ignore dead and unneeded buffers."
              (or (not (buffer-live-p b))
                  (string-prefix-p " *" (buffer-name b)))))
  (add-hook 'persp-filter-save-buffers-functions
            (lambda (b)
              "Ignore temporary buffers."
              (let ((bname (file-name-nondirectory (buffer-name b))))
                (or (string-prefix-p ".newsrc" bname)
                    (string-prefix-p "magit" bname)
                    (string-prefix-p "COMMIT_EDITMSG" bname)
                    (string-prefix-p "Pfuture-Callback" bname)
                    (string-prefix-p "treemacs-persist" bname)
                    (string-match-p "\\.elc\\|\\.tar\\|\\.gz\\|\\.zip\\'" bname)
                    (string-match-p "\\.bin\\|\\.so\\|\\.dll\\|\\.exe\\'" bname)))))

  ;; Don't save persp configs in `recentf'
  (with-eval-after-load 'recentf
    (push persp-save-dir recentf-exclude))

  ;; Ivy Integration
  (with-eval-after-load 'ivy
    (add-to-list 'ivy-ignore-buffers
                 (lambda (b)
                   (when persp-mode
                     (if-let ((persp (get-current-persp)))
                         (not (persp-contain-buffer-p b persp))
                       nil)))))
  ;; Eshell integration
  (persp-def-buffer-save/load
   :mode 'eshell-mode :tag-symbol 'def-eshell-buffer
   :save-vars '(major-mode default-directory))

  ;; Shell integration
  (persp-def-buffer-save/load
   :mode 'shell-mode :tag-symbol 'def-shell-buffer
   :mode-restore-function (lambda (_) (shell))
   :save-vars '(major-mode default-directory)))

;; Project integration
(use-package persp-mode-project-bridge
  :autoload (persp-mode-project-bridge-find-perspectives-for-all-buffers
             persp-mode-project-bridge-kill-perspectives)
  :hook
  (persp-mode-project-bridge-mode . (lambda ()
                                      (if persp-mode-project-bridge-mode
                                          (persp-mode-project-bridge-find-perspectives-for-all-buffers)
                                        (persp-mode-project-bridge-kill-perspectives))))
  (persp-mode . persp-mode-project-bridge-mode)
  :init
  (setq persp-mode-project-bridge-persp-name-prefix "")
  :config
  (with-no-warnings
    ;; HACK: Allow saving to files
    (defun my-persp-mode-project-bridge-add-new-persp (name)
      (let ((persp (persp-get-by-name name *persp-hash* :nil)))
        (if (eq :nil persp)
            (prog1
                (setq persp (persp-add-new name))
              (when persp
                (set-persp-parameter 'persp-mode-project-bridge t persp)
                (persp-add-buffer (cl-remove-if-not #'get-file-buffer (project-files (project-current)))
                                  persp nil nil)))
          persp)))
    (advice-add #'persp-mode-project-bridge-add-new-persp
                :override #'my-persp-mode-project-bridge-add-new-persp)

    ;; HACK: Switch to buffer after switching perspective
    (defun my-persp-mode-project-bridge-hook-switch (fn &rest _args)
      "Switch to a perspective when hook is activated."
      (let ((buf (current-buffer)))
        (funcall fn)
        (when (buffer-live-p buf)
          (switch-to-buffer buf))))
    (advice-add #'persp-mode-project-bridge-hook-switch
                :around #'my-persp-mode-project-bridge-hook-switch)))


(provide 'init-base)
