;;; google-translate.el --- Google Translate API
(require 'url)
(require 'json)

;; usage:
;;
;; * (google-detect-language "Detect the language of this text")
;;   "en"
;;
;; * (google-translate-dwin "Guess what i mean")
;;   "Угадайте, что я имею в виду"
;;
;; * (google-translate "Hello world!" "en" "ru")
;;   "Привет мир!"
;;
;; * (google-translate "Hello world!" "en" "uk")
;;   "Привіт світ!"
;;
;; * (google-translate "Hello world!" "en" "de")
;;   "Hallo Welt!"
;;
;; * (google-translate "Hello world!" "en" "fr")
;;   "Bonjour le monde!"
;;
;; * customize guess language table:
;;   (add-to-hash-table guess-language-table
;;                      (list 'en 'ru
;;                            'ru 'en
;;                            'uk 'en))

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

(defun fit-string-to-size (string max-size)
  "If STRING lenght greater than MAX-SIZE cut STRING to fit MAX-SIZE."
  (if (<= (length string) max-size)
      string
    (concat (substring string 0 (- max-size 3)) "...")))

(defun read-text-from-to (text from to)
  "Read TEXT, FROM language and TO language from minibuffer."
  (let* ((text (prompt-if-nil text "translate: "))
         (cut-text (fit-string-to-size text 15))
         (from (prompt-if-nil from (format "translate '%s' from: "
                                           cut-text)))
         (to (prompt-if-nil to (format "translate '%s' from '%s' to: "
                                       cut-text
                                       from))))
     (list text from to)))

(defun google-translate (text from to)
  "Translate TEXT from language FROM to language TO."
  (interactive (read-text-from-to nil nil nil))

  (let* ((url (google-make-translate-url text from to))
         (json (url-retrieve-json url))
         (result (getf (getf json :responseData) :translatedText)))
    (decode-coding-string result 'utf-8)))

(defvar guess-language-table (make-hash-table)
  "Contain information about what language to translate to.")

(defun add-to-hash-table (hash-table plist)
  "Add to HASH-TABLE the PLIST of key value."
  (loop for (key value) on plist by #'cddr do
        (puthash key value hash-table)))

(defun guess-language-to (language)
  "Guess the LANGUAGE i want to translate."
  (symbol-name (gethash (intern language) guess-language-table)))

(defun google-translate-dwin (text)
  "Translate TEXT to the language i mean (Do what i mean!)."
  (interactive "stranslate: ")
  (let* ((from-language (google-detect-language text))
         (args (read-text-from-to text
                                  from-language
                                  (guess-language-to from-language)))
         (text (first args))
         (from (second args))
         (to (third args))
         (translated (google-translate text from to)))
    (format "\n%s: %s\n%s: %s" from text to translated)))

(defun google-translate-current-word()
  "Translate current word."
  (interactive)
  (google-translate-dwin (current-word)))

(provide 'google-translate)

;;; google-translate.el ends here
