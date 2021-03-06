
;; using the systems 'trash' when deleting files
(setq delete-by-moving-to-trash t)
;; move deleted directory to trash
(defadvice dired-delete-file (around
                              activate-move-to-trash
                              activate
                              compile)
  (if delete-by-moving-to-trash
      (move-file-to-trash (ad-get-arg 0))
    ad-do-it))

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
(global-font-lock-mode 1)
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

(defmacro defrun (function docstring plist)
  `(defun ,function ()
     ,docstring
     (interactive)
     (call-process (getf ,plist system-type) nil 0 nil
                   (expand-file-name default-directory))))

;; gui-environment
(defrun
  run-gui-environment
  "Run gui environment in current directory"

  (list 'windows-nt "explorer.exe"
        'gnu/linux "/usr/bin/nautilus"))

(global-set-key (kbd "\e\ere") 'run-gui-environment)

;; terminal
(defrun
  run-terminal-environment
  "Run terminal in current directory"
  (list 'windows-nt "cmd.exe"
        'gnu/linux "/usr/bin/gnome-terminal"))

(global-set-key (kbd "\e\ert") 'run-terminal-environment)

;; ignore case
(setq read-file-name-completion-ignore-case t)

;;
;;(global-set-key "\r" 'newline-and-indent)

(add-hook 'dired-mode-hook
          '(lambda ()
             (local-set-key "\C-xq" 'wdired-change-to-wdired-mode)))
