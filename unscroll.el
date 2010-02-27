;;; unscroll.el --- Unscroll cursor

;;; Code:
(defvar unscroll-point (make-marker) "Cursor position for next call of 'unscroll'.")
(defvar unscroll-window-start (make-marker) "Window start for next call to 'unscroll'.")
(defvar unscroll-hscroll nil "Hscroll for next call of 'unscroll'.")

(put 'scroll-up 'unscrollable t)
(put 'scroll-down 'unscrollable t)
(put 'scroll-left 'unscrollable t)
(put 'scroll-right 'unscrollable t)

(defun unscroll-maybe-remember ()
  (if (not (get last-command 'unscrollable))
      (progn
        (set-marker unscroll-point (point))
        (set-marker unscroll-window-start (window-start))
        (setq unscroll-hscroll (window-hscroll)))))

(defadvice scroll-down (before
                        remember-for-unscroll
                        activate
                        compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-up (before
                      remember-for-unscroll
                      activate
                      compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-left (before
                        remember-for-unscroll
                        activate
                        compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-right (before
                         remember-for-unscroll
                         activate
                         compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defun unscroll()
  "Jump to previous scroll position."
  (interactive)
  (if (not unscroll-point)
      (error "Cannot unscroll yet."))
  (goto-char unscroll-point)
  (set-window-start nil unscroll-window-start)
  (set-window-hscroll nil unscroll-hscroll))

(provide 'unscroll)

;;; unscroll.el ends here
