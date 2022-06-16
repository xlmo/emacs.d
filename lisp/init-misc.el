;; 综合设置

;;当你选中一段文字 之后输入一个字符会替换掉你选中部分的文字
(delete-selection-mode 1)
;;关闭自动保存文件
(setq auto-save-default nil)
;;关闭备份文件
(setq make-backup-files nil)

;; recentf 文件保存路径
(setq recentf-save-file (expand-file-name "recentf" local-cache-directory))
;; bookmarks 文件保存路径
(setq bookmark-default-file (expand-file-name "bookmarks" local-cache-directory))
;; history 文件保存路径
(setq savehist-file (expand-file-name "history" local-cache-directory))


;; 简化yes or no 的回答
(fset 'yes-or-no-p 'y-or-n-p)

;;高亮当前行
(global-hl-line-mode 1)

;; 自动换行
(global-visual-line-mode 1)

;; 显示行号
;; 不开启全局行号显示，因为在agenda-mode 中会有布局问题
;(global-display-line-numbers-mode 1)

;; title 显示文件全路径
(setq frame-title-format
      '((:eval( if (buffer-file-name)
                  (abbreviate-file-name (buffer-file-name))
                "%b"))))

;; 更改光标样式
(setq-default cursor-type 'bar)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
;; 不显示启动画面
(setq inhibit-startup-screen t)


;; 翻页之后光标位置不变
(setq scroll-preserve-screen-position t)




;; 编码设置 来源自purcell
(when (or window-system (sanityinc/locale-is-utf8-p))
  (set-language-environment 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system (if (eq system-type 'windows-nt) 'utf-16-le 'utf-8))
  (prefer-coding-system 'utf-8))

;; 设置字体大小
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;;(set-face-attribute 'default nil :height 90)

;; 更好的滚动
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)



;; ;;保存窗口布局
;; (desktop-save-mode t)
;; ;;启动时加载布局
;; (setq desktop-dir "~/.emacs.d")
;; (desktop-read desktop-dir)

;; ;;用M-数字键来切换窗口
;; (require 'window-numbering)
;; (window-numbering-mode 1)

;; ;; eshell path
;; (add-hook 'eshell-mode-hook 'eshell-mode-hook-func)

;; 显示菜单栏
(menu-bar-mode 1)

;; dired 大小用KB/MB/GB来显示
(setq dired-listing-switches "-alh")


;; 使用系统剪贴板，实现与其它程序相互粘贴。
(setq x-select-enable-clipboard t)
(setq select-enable-clipboard t)
(setq x-select-enable-primary t)
(setq select-enable-primary t)

(defvar backup-dir (expand-file-name local-backup-directory))
(if (not (file-exists-p backup-dir))
    (make-directory backup-dir t))
;; 文件第一次保存时备份。
(setq make-backup-files t)
(setq backup-by-copying t)
(setq backup-directory-alist (list (cons ".*" backup-dir)))
;; 备份文件时使用版本号。
(setq version-control t)
;; 删除过多的版本。
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)

(defvar autosave-dir (expand-file-name local-autosave-directory))
(if (not (file-exists-p autosave-dir))
    (make-directory autosave-dir t))
;; auto-save 访问的文件。
(setq auto-save-default t)
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))


(setq browse-kill-ring-quit-action        ;设置退出动作
      (quote save-and-restore))           ;保存还原窗口设置
(autoload 'hanconvert-region "hanconvert" ;简繁中文互相转换
  "Convert a region from simple chinese to tradition chinese or
from tradition chinese to simple chinese" t)
(autoload 'irfc "init-irfc")
(custom-set-variables '(tramp-verbose 0)) ;设置tramp的响应方式, 关闭后不弹出消息
(setq max-lisp-eval-depth 40000)          ;lisp最大执行深度
(setq max-specpdl-size 10000)             ;最大容量
(setq kill-ring-max 1024) ;用一个很大的 kill ring. 这样防止我不小心删掉重要的东西
(setq mark-ring-max 1024) ;设置的mark ring容量
(setq eval-expression-print-length nil) ;设置执行表达式的长度没有限制
(setq eval-expression-print-level nil)  ;设置执行表达式的深度没有限制
(auto-compression-mode 1)               ;打开压缩文件时自动解压缩
(setq read-quoted-char-radix 16)        ;设置 引用字符 的基数
(setq global-mark-ring-max 1024)        ;设置最大的全局标记容量

(setq isearch-allow-scroll t)           ;isearch搜索时是可以滚动屏幕的
(setq enable-recursive-minibuffers t)   ;minibuffer 递归调用命令
(setq history-delete-duplicates t)      ;删除minibuffer的重复历史
(setq minibuffer-message-timeout 1)     ;显示消息超时的时间
(setq auto-revert-mode 1)               ;自动更新buffer
(show-paren-mode t)                     ;显示括号匹配
(setq show-paren-style 'parentheses) ;括号匹配显示但不是烦人的跳到另一个括号。
(setq blink-matching-paren nil)      ;当插入右括号时不显示匹配的左括号
(setq message-log-max t)         ;设置message记录全部消息, 而不用截去
(setq require-final-newline nil) ;不自动添加换行符到末尾, 有些情况会出现错误
(setq ediff-window-setup-function (quote ediff-setup-windows-plain)) ;比较窗口设置在同一个frame里
(setq x-stretch-cursor t)         ;光标在 TAB 字符上会显示为一个大方块
(put 'narrow-to-region 'disabled nil)   ;开启变窄区域
(setq print-escape-newlines t)          ;显示字符窗中的换行符为 \n
(setq tramp-default-method "ssh")       ;设置传送文件默认的方法
(setq void-text-area-pointer nil)       ;禁止显示鼠标指针
(setq byte-compile-warnings
      (quote (
              ;; 显示的警告
              free-vars                 ;不在当前范围的引用变量
              unresolved                ;不知道的函数
              callargs                  ;函数调用的参数和定义的不匹配
              obsolete                  ;荒废的变量和函数
              noruntime                 ;函数没有定义在运行时期
              interactive-only          ;正常不被调用的命令
              make-local ;调用 `make-variable-buffer-local' 可能会不正确的
              mapcar     ;`mapcar' 调用
              ;;
              ;; 抑制的警告
              (not redefine)        ;重新定义的函数 (比如参数数量改变)
              (not cl-functions)    ;`CL' 包中的运行时调用的函数
              )))
(setq echo-keystrokes 0.1)              ;加快快捷键提示的速度
(tooltip-mode -1)                       ;不要显示任何 tooltips


(blink-cursor-mode -1)                  ;指针不闪动
(transient-mark-mode 1)                 ;标记高亮
(global-subword-mode 1)                 ;Word移动支持 FooBar 的格式
(setq use-dialog-box nil)               ;never pop dialog
(setq inhibit-startup-screen t)         ;inhibit start screen
(setq initial-scratch-message "") ;关闭启动空白buffer, 这个buffer会干扰session恢复
(setq-default comment-style 'indent)    ;设定自动缩进的注释风格
(setq ring-bell-function 'ignore)       ;关闭烦人的出错时的提示声
(setq default-major-mode 'text-mode)    ;设置默认地主模式为TEXT模式
(setq mouse-yank-at-point t)            ;粘贴于光标处,而不是鼠标指针处
(setq split-width-threshold nil)        ;分屏的时候使用上下分屏
(setq inhibit-compacting-font-caches t) ;使用字体缓存，避免卡顿
(setq confirm-kill-processes nil)       ;退出自动杀掉进程
(setq async-bytecomp-allowed-packages nil) ;避免magit报错
(setq word-wrap-by-category t)             ;按照中文折行

(setq ad-redefinition-action 'accept)   ;不要烦人的 redefine warning
(setq frame-resize-pixelwise t) ;设置缩放的模式,避免Mac平台最大化窗口以后右边和下边有空隙

(setq confirm-kill-emacs 'yes-or-no-p) ;退出需要确认

;; 平滑地进行半屏滚动，避免滚动后recenter操作
(setq scroll-step 1
      scroll-conservatively 10000)


;; 自动保存 停止敲键盘超过一定秒数后就自动保存
(require 'auto-save)
(auto-save-enable)
(setq auto-save-slient t)
(setq auto-save-delete-trailing-whitespace t)
;;(setq auto-save-idle 5)

;; 启动server
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

(provide 'init-misc)
