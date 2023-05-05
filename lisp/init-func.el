;; 定义函数
;; #+UPDATED_AT:2023-05-05T16:05:38+0800

(defun too-long-file-p ()
  "Check whether the file is too long."
  (if (fboundp 'buffer-line-statistics)
      (> (car (buffer-line-statistics)) 10000)
    (> (buffer-size) 100000)))

;; (defun childframe-completion-workable-p ()
;;   "Whether childframe completion is workable."
;;   (and (childframe-workable-p)))

;; (defun childframe-workable-p ()
;;   "Whether childframe is workable."
;;   (or (not (or noninteractive
;;                emacs-basic-display
;;                (not (display-graphic-p))))
;;       (daemonp)))

;; 重复当前行
(defun xlmo/duplicate-current-line-or-region (arg)
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

;; 移动行
(defun xlmo/move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg)
          (when (and
                 ;; Account for changes to transpose-lines in Emacs 24.3
                 (eval-when-compile
                   (not (version-list-<
                         (version-to-list emacs-version)
                         '(24 3 50 0))))
                 ;; Make `move-text-up' works with Emacs 26.0
                 (eval-when-compile
                   (version-list-<
                    (version-to-list emacs-version)
                    '(26 0 50 1)))
                 (< arg 0))
            (forward-line -1)))
        p     (forward-line -1))
      (move-to-column column t)))))

;;;###autoload
(defun xlmo/move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (xlmo/move-text-internal arg))

;;;###autoload
(defun xlmo/move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (xlmo/move-text-internal (- arg)))

(defun xlmo/refresh-file()
  "重新从磁盘读取文件，更新到缓冲区"
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))

(defun xlmo/open-project-todo()
  "打开项目事项文件"
  (interactive)
  (find-file (expand-file-name "Org/project-todo.org" xlmo-note-dir)))

;; 生成uuid
(use-package uuidgen
  :ensure t
  )

(defun xlmo/open-trouble-log ()
  "新建问题排查记录"
  (interactive)
  (let* (
         (workDir (expand-file-name "Org/Troubleshooting" xlmo-obsidian-dir))
         (date (format-time-string "%Y%m%d" (current-time)))
         (title (concat "问题排查 - " date ".org"))
         )

    (find-file (expand-file-name title workDir))
    (goto-char 0)
    (insert-file-contents (expand-file-name "tmpl.org" workDir))
    (goto-char 0)
    (while(search-forward "@TITLE@" nil t)
      (replace-match (concat "问题排查 - " date) nil t))
    )
  (goto-char 0)
  (while(search-forward "@DATETIME@" nil t)
    (replace-match (format-time-string "%Y-%m-%d %a" (current-time)) nil t)
    (goto-char 0)
    (while(search-forward "@PID@" nil t)
      (replace-match (concat "PID_" (uuidgen-4)) nil t))
    )
  )

;; Key Binding
(global-set-key (kbd "M-p") 'xlmo/move-text-up) ;; 上移行 default:(symbol-overlay-jump-prev)
(global-set-key (kbd "M-n") 'xlmo/move-text-down) ;; 下移航 default:(symbol-overlay-jump-next)
(global-set-key (kbd "C-c d") 'xlmo/duplicate-current-line-or-region) ;; 重复当前行
(global-set-key (kbd "<f5>") 'xlmo/refresh-file)



(provide 'init-func)
