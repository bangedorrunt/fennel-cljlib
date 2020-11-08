(require-macros :test.test)
(require-macros :macros.core)
(local {: eq} (require :core)) ;; required for testing

(require-macros :macros.fn)

(deftest fn*
  (when-meta
    (testing fn*-meta
      (fn* f
        "docstring"
        [x] x)
      (assert-eq (meta f) {:fnl/docstring "docstring"
                           :fnl/arglist ["x"]})

      (fn* f
        "docstring"
        ([x] x))
      (assert-eq (meta f) {:fnl/docstring "docstring"
                           :fnl/arglist ["x"]})

      (fn* f
        "docstring"
        ([x] x)
        ([x y] (+ x y)))
      (assert-eq (meta f) {:fnl/docstring "docstring"
                           :fnl/arglist ["\n  [x]"
                                         "\n  [x y]"]})

      (fn* f
        "docstring"
        ([x] x)
        ([x y] (+ x y))
        ([x y & z] (+ x y)))
      (assert-eq (meta f) {:fnl/docstring "docstring"
                           :fnl/arglist ["\n  [x]"
                                         "\n  [x y]"
                                         "\n  [x y & z]"]}))))

(deftest fn&
  (when-meta
    (testing fn&-meta
      (fn& f "docstring" [x] x)
      (assert-eq (meta f) {:fnl/docstring "docstring"
                           :fnl/arglist ["x"]})

      (fn& f "docstring" [...] [...])
      (assert-eq (meta f) {:fnl/docstring "docstring"
                           :fnl/arglist ["..."]}))))
