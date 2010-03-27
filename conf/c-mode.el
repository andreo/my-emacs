
;; switch between cpp/hpp files
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "C-c o") 'ff-find-other-file)
            ;; (c-set-style "gnu")
            ))

;; highlight some words
(add-hook 'c-mode-common-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(FIXME\\|TODO\\|BUG\\):"
                                       1
                                       font-lock-warning-face t)))))

(add-to-list 'auto-mode-alist '("\\.ipp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.etest$" . emacs-lisp-mode))
