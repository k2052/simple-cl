(require 'asdf)
(setq *block-compile-default* t)
;; (declaim (optimize (speed 0) (safety 0) (debug 0)))
;; Ensure ASDF can find the .asd file in the current directory
(push (uiop:getcwd) asdf:*central-registry*)

;; Load the system and force recompilation to display warnings
(asdf:load-system :hello-world :force t)

;; Save the binary using SBCL
(ensure-directories-exist "build/hello-world")
(sb-ext:save-lisp-and-die "build/hello-world"
                          :toplevel #'hello-world:main
                          :executable t)
