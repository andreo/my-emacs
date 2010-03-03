
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Org"
                (mode . org-mode))
               ("Programming"
                (or
                 (mode . c-mode)
                 (mode . perl-mode)
                 (mode . python-mode)
                 (mode . emacs-lisp-mode)
                 (mode . haskell-mode)
                 (mode . lisp-mode)
                 ;; etc
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
