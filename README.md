我的Emacs配置文件


# 字体
- `M-x all-the-icons-install-fonts` 不能下载的可以直接下载字体
	- [fonts](https://github.com/domtronn/all-the-icons.el/tree/master/fonts)
	- [Symbola.zip](https://dn-works.com/wp-content/uploads/2020/UFAS-Fonts/Symbola.zip)
    
- 中文（显示）：更纱黑体 Sarasa Mono SC: https://github.com/be5invis/Sarasa-Gothic
- 英文（显示）：Fira Code : https://github.com/tonsky/FiraCode/wiki/Installing
- 中英文（PDF) ：Noto CJK SC: https://github.com/googlefonts/noto-cjk.git
- Symbols 字体: Noto Sans Symbols 和 Noto Sans Symbols2: https://fonts.google.com/noto
- 花園明朝：HanaMinB：http://fonts.jp/hanazono/
- Emacs 默认后备字体：Symbola: https://dn-works.com/ufas/    
    
# 其他
- 搜索需要用到AG [ggreer/the_silver_searcher: A code-searching tool similar to ack, but faster.](https://github.com/ggreer/the_silver_searcher)
- custom.el

```elisp
;; 本地org文件目录
(setq local-cloud-directory "d:/Temp/orgfile/")
;; 本地备份目录
(setq local-backup-directory "d:/Temp/backup/")
;; 本地自动保存目录
(setq local-autosave-directory "d:/Temp/backup/autosave/")

;; 个人信息
(setq user-full-name "someone")
(setq user-mail-address "xx@ss.com")
```
