(add-to-list 'load-path "~/.emacs.d/my-emacs")

(global-set-key (kbd "\e\e1") 'ansi-term)
(global-set-key (kbd "\e\ef") 'find-dired)
(global-set-key (kbd "\e\eg") 'rgrep)

;;;;;;;;;;;;;;;;;
;; APPEARANCE
;;;;;;;;;;;;;;;;;
(setq font-lock-maximum-decoration t)
(setq visible-bell t)
(setq require-final-newline t)
(setq resize-minibuffer-frame t)
(setq column-number-mode t)
(setq-default transient-mark-mode t)
(setq next-line-add-newlines nil)
(global-font-lock-mode 1 t)
;;(windmove-default-keybindings)
(setq scroll-step 1)

(setq inhibit-startup-message t) ;;не показывать сообщение при старте
(fset 'yes-or-no-p 'y-or-n-p) ;;не заставляйте меня печать yes целиком
(setq auto-save-interval 50)
(setq list-matching-lines-default-context-lines 1) ;; for M-x occur

;; counting functions
(defalias 'lc 'count-lines-page)

(iswitchb-mode 1)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(global-set-key "\M-#" 'query-replace-regexp)

;; kill buffer
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-current-buffer)

;; `c` copies current file path into the kill ring
(defun dired-copy-filename ()
  "push the path and filename of the file under the point to the kill ring"
  (interactive)
  (message "added %s to kill ring" (kill-new (dired-get-filename))))

(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "c" 'dired-copy-filename)))

;; spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

;; erlang
(add-to-list 'load-path "~/erlang/lib/tools/emacs")
(setq erlang-root-dir "~/erlang/lib/tools/emacs")
(setq exec-path (cons "~/erlang/lib/tools/emacs" exec-path))
(require 'erlang-start)

;; magit
(add-to-list 'load-path "~/.emacs.d/my-emacs/magit")
(require `magit)
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
(add-to-list 'load-path "~/.emacs.d/my-emacs/color-theme")
(require 'color-theme)
(color-theme-initialize)
(color-theme-arjen)

(load "~/.emacs.d/my-emacs/haskell-mode-2.4/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
