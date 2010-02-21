(defvar unscroll-point nil "Cursor position for next call of 'unscroll'.")
(defvar unscroll-hscroll nil "Hscroll for next call of 'unscroll'.")
(defvar unscroll-window-start nil "Window start for next call to 'unscroll'.")

(defadvice scroll-up (before remember-for-unscroll activate compile)
  "Remember where we started from, for 'unscroll'."
  (if (not (eq last-command 'scroll-up))
      (progn
        (setq unscroll-point (point))
        (setq unscroll-hscroll (window-hscroll))
        (setq unscroll-window-start (window-start)))))

(defun unscroll()
  "Jump to previous scroll position."
  (interactive)
  (goto-char unscroll-point)
  (set-window-start nil unscroll-window-start)
  (set-window-hscroll nil unscroll-hscroll))
