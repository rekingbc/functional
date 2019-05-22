
;; Question 1
(define my-singleton?
    (lambda (lst)
        (and (list? lst)
             (null? (cdr lst))
        )
    )
)

;; Question 2
(define my-make-list
    (lambda (n x)
        (cond
            ((<= n 0)
                '())
            (else
                (cons x (my-make-list (- n 1) x)))
        )
    )
)

;; Question 3
(define my-iota
    (lambda (n)
        (let loop ( (i n) (output '()))                 ;; output will store ordered numbers in the list
            (if (= i 0)                                 ;; that starts with 0 to n-1
                output
                (loop (- i 1) (cons (- i 1) output))
            )
        )
    )
)

;; Question 4
(define my-len
    (lambda (lst)
        (cond
            ((null? lst)                                ;; base-case: if the lst is null return 0
                0)
            (else
                (+ 1 (my-len(cdr lst))))                ;; else it will return +1
        )
    )
)

;; Question 5
(define nth
    (lambda (lst i)
        (cond
            ((or (< i 0) (equal? lst '()))              ;; if index is less than 0 or the lst is empty
                (error "bad index"))                    ;; then error msg
            ((= i 0)
                (car lst))                              ;; if index is == 0 return first ele in the lst
            (else
                (nth (cdr lst) (- i 1)))                ;; rest of lst with decremented index
        )
    )
)

;; Question 6
(define my-last
    (lambda (lst)
        (cond
            ((null? lst)
                (error "my-last: empty list"))    ;; error msg
            ((null? (cdr lst))                    ;; base case: if cdr lst is '() then (car lst) will be return
                (car lst))
            (else                                 ;; else my-last with (cdr lst) until we get the last ele
                (my-last (cdr lst)))              ;; from the lst
        )
    )
)

;; Question 7
(define my-filter
    (lambda (fn? lst)
        (cond
            ((null? lst)                          ;; base-case: if lst empty, return empty list
                '())
            ((fn? (car lst))                                   ;; if pred func? (car lst) is true then
                (cons (car lst) (my-filter fn? (cdr lst))))    ;; include (car lst) to the final list
            (else
                (my-filter fn? (cdr lst)))                     ;; else move on to the next element
        )
    )
)

;; Question 8
(define my-append
    (lambda (A B)
        (cond
            ((null? A)                                  ;; base-case: if A is null, simply return B
                B)
            (else
                (cons (car A) (my-append(cdr A) B)))    ;; (cons A1 (cons A2 (cons A3.. ))) until A becomes null
        )
    )
)

;; Question 9
(define append-all
    (lambda (lst)
        (cond
            ((null? lst)                                                  ;; empty?
                lst)
            ((not (list? lst))                                            ;; if lst is not a list
                lst)
            ((list? (car lst))                                            ;; if first element of lst is a list
                (my-append (append-all(car lst)) (append-all (cdr lst))))
            (else
                (cons (car lst) (append-all (cdr lst))))
        )
    )
)

;; Question 10
(define my-sort
    (lambda (lst)                                                                                       ;; set pivot as the first element of the list
        (if (or (null? lst) (<= (my-len lst) 1)) lst                                                    ;; check if the lst is null or len of the lst is less than or equal to 1
            (let loop ( (pivot (car lst)) (rest (cdr lst)) (partition-L '()) (partition-R '()))         ;; init pivot = car lst,  rest = cdr lst, Left Partition = '(), Right Partition = '()
                (if (null? rest)
                    (my-append (my-append (my-sort partition-L) (list pivot)) (my-sort partition-R))    ;; base: if rest is empty, append all left, pivot and right
                    (if (<= (car rest) pivot)                                                           ;; check if the pivot is less or greater than the next element in the rest
                        (loop pivot (cdr rest) (my-append partition-L (list (car rest))) partition-R)   ;; if (car rest) < pivot, add (car rest) to the left partition
                        (loop pivot (cdr rest) partition-L (my-append partition-R (list (car rest))))   ;; if (car rest) > pivot, add (car rest) to the right partitioin
                    )                                                                                   ;; do this until rest is null
                )
            )
        )
    )
)

;; Question 11
;;;;;;;;;;;;;;

(define my-map-fold
    (lambda (fn lst)
        (fold (lambda (a rest) (cons (fn a) rest))
              ()
              lst)
    )
)

(define f
  (lambda (x y)
    (+ x y)
  )
)

(define curry
  (lambda (f)
    (lambda (n)
      (f n)
    )
  )
)

(define uncurry
  (lambda (f)
    (curry f)
  )
)
