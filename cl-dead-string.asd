#|
  This file is a part of cl-dead-string project.
|#

(defsystem "cl-dead-string"
  :version "0.1.0"
  :author "daisuke-nakatani"
  :license "MIT"
  :depends-on (:series :cl-syntax)
  :components ((:module "src"
                :components
                ((:file "cl-dead-string"))))
  :description "trivial string read-macro like python's tripple double-quote."
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op "cl-dead-string-test"))))
