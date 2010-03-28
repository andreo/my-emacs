
;; using the systems 'trash' when deleting files
(setq delete-by-moving-to-trash t)

;; copy/patse clipboard
(setq x-select-enable-clipboard t)

(global-set-key (kbd "\e\ef") 'find-dired)
(global-set-key (kbd "\e\eg") 'rgrep)
(global-set-key (kbd "<f9>") 'next-error)
(global-set-key (kbd "S-<f9>") 'previous-error)
(global-set-key (kbd "C-<f9>") 'first-error)

;; appearance
(setq font-lock-maximum-decoration t)
(setq visible-bell t)
(setq require-final-newline t)
(setq resize-minibuffer-frame t)
(setq column-number-mode t)
(setq-default transient-mark-mode t)
(setq next-line-add-newlines nil)
(global-font-lock-mode 1 t)
(setq scroll-step 1)

;; dont show startup message
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p) ;;не заставляйте меня печать yes целиком
(setq auto-save-interval 50)

;; for M-x occur
(setq list-matching-lines-default-context-lines 1)

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

;; spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

;;linum-mode
(global-linum-mode 1)

;;disabling tool-bar
(tool-bar-mode -1)

;; find .emacs
(global-set-key (kbd "s-E") ;; .emacs
                (lambda()(interactive)(find-file "~/.emacs.d/my-emacs/.emacs")))

;; cycling through the buffers with Ctrl-Tab
(global-set-key (kbd "<C-tab>") 'bury-buffer)

;; easy switching between visible buffers
(require 'windmove)
(windmove-default-keybindings 'super)

;; showing trailing whitespace
(setq show-trailing-whitespace t)

;; quick switching
(global-set-key (kbd "s-s") ;; scratch
                (lambda()(interactive)(switch-to-buffer "*scratch*")))
(global-set-key (kbd "s-c") ;; .emacs
                (lambda()(interactive)(find-file "~/.emacs.d/my-emacs/.emacs")))
;; gui-environment
(defvar gui-environment
  (list 'windows-nt "explorer.exe"
        'gnu/linux "nautilus")
  "System gui environment plist.")

(defun run-gui-environment ()
  "Run gui environment in current directory"
  (interactive)
  (call-process (getf gui-environment system-type) default-directory))

(global-set-key (kbd "\e\ere") 'run-gui-environment)

;; ignore case
(setq read-file-name-completion-ignore-case t)
