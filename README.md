# Cl-Dead-String

common lisp is great language.
but I envy perl's regex literal (`m/xxx/`) or python's triple double-quote (`"""xxx"""`).
perl's here document is also good.

in common lisp, regular expression is annoying. like this.

```lisp
(ppcre:scan "\\s+(\\d+)\\s+" "abcdef 1050 zzzz \" xx ")
```

so I make trivial reader macro with cl-syntax definition.

now you can write like this.

```lisp
(ppcre:scan #"\s+(\d+)\s+"# #"abcdef 1050 zzzz " xx "#)
```

## Usage

please see above text or tests/*.lisp.

you can use like this.

```lisp

;; it is not in quicklisp repository. so you have to pushnew the path.
(pushnew
 #p"~/dev/cl-dead-string/"
 asdf:*central-registry*
 :test #'equal)
 
(ql:quickload :cl-dead-string) 
(defpackage cl-scratch
  (:nicknames :scratch)
  (:use :cl))
(in-package :cl-scratch)
(cl-syntax:use-syntax :cl-dead-string)

(list #"aaaa\bbb"ddd"#)
```

## Installation

normal asdf project.
use roswell or quicklisp's local-projects or so.

## Trivial know how

some cheat to avoid emacs's syntax table trouble.

```lisp

;; cheat syntax table
(add-hook 'lisp-mode-hook
          (lambda ()
            ;; make #" "# act like as #| |# (multiline comment)
            (modify-syntax-entry ?#  "' 14b")
            (modify-syntax-entry ?\" "\" 23bn")
            ))

;; avoid auto indent inside multiline comment.
(defun indent-for-tab-command-around (original &rest args)
  (let (inside-comment-p)
    (save-excursion
      (beginning-of-line)
      (setf inside-comment-p (nth 4 (syntax-ppss))))
    (unless inside-comment-p
      (apply original args))))

(advice-add
 'indent-for-tab-command
 :around 'indent-for-tab-command-around)
 
;; lisp-mode.el's multi-line comment indentation is annoying.
;; trivial altanative script
(defun dn-indent-sexp (&optional endpos)
  "altenative sexp indent function"
  (interactive)
  (let ((parse-state (lisp-indent-initial-state)))
    (setq endpos (copy-marker
                  (if endpos endpos
                    (save-excursion (forward-sexp 1) (point)))))
    (save-excursion
      (while (progn
               (indent-for-tab-command)
               (next-line)
               (beginning-of-line)
               (< (point) endpos))))
    (move-marker endpos nil)))
 
```
