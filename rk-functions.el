;;; From http://pages.sachachua.com/.emacs.d/Sacha.html#org04e47b9
(defun rk/unfill-paragraph (&optional region)
    "Takes a multi-line paragraph and makes it into a single line of text."
    (interactive (progn
                   (barf-if-buffer-read-only)
                   (list t)))
    (let ((fill-column (point-max)))
      (fill-paragraph nil region)))

(bind-key "M-Q" 'rk/unfill-paragraph)

(defun rk/fill-or-unfill-paragraph (&optional unfill region)
    "Fill paragraph (or REGION).
  With the prefix argument UNFILL, unfill it instead."
    (interactive (progn
                   (barf-if-buffer-read-only)
                   (list (if current-prefix-arg 'unfill) t)))
    (let ((fill-column (if unfill (point-max) fill-column)))
      (fill-paragraph nil region)))

(bind-key "M-q" 'rk/fill-or-unfill-paragraph)

(provide 'rk-functions)
