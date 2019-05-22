(define singleton? 
  (lambda (lst)
    (if (list? lst)
      (cond 
        ((equal? lst ()) #f)
        ((equal? (cdr lst) ()) #t)
      )
      #f
    )
  )
)
(define my-make-list 
 (lambda (i lst) (
  cond 
  ((<= n 0) '())
  (else (
         cons lst (my-make-list (- n 1) lst)
         ))
 )
))

(define my-iota 
  (lambda (n)
    (let traverse ( (i n) (result '()) )
      (if (= i 0)
        result
        (traverse (- i 1) (cons (- i 1) result)))
     )
 ))



(define all-same?
  (lambda(lst)
    (or (or (null? lst)
            (null? (cdr lst)))
        (and (equal? (car lst) (car (cdr lst))) (all-same? (cdr lst)))

    )

))

(define my-length
  (lambda(lst)
    (cond
      ((null? lst) 0)
      (else (+ 1 (my-length (cdr lst))))
   )
  )
)

(define nth 
  (lambda (lst i) (
                   cond
                   ((or (< i 0) (equal? lst '()))
                    (error "bad index"))
                   ((= i 0) (car lst))
                   (else (
                          (nth (cdr lst) (- i 1))
                          ))

                   )))

(define my-last 
  (lambda (lst) 
    (cond
    ((equal? lst '()) (error "my-last: empty list"))
    ((null? (cdr lst)) (car lst))
    (else (my-last (cdr lst)))
    )                           
))


(define middle 
  (lambda(lst)
    (if (or (null? (cdr lst)) (null? (cdr (cdr lst))))
        '()
        (let remove-end ((llst (cdr lst))) (
                              if (null? (cdr llst))
                                 '()
                                 (cons (car llst) (remove-end (cdr llst)))
                              )))))
(define my-filter
  (lambda(predi? lst)
    (cond
      ((null? lst) '())
      ((pred? (car lst)) (cons (car lst) (my-filter pred? (cdr lst))))
      (else (my-filter pred? (cdr lst)))

    )))

(define my-append 
  (lambda(A B)
    (cond
      ((null? A) B)
      (else (cons (car A) (my-append (cdr A) B))
    )
   )
))

(define append-all
  (lambda (lst)
    (cond
      ((null? lst) lst)
      ((not (list? lst)) lst)
      ((list? (car lst)) (my-append (append-all(car lst)) (append-all (cdr lst))))
    )
   )
)

(define my-sort
  (lambda (lst)
    (if (or (null? lst) (<= (my-length lst) 1))
      lst
      (let loop ( (pivot (car lst)) (rest (cdr lst)) (Left '()) (Right '()))
        (if (null? rest)
          (my-append (my-append (my-sort Left) (list pivot)) (my-sort Right))
          (if (<= (car rest) pivot)
                (loop pivot (cdr rest) (my-append Left (list (car rest))) Right)
                (loop pivot (cdr rest) Left (my-append Right (list (car rest))))
          )
        )
      )
    )
  )
)


(define all-bits
  (lambda (n)
    (if (<= n 0)
      '()
      (let generateBits ((prefix '()) (numBits n) )
       (cond
         ((< numBits 0) '())
         ((= numBits 0) (cons prefix '()))
         (else
           (my-append
              (generateBits (cons 1 prefix) (- numBits 1) )
              (generateBits (cons 0 prefix) (- numBits 1) )
           )
           
))))))
