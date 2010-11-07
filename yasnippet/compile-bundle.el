
(defun my/yas/compile-bundle ()
  "Compile yasnippet bundle with my local settings"
  (interactive)
  (let* ((default-directory "~/.emacs.d/my-emacs/yasnippet/"))
    (add-to-list 'load-path (concat default-directory "yasnippet/"))
    (require 'yasnippet)
    
    (yas/compile-bundle "yasnippet/yasnippet.el"
                        "yasnippet-bundle.el"
                        "snippets/"
                        nil
                        "yasnippet/dropdown-list.el")))
