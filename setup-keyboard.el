(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-M-%") 'query-replace-regexp)

(global-set-key "\C-x\C-r" 'recentf-open-files) ; I hate the default binding anyw

; Change the annoying defaults
(global-set-key "\C-z" 'undo)
; Another annoying one
(global-set-key [insert] nil)

; Alternatives to M-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

; more annoyance with the default bindings
(global-set-key [end] 'forward-word) ; instead of end-of-buffer
(global-set-key [home] 'backward-word) ; instead of beginning-of-buffer

(provide 'setup-keyboard)
