(in-package #:link-field)

(defun remove-quotation (value)
  (if (eql #\" (aref value 0))
      (when (eql #\" (aref value (1- (length value))))
        (subseq value 1 (1- (length value))))
      value))

(defun enclosed-in-<>-p (value)
  (and (eql #\< (aref value 0))
       (eql #\> (aref value (1- (length value))))))

(defun remove-<> (value)
  (subseq value 1 (1- (length value))))

(defun split-string (char string &key (trim t))
  (let ((ret (split-sequence:split-sequence char string :remove-empty-subseqs t)))
    (if trim
        (map (type-of ret) (lambda (part)
                              (string-trim '(#\Space #\Tab) part))
             ret)
        ret)))

(defun parse-link-href (href-segment)
  (when (enclosed-in-<>-p href-segment)
    (remove-<> href-segment)))

(defun collect-link-params (segments ht)
  (loop for segment in (rest segments)
        as segment-parts = (split-string  #\= segment :trim nil)
        as param-value = (and (= (length segment-parts) 2)
                              (not (equal "href" (first segment-parts)))
                              (remove-quotation (second segment-parts)))
        when param-value
        do
           (setf (gethash (first segment-parts) ht) param-value)))

(defun parse-link (raw-link)
  (let ((ht (ia-hash-table:make-ia-hash-table)))
    (let ((segments (split-string #\; raw-link)))
      (alexandria:when-let ((href (parse-link-href (first segments))))
        (setf (gethash "href" ht) href)
        (collect-link-params segments ht)))
    (when (gethash "rel" ht)
      ht)))

(defun parse (value)
  (let ((links (split-string #\, value)))
    (loop for raw-link in links
          as link = (parse-link raw-link)
          when link
          collect link)))
