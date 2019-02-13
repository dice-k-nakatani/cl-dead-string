#|
  This file is a part of cl-dead-string project.
|#

(defsystem "cl-dead-string-test"
  :defsystem-depends-on ("prove-asdf")
  :author "dice-k-nakatani"
  :license "MIT"
  :depends-on ("cl-dead-string"
               "prove"
               :cl-syntax
               :cl-ppcre
               )
  :components ((:module "tests"
                :components
                ((:test-file "cl-dead-string"))))
  :description "Test system for cl-dead-string"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
