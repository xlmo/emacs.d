;;elpa设置
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(defvar my-packages
  '(w3m
    dired+
    php-mode
    dsvn
    magit
    org
    org2blog
    twittering-mode
    undo-tree
    projectile
    helm
    helm-projectile
    helm-git
    helm-flymake
    helm-c-yasnippet
    golden-ratio
    ibuffer-vc
    expand-region
    ido-ubiquitous
    pointback
    whole-line-or-region
    paredit
    js2-mode
    js3-mode
    js-comint
    smarty-mode
    mmm-mode
    slime
    slime-fuzzy
    slime-repl
    windresize
    revive
    window-number
    auto-complete
    markdown-mode
    flymake
    flymake-css
    flymake-cursor
    flymake-jslint
    flymake-php
    flymake-shell
    move-text
    htmlize
    exec-path-from-shell
    multi-term
    expand-region
    highlight-indentation
    smex
    smartparens
    yasnippet))
;;自动安装
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

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
