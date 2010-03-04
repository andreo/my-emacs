
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

(setq auto-mode-alist (cons '("\\.ipp$" . c++-mode) auto-mode-alist))
