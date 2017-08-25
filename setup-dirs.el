(defvar emacs-tmp-dir
  (concat emacs-root "/tmp")
  "base directory where to store files like backups and autosaves ")

; set autosave directory
; http://snarfed.org/space/gnu%20emacs%20backup%20files
(defvar autosave-dir (concat emacs-tmp-dir "/autosaves/"))
(make-directory autosave-dir t)

; backup directory
(defvar backup-dir (concat emacs-tmp-dir "/backups/"))
(setq backup-directory-alist (list (cons "." backup-dir)))
; diskspace is cheap!
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)

; saveplace: save location in file when saving files
(setq save-place-file (concat emacs-tmp-dir "/saveplace"))
(setq-default save-place t)            ;; activate it for all buffers
(require 'saveplace)                   ;; get the package

; savehist: save some history
; also save my search entries, see http://fasciism.com/2017/01/13/remembering-history/
(setq savehist-additional-variables
      '(search-ring
        kill-ring
        extended-command-history
        buffer-name-history
        file-name-history
        compile-command
        regexp-search-ring))

; save every minute
(setq savehist-autosave-interval 60)     ;; save every minute (default: 5 min)
; location of the history file
(setq savehist-file
      (concat emacs-tmp-dir "savehist")) ;; keep my home clean
; turn it on!
(savehist-mode t)                       ;; do customization before activation

; make informative temporary filenames
(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

;; bury *scratch* buffer instead of killing it
;; http://stackoverflow.com/questions/234963/re-open-scratch-buffer-in-emacs
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
        (bury-buffer)
      ad-do-it)))

(provide 'setup-dirs)
