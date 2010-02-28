(server-start)

(add-to-list 'load-path "~/.emacs.d/my-emacs")
(add-to-list 'load-path "~/.emacs.d/my-emacs/auto-install")

(load-file "~/.emacs.d/my-emacs/conf/general.el")
(load-file "~/.emacs.d/my-emacs/conf/ibuffer.el")
(load-file "~/.emacs.d/my-emacs/conf/c-mode.el")

;; smart compilation
(defun jam-project? ()
  "The directory is jam project when it contains 'Jamroot' or 'Jamfile'."
  (or (file-exists-p "Jamroot")
      (file-exists-p "Jamfile")))

(defun smart-compile()
  "Defines project type and compiles it."
  (interactive)
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
  (require 'multi-term)
  (global-set-key (kbd "\e\e1") 'multi-term))
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
(require 'google-translate)
(add-to-hash-table guess-language-table
                   (list 'en 'ru
                         'ru 'en
                         'uk 'en))

(global-set-key (kbd "\e\etw")
                (lambda ()
                  (interactive)
                  (print (google-translate-current-word))))
