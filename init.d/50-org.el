;;;; Org-mode to have neat TODO list.
;;;; Based on http://www.newartisans.com/blog_files/org.mode.day.planner.php

(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(define-key mode-specific-map [?a] 'org-agenda)

; (require 'org-ascii)
; (require 'org-html)

(eval-after-load "org"
  '(progn
     (define-prefix-command 'org-todo-state-map)
     (define-key org-mode-map "\C-cx" 'org-todo-state-map)
     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "f"
       #'(lambda nil (interactive) (org-todo "DEFERRED")))
     (define-key org-todo-state-map "l"
       #'(lambda nil (interactive) (org-todo "DELEGATED")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "STARTED")))
     (define-key org-todo-state-map "w"
       #'(lambda nil (interactive) (org-todo "WAITING")))

     ;; (define-key org-agenda-mode-map "\C-n" 'next-line)
     ;; (define-key org-agenda-keymap "\C-n" 'next-line)
     ;; (define-key org-agenda-mode-map "\C-p" 'previous-line)
     ;; (define-key org-agenda-keymap "\C-p" 'previous-line)
     ))

(require 'remember)

(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map [(control meta ?r)] 'remember)

(setq
 org-agenda-files '("~/EVERYTHING.org")
 org-agenda-include-diary t
 org-agenda-ndays 7
 org-agenda-show-all-dates t
 org-agenda-skip-deadline-if-done t
 org-agenda-skip-scheduled-if-done t
 org-agenda-start-on-weekday nil
 org-deadline-warning-days 14
 org-default-notes-file "~/EVERYTHING.org"
 org-export-with-LaTeX-fragments t
 org-fast-tag-selection-single-key (quote expert)
 org-log-done t
 org-remember-store-without-prompt t
 org-reverse-note-order t
 org-todo-keywords '((sequence "TODO" "DOING" "VERIFY" "|" "DONE" "DELEGATED"))

 org-agenda-custom-commands
 '(("d" todo "DELEGATED" nil)
   ("c" todo "DONE|DEFERRED|CANCELLED" nil)
   ("w" todo "WAITING" nil)
   ("W" agenda "Three weeks" ((org-agenda-ndays 21)))
   ("A" agenda "A priority"
    ((org-agenda-skip-function
      (lambda nil
        (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
     (org-agenda-ndays 1)
     (org-agenda-overriding-header "Today's Priority #A tasks: ")))
   ("u" alltodo "Unscheduled TODO entries"
    ((org-agenda-skip-function
      (lambda nil
        (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
                                  (quote regexp) "<[^>\n]+>")))
     (org-agenda-overriding-header "Unscheduled TODO entries: ")))) 

 remember-annotation-functions (quote (org-remember-annotation))
 remember-handler-functions (quote (org-remember-handler)))
