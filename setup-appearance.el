(Xlaunch
 (progn
   (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
  )
)

(setq initial-frame-alist 
      '( (width . 128) 
         (height . 68) ))

(when window-system
  (set-face-attribute 'default nil
;;                      :family "Source Code Pro" :height 120 :weight 'regular))
                      :family "Input Sans Condensed" :height 120 :weight 'regular))

;; Install zenburn color-theme
(add-to-list 'custom-theme-load-path (concat emacs-local "/" "zenburn-emacs"))
(load-theme 'zenburn t)

(provide 'setup-appearance)
