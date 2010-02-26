(require 'url)
(require 'json)

(defun url-data (url)
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
  "Retrieve json result of url as a plist."
  (let ((data (first (url-data url)))
        (json-object-type 'plist))
    (json-read-from-string data)))





(defvar google-detect-language-base-url
  "http://ajax.googleapis.com/ajax/services/language/detect")

(defun google-make-detect-language-url (text)
  "Make url to detect language of `text`."
  (concat google-detect-language-base-url
          "?v=1.0"
          "&q=" (url-hexify-string text)))

(defun google-detect-language (text)
  "Retrieve language of `text`."
  (let* ((url (google-make-detect-language-url text))
         (json (url-retrieve-json url)))
    (getf (getf json :responseData) :language)))



(defvar google-translate-base-url
  "http://ajax.googleapis.com/ajax/services/language/translate")

(defun google-make-translate-url (from to text)
  "Make url to translate `text`."
  (concat google-translate-base-url
          "?v=1.0"
          "&q=" (url-hexify-string text)
          "&langpair=" from "%7c" to))

(defun promt-if-nil (value promt)
  "If value is nil promt it in minibuffer."
  (or value (read-from-minibuffer promt)))

(defun google-translate (from to text)
  "Translate `text` from language `from` to language `to`."
  (let* ((url (google-make-translate-url (promt-if-nil from "from: ")
                                         (promt-if-nil to "to: ")
                                         (promt-if-nil text "text: ")))
         (json (url-retrieve-json url)))
    ;; (print (format "url: %s" url))
    ;; (print json)
    (getf (getf json :responseData) :translatedText)))

;; (google-translate "ru" "en" nil)

(defun guess-to-language (language)
  "Change ru -> en, en -> ru, nil -> nil."
  (cond ((string= language "ru") "en")
        ((string= language "en") "ru")))

(defun google-translate-dwin (text)
  ""
  (interactive "stext: ")
  (let* ((from (google-detect-language text))
         (to (guess-to-language from)))
    ;; (print (format "from %s to %s" from to))
    (google-translate from to text)))

(google-translate-dwin "dog")
(google-translate-dwin "cat")
