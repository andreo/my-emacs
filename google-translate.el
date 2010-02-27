;;; google-translate.el --- Google Translate API
(require 'url)
(require 'json)

;;; Commentary:
;; usage:
;;   (google-detect-language "Detect the language of this text")
;;   (google-detect-language "Привет, лошарики!")
;;   (google-translate "Hello world!" "en" "ru")
;;   (google-translate-dwin "Some text")

;;; Code:
(defun url-data (url)
  "Retrieve data, header and status of URL."
  (with-current-buffer
      (url-retrieve-synchronously url)

    (setq status url-http-response-status)
    ;; return the header and the data separately
    (goto-char (point-min))
    (if (search-forward-regexp "^$" nil t)
        (setq header (buffer-substring (point-min) (point))
              data   (buffer-substring (1+ (point)) (point-max)))
      ;; unexpected situation, return the whole buffer
      (setq data (buffer-string))))
  ;; (print data)
  (values data header status))

(defun url-retrieve-json (url)
  "Retrieve json result of URL as a plist."
  (let ((data (first (url-data url)))
        (json-object-type 'plist))
    (json-read-from-string data)))





(defvar google-detect-language-base-url
  "http://ajax.googleapis.com/ajax/services/language/detect")

(defun google-make-detect-language-url (text)
  "Make url to detect language of TEXT."
  (concat google-detect-language-base-url
          "?v=1.0"
          "&q=" (url-hexify-string text)))

(defun google-detect-language (text)
  "Retrieve language of TEXT."
  (let* ((url (google-make-detect-language-url text))
         (json (url-retrieve-json url)))
    (getf (getf json :responseData) :language)))



(defvar google-translate-base-url
  "http://ajax.googleapis.com/ajax/services/language/translate")

(defun google-make-translate-url (text from to)
  "Make url to translate TEXT from language FROM to language TO."
  (concat google-translate-base-url
          "?v=1.0"
          "&q=" (url-hexify-string text)
          "&langpair=" from "%7c" to))

(defun prompt-if-nil (value prompt-message)
  "If VALUE is nil read a string from the minibuffer,
  prompting with string PROMPT-MESSAGE."
  (or value (read-from-minibuffer prompt-message)))

(defun google-translate (text from to)
  "Translate TEXT from language FROM to language TO."
  (let* ((url (google-make-translate-url (prompt-if-nil text "text: ")
                                         (prompt-if-nil from "from: ")
                                         (prompt-if-nil to "to: ")))
         (json (url-retrieve-json url)))
    ;; (print (format "url: %s" url))
    ;; (print json)
    (getf (getf json :responseData) :translatedText)))

;; (google-translate nil "ru" "en")

(defun guess-language-to (language)
  "If LANGUAGE is ru return en, if LANGUAGE is en return ru, else nil."
  (cond ((string= language "ru") "en")
        ((string= language "en") "ru")))

(defun google-translate-dwin (text)
  "Translate TEXT to language i mean."
  (interactive "stext: ")
  (let* ((from (google-detect-language text))
         (to (guess-language-to from)))
    ;; (print (format "from %s to %s" from to))
    (google-translate text from to)))

(defun google-translate-current-word()
  "Translate current word."
  (google-translate-dwin (current-word)))

(provide 'google-translate)

;;; google-translate.el ends here
