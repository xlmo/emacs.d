;; pyim

;; 和counsel一起使用有问题，新建文件等场景下不能激活, 目前用 ivy 的拼音搜索
;; https://github.com/tumashu/pyim
(use-package pyim
  :config
  ;; (use-package pyim-basedict)
  (require 'pyim-cregexp-utils)
  ;; 让 ivy 支持拼音搜索
  (setq ivy-re-builders-alist
        '((t . pyim-cregexp-ivy)))
  (pyim-basedict-enable)
  ;; (setq pyim-dicts
  ;;       '((:name "sougou" :file "~/.emacs.d/data/sougou.pyim")))
  ;; ;; Emacs 启动时加载 pyim 词库
  ;; (add-hook 'emacs-startup-hook
  ;;           (lambda () (pyim-restart-1 t)))
  ;; (setq default-input-method "pyim")
  ;; (setq pyim-page-length 9)
  ;; (pyim-default-scheme 'quanpin)
  ;; (setq pyim-cloudim 'baidu)
  ;; 设置翻页
  (define-key pyim-mode-map "." 'pyim-page-next-page)
  (define-key pyim-mode-map "," 'pyim-page-previous-page)

  ;; 开启代码搜索中文功能
  ;; (pyim-isearch-mode 1)

  ;; 金手指设置，可以将光标处的编码（比如：拼音字符串）转换为中文。
  ;; (global-set-key (kbd "M-j") 'pyim-convert-string-at-point)
  ;; 设置 pyim 探针
  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  ;; (setq-default pyim-english-input-switch-functions
  ;;               '(pyim-probe-dynamic-english
  ;;                 pyim-probe-isearch-mode
  ;;                 pyim-probe-program-mode
  ;;                 pyim-probe-org-structure-template))

  ;; (setq-default pyim-punctuation-half-width-functions
  ;;               '(pyim-probe-punctuation-line-beginning
  ;;                 pyim-probe-punctuation-after-punctuation))
  )

(provide 'init-pyim)
