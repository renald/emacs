;; Some simple macros to more easily tell if we're running
;; GNUEmacs or XEmacs. Taken from the .emacs of
;; sukria@online.fr | http://sukria.online.fr
(defmacro GNUEmacs (&rest x)
  (list 'if (not running-xemacs) (cons 'progn x)))
(defmacro XEmacs (&rest x)
  (list 'if running-xemacs (cons 'progn x)))
(defmacro Xlaunch (&rest x)
  (list 'if (eq window-system 'x) (cons 'progn x)))
(defmacro TTYlaunch (&rest x)
  (list 'if (not window-system) (cons 'progn x)))
(defmacro Maclaunch (&rest x)
  (list 'if (eq window-system 'ns) (cons 'progn x)))

(provide 'os-dependence)
