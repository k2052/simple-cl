(defpackage :hello-world/tests
  (:use :cl :fiveam :hello-world)
  (:export :hello-world-suite))

(in-package :hello-world/tests)

(def-suite hello-world-suite
  :description "Test suite for hello-world")

(in-suite hello-world-suite)

(test list-of-strings-predicate
  "Test list-of-strings-p predicate with valid and invalid inputs."
  (is-true (list-of-strings-p '("a" "b" "c")))
  (is-true (list-of-strings-p '("single")))
  (is-true (list-of-strings-p '("" "")))
  (is-false (list-of-strings-p '()))
  (is-false (list-of-strings-p '(1 2 3)))
  (is-false (list-of-strings-p '("a" 2 "b")))
  (is-false (list-of-strings-p 42))
  (is-false (list-of-strings-p "not a list"))
  (is-false (list-of-strings-p nil)))

(test concat-strings-function
  "Test runtime string concatenation and error handling."
  (is (string= "helloworld" (concat-strings '("hello" "world"))))
  (is (string= "23" (concat-strings '("2" "3"))))
  (is (string= "foo bar baz" (concat-strings '("foo " "bar " "baz"))))
  (let ((words (list "dynamic" "-" "strings")))
    (is (string= "dynamic-strings" (concat-strings words))))
  (let ((bad-args (list 1 2 3)))
    (signals type-error (%concat-strings bad-args))
    (signals type-error (concat-strings bad-args))))

(test concat-strings-compile-time-macro
  "Test that concat-strings macro signals compile-time error on invalid literals."
  (signals error
    (macroexpand-1 '(concat-strings '(1 2 3))))
  (signals error
    (macroexpand-1 '(concat-strings '(10))))
  (signals error
    (macroexpand-1 '(concat-strings '("ok" 42)))))

(test main-output
  "Test that main prints expected messages to standard output."
  (let ((output (with-output-to-string (*standard-output*)
                  (main))))
    (is-true (search "Hello, Cats!" output))
    (is-true (search "23" output))))
