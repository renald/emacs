(setq ns-alternate-modifier 'none) ; allow it to be interpreted by OSX
(define-key global-map [(alt ?v)] 'scroll-down)
;(define-key global-map [(meta ?v)] 'yank)


(setq ;mac-option-modifier 'super
      mac-command-modifier 'meta
      ;ns-function-modifier 'hyper
)

; Move to trans
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash/emacs")

; Ignore .DS_Store files with ido mode
;(add-to-list 'ido-ignore-files "\\.DS_Store")


;(require 'htmlize)
;(rk/add-local-lib-to-path "mac-print-mode")
;(require 'mac-print-mode)

(provide 'setup-osx)
