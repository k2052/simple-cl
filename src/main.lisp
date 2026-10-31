(defpackage :hello-world
  (:use :cl)
  (:export :main
           :concat-strings
           :%concat-strings
           :list-of-strings
           :list-of-strings-p))

(in-package :hello-world)

(declaim (optimize (safety 3) (speed 3)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (setq sb-ext:*derive-function-types* t))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun list-of-strings-p (list)
    "Return t if LIST is non nil and contains only strings."
    (and (consp list)
         (every #'stringp list)))

  (deftype list-of-strings ()
    `(satisfies list-of-strings-p)))

(defun %concat-strings (strings)
  (check-type strings list-of-strings)
  (apply #'concatenate 'string strings))

(defmacro concat-strings (strings)
  (if (and (consp strings)
           (eq (first strings) 'quote)
           (consp (second strings)))
      (let ((items (second strings)))
        (unless (list-of-strings-p items)
          (error "Compile-time type error: ~S is not a list-of-strings"
                 items))
        `(%concat-strings ,strings))
      `(%concat-strings ,strings)))

(defun main ()
  (format t "Hello, Cats!~%")
  (format t "~A~%" (concat-strings '("2" "3"))))
