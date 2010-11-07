(defvar my/yas-directory
  "~/.emacs.d/my-emacs/yasnippet/"
  "Directory of yasnippet")

(add-to-list 'load-path my/yas-directory)

(require 'yasnippet-bundle)
(load-file (concat my/yas-directory "compile-bundle.el"))

(setq yas/triggers-in-field t)
(setq yas/also-auto-indent-first-line t)
(setq yas/root-directory (concat my/yas-directory "snippets/"))
