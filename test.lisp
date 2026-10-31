(require 'asdf)

;; Ensure ASDF can find the .asd file in the current directory
(push (uiop:getcwd) asdf:*central-registry*)

#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(ql:quickload :hello-world/tests)

(let ((passed (uiop:symbol-call :fiveam :run!
                                (uiop:find-symbol* :hello-world-suite :hello-world/tests))))
  (unless passed
    (uiop:quit 1)))
