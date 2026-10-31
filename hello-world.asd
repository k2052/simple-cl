(defsystem "hello-world"
  :version "0.1.0"
  :author "Author"
  :license "MIT"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "A simple hello world app"
  :build-operation "program-op"
  :build-pathname "build/hello-world"
  :entry-point "hello-world:main"
  :in-order-to ((test-op (test-op "hello-world/tests"))))

(defsystem "hello-world/tests"
  :author "Author"
  :license "MIT"
  :depends-on ("hello-world" "fiveam")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test suite for hello-world"
  :perform (test-op (o c)
             (symbol-call :fiveam :run!
                          (find-symbol* :hello-world-suite :hello-world/tests))))
