;; 定义函数
;; #+UPDATED_AT:2023-05-08T00:05:06+0800

;; Font
(defun font-installed-p (font-name)
  "Check if font with FONT-NAME is available."
  (find-font (font-spec :name font-name)))

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
  "重复当前行或区域"
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
        (forward-line -1))
      (move-to-column column t)))))

;;;###autoload
(defun xlmo/move-text-down (arg)
  "整行下移"
  (interactive "*p")
  (xlmo/move-text-internal arg))

;;;###autoload
(defun xlmo/move-text-up (arg)
  "整行上移."
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


(defun xlmo/new-diary-file()
  "打开当日的日志文件"
  (interactive)
  (let* ((baseDir (expand-file-name "Diary" xlmo-note-dir))
         (folderMonth (expand-file-name (format-time-string "%Y/%m/") baseDir))
         (folderYear (expand-file-name (format-time-string "%Y/") baseDir))
         (dayfile (expand-file-name (format-time-string "%Y/%m/%Y-%m-%d.md") baseDir))
         )
    (unless (file-exists-p folderYear)
      (make-directory folderYear)
      )
    (unless (file-exists-p folderMonth)
      (make-directory folderMonth)
      )
    (find-file dayfile)
    (unless (file-exists-p dayfile)
      (goto-char 0)
      (insert-file-contents (expand-file-name "Template/diary.md" xlmo-note-dir))
      (while(search-forward "@TITLE@" nil t)
        (replace-match (format-time-string "%Y-%m-%d") nil t))
      (while(search-forward "@DATE@" nil t)
        (replace-match (format-time-string "%Y-%m-%d %H:%M:%S") nil t))
      )
    (goto-char (point-max))))


;; Key Binding
(global-set-key (kbd "M-n") 'xlmo/move-text-down)
(global-set-key (kbd "M-p") 'xlmo/move-text-up)
(global-set-key (kbd "<f5>") 'xlmo/refresh-file)
(global-set-key (kbd "C-c d") 'xlmo/duplicate-current-line-or-region)



(provide 'init-func)
