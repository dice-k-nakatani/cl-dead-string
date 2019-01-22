(defpackage cl-dead-string-test
  (:use :cl
        :cl-dead-string
        :prove))
(in-package :cl-dead-string-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-dead-string)' in your Lisp.

(plan nil)

(syntax:use-syntax :cl-dead-string)

;; blah blah blah.
(is "abc" #"abc"#)
(is "ab\\nc" #"ab\nc"#)
(is "ab\\sc" #"ab\sc"#)
(is "ab\"c" #"ab"c"#)
(is "ab
c" #"ab
c"#)

(finalize)
