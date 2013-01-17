;;mew
 (autoload 'mew "mew" nil t)
 (autoload 'mew-send "mew" nil t)
 ;; Optional setup (Read Mail menu for Emacs 21):
 (if (boundp 'read-mail-command)
     (setq read-mail-command 'mew))
 ;; Optional setup (e.g. C-xm for sending a message):
 (autoload 'mew-user-agent-compose "mew" nil t)
 (if (boundp 'mail-user-agent)
     (setq mail-user-agent 'mew-user-agent))
 (if (fboundp 'define-mail-user-agent)
     (define-mail-user-agent
       'mew-user-agent
       'mew-user-agent-compose
       'mew-draft-send-message
       'mew-draft-kill
       'mew-send-hook))
(setq mew-name "Xiaolong Mo")
(setq mew-user "xlmo@xlmo.me")
(setq mew-use-master-passwd t)
(setq mew-charset-m17n "utf-8")
(setq mew-internal-utf-8p t)

;;; remember last directory when saving
(setq mew-summary-preserve-dir t)
(setq mew-draft-preserve-dir t)

;;使用w3m
(setq mew-mime-multipart-alternative-list '("text/html" "text/plain" "*."))
(condition-case nil
    (require 'mew-w3m)
  (file-error nil))
(setq mew-use-w3m-minor-mode t)
(setq mew-w3m-auto-insert-image t)

;;图标路径
(setq mew-icon-directory "~/.emacs.d/site-lisp/mew/etc")
;;mew-pop-size设置成0时，pop邮件大小没有限制
(setq mew-pop-size 0)


;;mew启动时自动获取邮件
(setq mew-auto-get nil)
 ;; 设置使用Biff检查邮箱是否有新邮件，默认为5分钟。如果有新邮件，则在emacs的状态栏显示Mail(n)的提示—n表示新邮件数目。
(setq mew-use-biff t)
 ;; 设置嘟嘟声通知有新邮件
(setq mew-use-biff-bell t)
 ;; 设置自动检查新邮件的时间间隔，单位：分钟
(setq mew-biff-interval 5)

(setq mew-config-alist
;;Gmail
	'(("default"
	("name"		. "Xiaolong Mo")
	("user"		. "xlmo@xlmo.me")
	("mail-domain"	. "xlmo.me")
	("proto"	. "+")
	("pop-ssl"	. t)
	("pop-ssl-port"	. "995")
;	("prog-ssl"	. "/opt/local/sbin/stunnel")
	("pop-auth"	. pass)
	("pop-user"	. "xlmo@xlmo.me")
	("pop-server"	. "pop.gmail.com")
	("smtp-ssl"	. t)
	("smtp-ssl-port". "465")
	("smtp-auth-list" . ("PLAIN" "LOGIN" "CRAM-MD5"))
	("smtp-user"	. "xlmo@xlmo.me")
	("smtp-server"	. "smtp.gmail.com")
	)))

;; ----------------------------------------------- ;;
;; look and feel
;;(setq mew-decode-broken nil)
(setq mew-window-use-full t)
(setq mew-underline-lines-use t)
(setq mew-use-fancy-thread t)
(setq mew-use-fancy-highlight-body t)
(setq mew-fancy-highlight-body-prefix-width 10)
(setq mew-highlight-body-regex-comment "^[;#?%]+.*")
(setq mew-prog-imls-arg-list '("--thread=yes" "--indent=2"))
;;(setq mew-use-highlight-mouse-line t)
;; ceci pour remplacer le curseur par une barre
;; colorée, c'est selon les goûts
(setq mew-use-highlight-cursor-line t)
(setq mew-highlight-cursor-line-face 'underline)
(setq mew-use-cursor-mark t)
;; La forme originale du sommaire ne me plait pas
;;(setq mew-summary-form
;;            '(type (5 date) " " (-4 size) " " (24 from) " " t (40 subj)))

(setq mew-summary-form
      '(type (5 date) " " (14 from) " " t (30 subj) "|" (0 body)))
(setq mew-sort-default-key "x-date-count")

(set-face-foreground   'mew-face-mark-delete    "red") 
(set-face-bold-p       'mew-face-mark-delete  t)
(set-face-foreground   'mew-face-mark-refile    "darkgreen") 
(set-face-bold-p       'mew-face-mark-refile  t)
(set-face-bold-p       'mew-face-mark-review  t)
(set-face-bold-p       'mew-face-mark-unread  t)

(provide 'init-mew)
