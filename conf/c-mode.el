
;; switch between cpp/hpp files
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; highlight some words
(add-hook 'c-mode-common-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(FIXME\\|TODO\\|BUG\\):"
                                       1
                                       font-lock-warning-face t)))))
;; set codding style
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (c-set-style "gnu")))
