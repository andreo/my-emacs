
(add-to-list 'load-path "~/.emacs.d/my-emacs/mozrepl/chrome/content/")
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

(autoload 'inferior-moz-mode "moz" "MozRepl Inferior Mode" t)
(autoload 'moz-minor-mode "moz" "MozRepl Minor Mode" t)
(add-hook 'javascript-mode-hook 'javascript-moz-setup)
(defun javascript-moz-setup () (moz-minor-mode 1))
