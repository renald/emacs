(rk/add-local-lib-to-path "yasnippet")
(require 'yasnippet)

(setq rk/yashome (concat emacs-local "/yasnippet"))
(setq rk/yas-my-snippets (concat emacs-root "/snippets"))
(setq rk/yas-default-snippets (concat rk/yashome "/snippets"))
(setq rk/yas-yasmate-snippets (concat rk/yashome "/yasmate/snippets"))

(setq yas-snippet-dirs
      (list rk/yas-my-snippets
            rk/yas-yasmate-snippets
            rk/yas-default-snippets))

(yas/global-mode 1)

(add-to-list 'auto-mode-alist '(".*snippets/.*" . snippet-mode))
(provide 'setup-yasnippet)
