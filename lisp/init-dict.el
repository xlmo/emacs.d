(require 'sdcv)
(setq sdcv-say-word-p t)               ;say word after translation

;(setq sdcv-dictionary-data-dir "~/.stardict/dic")
(setq sdcv-dictionary-data-dir (expand-file-name "~/.stardict/dic"))


(setq sdcv-dictionary-simple-list    ;setup dictionary list for simple search
      '("懒虫简明英汉词典"
        "懒虫简明汉英词典"
        "KDic11万英汉词典"))

(setq sdcv-dictionary-complete-list     ;setup dictionary list for complete search
      '(
        "懒虫简明英汉词典"
        "英汉汉英专业词典"
        "懒虫简明汉英词典"
        "新世纪英汉科技大词典"
        "KDic11万英汉词典"
        "朗道汉英字典5.0"
        "新世纪汉英科技大词典"
        "牛津英汉双解美化版"
	"21世纪双语科技词典"
	"quick_eng-zh_CN"
        ))

(provide 'init-dict)
