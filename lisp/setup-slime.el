;; clojure-mode
(add-to-list 'load-path "~/.emacs.d/my-emacs/lisp/clojure-mode")
(require 'clojure-mode)

;; swank-clojure
(add-to-list 'load-path "~/.emacs.d/my-emacs/lisp/swank-clojure/src/emacs")

(setq swank-clojure-jar-path "/usr/share/java/clojure.jar"
      swank-clojure-extra-classpaths (list
				      "~/.emacs.d/my-emacs/lisp/swank-clojure/src/main/clojure"
				      "~/.clojure/clojure-contrib-1.0.0/clojure-contrib.jar"))

(require 'swank-clojure-autoload)

;; slime
(add-to-list 'load-path "~/.emacs.d/my-emacs/lisp/slime/")
(add-to-list 'load-path "~/.emacs.d/my-emacs/lisp/slime/contrib/")

(load "slime-autoloads")

(require 'slime)
(require 'slime-autoloads)

(eval-after-load "slime"
  `(progn
     (slime-setup '(slime-repl))
     (add-to-list 'slime-lisp-implementations '(sbcl ("/usr/bin/sbcl")))
     (custom-set-variables
      '(inhibit-splash-screen t)
      '(slime-complete-symbol*-fancy t)
      '(slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
      '(slime-net-coding-system 'utf-8-unix)
      '(slime-startup-animation nil))))


(slime-setup)

