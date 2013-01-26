(defun magit-status-somedir ()
  (interactive)
  (let ((current-prefix-arg t))
    (magit-status default-directory)))

(defun git-svn (dir)
  "Run git svn"
  (interactive "DSelect directory: ")
  (unless git-svn--available-commands
    (setq git-svn--available-commands
          (string-all-matches "^  \\([a-z\\-]+\\) +" (shell-command-to-string "git svn help") 1)))
  (let* ((default-directory (vc-git-root dir))
         (compilation-buffer-name-function (lambda (major-mode-name) "*git-svn*")))
    (compile (concat "git svn "
                     (ido-completing-read "git-svn command: " git-svn--available-commands nil t)))))


(defun smp/set-up-slime-repl-auto-complete ()
  "Bind TAB to `indent-for-tab-command', as in regular Slime buffers."
  (local-set-key (kbd "TAB") 'indent-for-tab-command))

(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

(defun my-resume-windows ()
  "restore windows status ."
  (interactive)
  (resume-windows t)
  (clear-active-region-all-buffers)
  )

(defun my-duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(defun my-kill-other-buffers ()
  "Kill all buffers but the current one. Doesn't mess with special buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (kill-buffer buffer))))

(defun my-swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (if (/= (count-windows) 2)
      (message "You need exactly 2 windows to do this.")
    (let* ((w1 (first (window-list)))
           (w2 (second (window-list)))
           (b1 (window-buffer w1))
           (b2 (window-buffer w2))
           (s1 (window-start w1))
           (s2 (window-start w2)))
      (set-window-buffer w1 b2)
      (set-window-buffer w2 b1)
      (set-window-start w1 s2)
      (set-window-start w2 s1)))
  (other-window 1))


(defun my-helm ()
  "Preconfigured `helm'."
  (interactive)
  (condition-case nil
    (if (projectile-project-root)
        ;; add project files and buffers when in project
        (helm-other-buffer '(helm-c-source-projectile-files-list
                             helm-c-source-projectile-buffers-list
                             helm-c-source-buffers-list
                             helm-c-source-recentf
                             helm-c-source-buffer-not-found)
                           "*helm*")
      ;; otherwise fallback to helm-mini
      (helm-mini))
    ;; fall back to helm mini if an error occurs (usually in projectile-project-root)
    (error (helm-mini))))

(defun my-recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(defun locale-is-utf8-p ()
  "Return t iff the \"locale\" command or environment variables prefer UTF-8."
  (flet ((is-utf8 (v) (and v (string-match "UTF-8" v))))
    (or (is-utf8 (and (executable-find "locale") (shell-command-to-string "locale")))
        (is-utf8 (getenv "LC_ALL"))
        (is-utf8 (getenv "LC_CTYPE"))
        (is-utf8 (getenv "LANG")))))


(defun steve-ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (if (and ido-use-virtual-buffers (fboundp 'ido-toggle-virtual-buffers))
      (ido-switch-buffer)
    (find-file (ido-completing-read "Open file: " recentf-list nil t))))


(defun copy-word (&optional arg)
  "Copy a sequence of string into kill-ring"
  (interactive)
  (setq onPoint (point))
  (let ((beg (progn (re-search-backward "[^a-zA-Z0-9_-]" (line-beginning-position) 3 1)
                       (if (looking-at "[^a-zA-Z0-9_-]") (+ (point) 1) (point) ) ))
        (end (progn  (goto-char onPoint) (re-search-forward "[^a-zA-Z0-9_-]" (line-end-position) 3 1)
                       (if (looking-back "[^a-zA-Z0-9_-]") (- (point) 1) (point))) ))
    (copy-region-as-kill beg end)))



(defun ibuffer-set-up-preferred-filters ()
  (ibuffer-vc-set-filter-groups-by-vc-root)
  (unless (eq ibuffer-sorting-mode 'filename/process)
    (ibuffer-do-sort-by-filename/process)))
(provide 'init-func)
