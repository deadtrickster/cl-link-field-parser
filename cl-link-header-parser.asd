(asdf:defsystem :cl-link-header-parser
  :serial t
  :version "0.0.1"
  :licence "MIT"
  :depends-on ("alexandria"
               "split-sequence"
               "ia-hash-table")
  :author "Ilya Khaprov <ilya.kharpov@publitechs.com>"
  :components ((:module "src"
                :serial t
                :components
                ((:file "package")
                 (:file "parser"))))
  :description "HTTP Link header field parser")
