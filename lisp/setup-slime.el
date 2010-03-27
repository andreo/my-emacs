;; slime
(add-to-list 'load-path "~/.emacs.d/my-emacs/lisp/slime/")
(add-to-list 'load-path "~/.emacs.d/my-emacs/lisp/slime/contrib/")

;; clojure-mode
(add-to-list 'load-path "~/.emacs.d/my-emacs/lisp/clojure-mode")

;; swank-clojure
(add-to-list 'load-path "~/.emacs.d/my-emacs/lisp/swank-clojure")

(require 'swank-clojure)

;; slime
(require 'slime)

(eval-after-load "slime"
  `(progn
     (slime-setup '(slime-repl))
     (add-to-list 'slime-lisp-implementations '(sbcl ("/usr/bin/sbcl")))
     (add-to-list 'slime-lisp-implementations '(clisp ("clisp")))
     (custom-set-variables
      '(inhibit-splash-screen t)
      '(slime-complete-symbol*-fancy t)
      '(slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
      '(slime-net-coding-system 'utf-8-unix)
      '(slime-startup-animation nil))))

(slime-setup)
