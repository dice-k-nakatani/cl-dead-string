(defpackage cl-dead-string
  (:nicknames :dead-string)
  (:use :cl :series))
(in-package :cl-dead-string)

(defun |#"-reader| (stream sub-char numarg)
  (declare (ignore sub-char))
  (collect
      'string
    (until-if
     #'null
     (mapping (((x next) (chunk 2 1 (scan-stream stream #'read-char))))
       (if (and (char= #\" x)
                (char= #\# next))
           nil
           x)))
    ))

(in-package :cl-user)
(cl-syntax:define-package-syntax :cl-dead-string
  (:merge :standard)
  (:dispatch-macro-char #\# #\" #'cl-dead-string::|#"-reader|))

