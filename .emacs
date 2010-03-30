(server-start)

(add-to-list 'load-path "~/.emacs.d/my-emacs")
(add-to-list 'load-path "~/.emacs.d/my-emacs/auto-install")

(load-file "~/.emacs.d/my-emacs/conf/general.el")
(load-file "~/.emacs.d/my-emacs/conf/ibuffer.el")
(load-file "~/.emacs.d/my-emacs/conf/c-mode.el")
(load-file "~/.emacs.d/my-emacs/conf/mozrepl.el")

(defvar jam-project-name-list
  (list "Jamfile"
        "Jamfile.v2"
        "Jamroot"
        "Jamfile.jam"
        "Jamroot.jam")
  "List of jam project names.")

;; smart compilation
(defun jam-project? ()
  "The directory is jam project when it contains one of `jam-project-name-list'."
  (dolist (name jam-project-name-list)
    (when (file-exists-p name)
      (return t))))

(defun smart-compile()
  "Detect project type and compile it."
  (interactive)
  (save-some-buffers t)
  (if (jam-project?) (compile "bjam debug") (call-interactively 'compile)))

(global-set-key (kbd "<f5>") 'smart-compile)

;; erlang
(when (file-exists-p "~/erlang/")
  (add-to-list 'load-path "~/erlang/lib/tools/emacs")
  (setq erlang-root-dir "~/erlang/lib/tools/emacs")
  (setq exec-path (cons "~/erlang/lib/tools/emacs" exec-path))
  (require 'erlang-start))

;; magit
(add-to-list 'load-path "~/.emacs.d/my-emacs/magit")
(require 'magit)
(global-set-key (kbd "\e\emg") 'magit-status)

;; ruby mode
(add-to-list 'load-path "~/.emacs.d/my-emacs/ruby/ruby-emacs")
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; rails
(add-to-list 'load-path "~/.emacs.d/my-emacs/ruby/emacs-rails")
(require 'rails)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode t)
 '(column-number-mode t)
 '(rails-ws:default-server-type "webrick")
 '(save-place t nil (saveplace))
 '(show-paren-mode t)
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; jump
(add-to-list 'load-path "~/.emacs.d/my-emacs/jump")

;; rinari
(add-to-list 'load-path "~/.emacs.d/my-emacs/ruby/rinari")
(require 'rinari)

;; rhtml
(add-to-list 'load-path "~/.emacs.d/my-emacs/ruby/rhtml")
(require 'rhtml-mode)


;; color-theme
;;(add-to-list 'load-path "~/.emacs.d/my-emacs/color-theme")
;;(require 'color-theme)
;;(color-theme-initialize)
;;(color-theme-arjen)

(load "~/.emacs.d/my-emacs/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-font-lock)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; run my org mode
;; (find-file "~/.emacs.d/my-emacs/my.org")

;; terminal
(cond
 ((equal system-type 'gnu/linux)
  (global-set-key (kbd "\e\e1")
                  (lambda()
                    (interactive)
                    (ansi-term "/bin/bash"))))
 (t
  (global-set-key (kbd "\e\e1") 'eshell)))

;; anything
(require 'anything-config)

;; jabber
(add-to-list 'load-path "~/.emacs.d/my-emacs/jabber")
(require 'jabber-autoloads)

;; ;; auto-install
;; (require 'auto-install)
;; (setq auto-install-directory "~/.emacs.d/my-emacs/auto-install/")
;; (auto-install-update-emacswiki-package-name t)

(load-file "~/.emacs.d/my-emacs/lisp/setup-slime.el")

;; unscroll
(require 'unscroll)
(global-set-key (kbd "\e\eu") 'unscroll)

;; google translate
(add-to-list 'load-path "~/.emacs.d/my-emacs/google-translate/")
(require 'google-translate)
(setq gt-guess-language-table
      (list 'en 'ru
            'ru 'en
            'uk 'en))

(global-set-key (kbd "\e\etw")
                (lambda ()
                  (interactive)
                  (message "%s" (gt-translate-current-word))))

;; etest
(add-to-list 'load-path "~/.emacs.d/my-emacs/etest/")

(add-to-list 'load-path "~/.emacs.d/my-emacs/emacs-w3m/")
(require 'w3m)
