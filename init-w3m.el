;;w3m
(setq w3m-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)
(setq w3m-use-cookies t)
(setq w3m-cookie-accept-bad-cookies t)
(setq w3m-home-page "http://local.com/index.php")
(setq w3m-use-toolbar t
      ;w3m-use-tab     nil
      w3m-key-binding 'info
      )

;; show images in the browser
;(setq w3m-default-display-inline-images t)
(setq w3m-search-default-engine "g")
(eval-after-load "w3m-search" '(progn
                                 ; C-u S g RET <search term> RET
                                 (add-to-list 'w3m-search-engine-alist '("g"
                                                                         "http://www.google.com/search?hl=zh-CN&q=%s" utf-8))
                                 (add-to-list 'w3m-search-engine-alist '("wz"
                                                                         "http://zh.wikipedia.org/wiki/Special:Search?search=%s" utf-8))
                                 (add-to-list 'w3m-search-engine-alist '("q"
                                                                         "http://www.google.com/search?hl=en&q=%s+site:stackoverflow.com" utf-8))
                                 (add-to-list 'w3m-search-engine-alist '("s"
                                                                         "http://code.google.com/codesearch?q=%s" utf-8))
                                 ))
(setq w3m-command-arguments       '("-F" "-cookie")
      w3m-mailto-url-function     'compose-mail
      browse-url-browser-function 'w3m
      mm-text-html-renderer       'w3m)

(provide 'init-w3m)
