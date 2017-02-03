(rk/add-local-lib-to-path "dash.el")
(rk/add-local-lib-to-path "with-editor")
(rk/add-local-lib-to-path "magit/lisp")

;;(require 'magit)
;;; Instead of requiring the feature magit, you could load just the autoload definitions, by loading
;;; the file magit-autoloads.el.
(load "magit/lisp/magit-autoloads")

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               (concat emacs-local "magit/Documentation")))

(global-set-key (kbd "C-x g") 'magit-status)

(provide 'setup-magit)
