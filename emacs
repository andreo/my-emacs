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
(windmove-default-keybindings 'meta)
(setq scroll-step 1)
(global-hl-line-mode 1)

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
(add-to-list 'load-path "~/.emacs.d/magit")
(require `magit)
(global-set-key (kbd "\e\emg") 'magit-status)

;; ruby mode
(add-to-list 'load-path "~/.emacs.d/ruby/ruby-emacs")
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; rails
(add-to-list 'load-path "~/.emacs.d/ruby/emacs-rails")
(require 'rails)

