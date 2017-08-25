(rk/add-local-lib-to-path "org-mode/lisp")
(rk/add-local-lib-to-path "org-mode/contrib/lisp")

(require 'org)

; You can bulk archive (or refile/change todo etc) from within the Agenda view.
; 
; ; http://orgmode.org/manual/Agenda-commands.html#Agenda-commands
; 
; ; If you call Org-Agenda from within the buffer you want to archive you can temporarily restrict it to only that buffer and view only todo entries and filter for only DONE
; 
; ; C-c a < t
; N r
; ; Where N corresponds to the shortcut for your DONE state (with default states it would be 2)
; 
; ; Then you'd simply need to mark all the desired headlines and bulk archive
; 
; ; m (mark for bulk action)
; B a (or B $ for arch->sibling)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cr" 'org-capture)


;; Templates


;;; I want notes organised per day. Thanks
;;; http://www.howardism.org/Technical/Emacs/journaling-org.html for showing how to do this!

(setq work-notes-dir
  (concat (or (getenv "WORKDIR") (concat (getenv "HOME") "/Work/gdd"))
          "/Notes/"))

(defun get-notes-file-today ()
  "Return filename for today's journal entry."
  (let ((daily-name (format-time-string "%Y%m%d")))
    (expand-file-name (concat work-notes-dir daily-name))))

;; Set to orgmode by default when viewing notes
;(setq work-notes-rx (concat work-notes-dir ".*/[0-9]*$"))
(add-to-list 'auto-mode-alist '("Notes.*/[0-9]*$" . org-mode))

(setq org-capture-templates
      '(
;        ("t" "Todo"    entry (file+headline "~/org/todo.org" "Tasks")
;         "* TODO %?\n  %i\n  %a")
;        ("T" "Work - Backlog" entry (file "~/org/operations/operations.trello")
;         "* BACKLOG %?\n")
;        ("!" "Work - Today" entry (file "~/org/operations/operations.trello")
;         "* TODAY %?\n")
        ("j" "Journal" entry (file "~/Drives/Dropbox (Personal)/personal/journal.org" )
         "* %^u\n%?\n** Leerpunten\n** Meer doen\n** Dankbaar\n")
        ("n" "Note" entry (file (get-notes-file-today))
         "* %<%H:%M:%S>\n%?\n"
         :empty-lines 1)
        ))

;(setq org-agenda-skip-scheduled-if-done 't)
(setq org-log-done nil)
(setq org-hide-leading-stars t)
(setq org-log-note-state t)
(setq org-todo-keywords
      '((type
         "TODO(t)"     ; to be done in the near future
         "STARTED(s!)" ; on going at the moment
         "WAITING(w)"  ; was started, now waiting for external factor
         "BLOCKED(b)"  ; was started, but cannot continue until something is fixed
;         "APPT(a)"     ; appointment
         "|"
         "CANCELLED"   ; won't be done
;         "DEFERRED(e)" ; maybe in the future
         "DONE(d!/!)"  ; finished!
         )
;        (sequence "PROJECT(p)" "|" "FINISHED(f)")
;        (sequence "INVOICE(i)" "SENT(n)" "|" "RCVD(r)")
))

;(setq org-todo-keyword-faces
 ;     '( ("BLOCKED(b)" . (:foreground "yellow" :weight bold))))

; gebruik speciaal format, zie http://orgmode.org/org.html#Weekly_002fdaily-agenda
;(setq org-agenda-include-all-todo nil)
; I prefer return to activate a link
(setq org-return-follows-link nil)

; Do not add a newline after a header
;(setq org-blank-before-new-entry (quote ((heading . nil) ; was: auto
;                                         (plain-list-item . auto))))

(setq org-default-notes-file 
      (convert-standard-filename "~/org/todo.org"))

(setq org-agenda-custom-commands
      '(("l" todo "LATER" nil)
        ("b" todo "BLOCKED" nil)
        ("w" todo "THIS-WEEK" nil)
        ("W" todo "WAITING" nil)
        ("!" "Scheduled and TODAY items"
         ((agenda "Normal agenda" ((org-agenda-ndays 1)))
          (todo "TODAY|WAITING")
          ;;          (tags "something")
          )
         ((org-sorting-strategy '(todo-state-down))
          (org-agenda-compact-blocks t))
          )))
;;             ("W" agenda "" ((org-agenda-ndays 21)))
;;              ( "A" agenda ""
;;                ((org-agenda-skip-function
;;                  (lambda nil
;;                    (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
;;                 (org-agenda-ndays 1)
;;                 (org-agenda-overriding-header "Today's Priority #A tasks: ")))
;;               ("u" alltodo ""
;;                ((org-agenda-skip-function
;;                  (lambda nil
;;                    (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
;;                                              (quote regexp) "<[^>\n]+>")))
;;                (org-agenda-overriding-header "Unscheduled TODO entries: "))))

;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
(setq org-replace-disputed-keys t)

;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

;; Export backends
(require 'ox-beamer)
(require 'ox-md)
(require 'ox-html)
(require 'ox-latex)

;(require 'ox-icalendar)

;; From contrib. Open something in one of the following applications:
;; 1. 
(require 'org-mac-link)
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))



; From contrib. Allows you to specify a git file like [[git:/path/to/file::searchstring]]
;(require 'org-git-link)

(add-hook 'org-mode-hook
          (let ((original-command (lookup-key org-mode-map [tab])))
            `(lambda ()
               (setq yas-fallback-behavior
                     '(apply ,original-command))
               (local-set-key [tab] 'yas-expand))))

(provide 'setup-org)

;; Monkey-patch org-trello to resolve issue with indenting comments

;(defun orgtrello-entity/compute-first-comment-point! ()
;  "Compute the card's first comment position.
;Does preserve position.
;If no comment is found, return the card's end region."
;  (save-excursion
;    (orgtrello-entity/back-to-card!)
;    (let ((card-region (orgtrello-entity/compute-card-region!)))
;      (apply 'narrow-to-region card-region)
;      (let ((next-pt (-if-let (next-pt (search-forward-regexp "[*][*] " nil t)) ;; if not found, return nil and do not move point
;                         (save-excursion
;                           (goto-char next-pt)
;                           (point-at-bol))
;                       (orgtrello-entity/compute-next-card-point!))))
;        (widen)
;        next-pt))))

;; org-trello major mode for all .trello files
;(add-to-list 'auto-mode-alist '("\\.trello$" . org-mode))

;; add a hook function to check if this is trello file, then activate the org-trello minor mode.
;(add-hook 'org-mode-hook
;          (lambda ()
;;            (let ((filename (buffer-file-name (current-buffer))))
;              (when (and filename (string= "trello" (file-name-extension filename)))
;              (org-trello-mode)))))

;(add-hook 'text-mode-hook 'turn-on-orgstruct++)


