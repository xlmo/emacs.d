;; 设置词库
(setq pyim-dicts
      '((:name "dict_big" :file "~/.emacs.d/pyim-bigdict.pyim") ;;大词库
      (:name "dict_sogoo" :file "~/.emacs.d/pyim-sogoudict.pyim"))) ;; 个人搜狗输入法转的词库

(use-package posframe)

(use-package pyim
  :ensure t
  :config
  ;; 激活 basedict 拼音词库
  (use-package pyim-basedict
    :ensure t
    :config (pyim-basedict-enable))

  ;; 五笔用户使用 wbdict 词库
  ;; (use-package pyim-wbdict
  ;;   :ensure nil
  ;;   :config (pyim-wbdict-gbk-enable))


(setq default-input-method "pyim")
;; 我使用全拼
(setq pyim-default-scheme 'quanpin)

;; 云输入法
;; (setq pyim-cloudim 'baidu)		;
;; (setq pyim-cloudim 'google)

;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
;; 我自己使用的中英文动态切换规则是：
;; 1. 光标只有在注释里面时，才可以输入中文。
;; 2. 光标前是汉字字符时，才能输入中文。
;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
(setq-default pyim-english-input-switch-functions
              '(pyim-probe-dynamic-english
                pyim-probe-isearch-mode
                pyim-probe-program-mode
                pyim-probe-org-structure-template))
;; 根据环境自动切换到半角标点输入模式
(setq-default pyim-punctuation-half-width-functions
              '(pyim-probe-punctuation-line-beginning
                pyim-probe-punctuation-after-punctuation))

;; 开启拼音搜索功能
(pyim-isearch-mode 1)

;; 中文的 forward/backward
(require 'pyim-cstring-utils)
(global-set-key (kbd "M-f") 'pyim-forward-word)
(global-set-key (kbd "M-b") 'pyim-backward-word)

;; 绘制选词框
(setq pyim-page-tooltip '(posframe popup minibuffer))

;; 选词框显示候选词个数
(setq pyim-page-length 9)



  ;; 让 Emacs 启动时自动加载 pyim 词库
(add-hook 'emacs-startup-hook
            #'(lambda () (pyim-restart-1 t)))
)
;; 使用.,来翻页
(define-key pyim-mode-map "." 'pyim-page-next-page)
(define-key pyim-mode-map "," 'pyim-page-previous-page)

;; 金手指设置，可以将光标处的编码，比如：拼音字符串，转换为中文。
(global-set-key (kbd "M-j") 'pyim-convert-string-at-point)

;; 按 "C-<return>" 将光标前的 regexp 转换为可以搜索中文的 regexp.
(define-key minibuffer-local-map (kbd "C-<return>") 'pyim-cregexp-convert-at-point)

(provide 'init-pyim)
