# cl-dead-string

## Synopsis

`common lisp` is great language.
But I envy perl's regex literal (`m/xxx/`) or python's triple double-quote (`"""xxx"""`).
Perl's here document is also good.

In common lisp, regular expression is annoying.
Like this:

```text
(ppcre:scan "\\s+(\\d+)\\s+"
  "abcdef 1050 zzzz \" xx ")
```

Ugly. Too much escape characters. So I make trivial reader macro with cl-syntax definition.

Now you can write like this.

```text
(ppcre:scan #"\s+(\d+)\s+"#
  #"abcdef 1050 zzzz " xx "#)
```

This is trivial read-macro. The point is the syntax can act like multiline comment (like `#| |#` on emacs.

So between `#"` and `"#`, you can write anything including `"`, `\`.

You do not have to maintain elisp's `syntax-propertize-function` or something.

I hate read table, but this is some kind of last resort.

## Usage

You can use like this.

```text
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

And `tests/*.lisp` would indicate furthermore.

## Installation

This is an usual asdf project.
You can install with roswell or quicklisp's local-projects or so.

## Trivial know how

Some cheat to avoid emacs's syntax table trouble.

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

## License

This is available under the terms of the [MIT License](http://opensource.org/licenses/MIT).
