(defvar my/yas-directory
  "~/.emacs.d/my-emacs/yasnippet/"
  "Directory of yasnippet")

(add-to-list 'load-path my/yas-directory)

(defun my/yas/compile-bundle ()
  "Compile yasnippet bundle with my local settings"
  (interactive)
  (let* ((default-directory my/yas-directory))
    (add-to-list 'load-path (concat default-directory "yasnippet/"))
    (require 'yasnippet)

    (yas/compile-bundle "yasnippet/yasnippet.el"
                        "yasnippet-bundle.el"
                        "snippets/"
                        nil
                        "yasnippet/dropdown-list.el")
    (byte-compile-file "yasnippet-bundle.el")))

(require 'yasnippet-bundle)

(setq yas/triggers-in-field t)
(setq yas/also-auto-indent-first-line t)
(setq yas/root-directory (concat my/yas-directory "snippets/"))

