;;elpa设置
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;;设置shell path
(eval-after-load 'exec-path-from-shell
  '(progn
     (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO"))
       (add-to-list 'exec-path-from-shell-variables var))))
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;递归的将site-lisp加入load-path中
(require 'cl)
    (let* ((my-lisp-dir site-lisp-path)
           (default-directory my-lisp-dir))
      (progn
        (setq load-path
              (append
               (loop for dir in (directory-files my-lisp-dir)
                     unless (string-match "^\\." dir)
                     collecting (expand-file-name dir))
               load-path))))
(provide 'init-elpa)
