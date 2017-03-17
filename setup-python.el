(require 'package)
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))
(package-initialize)

(add-hook 'python-mode-hook (lambda ()(
                                       (abbrev-mode 1)
                                       (auto-fill-mode 1)
                                       (linum-mode 1)
                                       (if (eq window-system 'x)
                                           (font-lock-mode 1))
                                       (elpy-enable))))

(provide 'setup-python)
