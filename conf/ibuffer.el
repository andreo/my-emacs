
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Org"
                (mode . org-mode))
               ("Directory"
                (mode . dired-mode))
               ("Programming"
                (or
                 (mode . c-mode)
                 (mode . c++-mode)
                 (mode . perl-mode)
                 (mode . python-mode)
                 (mode . haskell-mode)
                 ))
               ("Lisp"
                (or
                 (mode . emacs-lisp-mode)
                 (mode . lisp-mode)
                 (mode . slime-repl-mode)
                 (mode . inferior-emacs-lisp-mode)
                 (mode . lisp-interaction-mode)
                 ))
               ("Terminal"
                (or
                 (mode . term-mode)
                 (mode . eshell-mode)
                 ))
               ("ERC"   (mode . erc-mode))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))
(global-set-key (kbd "C-x C-b") 'ibuffer)
