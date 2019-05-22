
;; create empty list
(define make-empty-env
  (lambda ()
    (make-list 0 ())
  )
)

(define apply-env
  (lambda (env v)
    (cond
      ((null? env)
        (error "apply-env: empty environment"))
      ((equal? v (first (car env)))
        (second (car env)))
      (else  (apply-env (cdr env) v))
    )
  )
)

;; add one set of variable and value at a time
;; it is kinda right fold so old values will be shadowed.. (inefficient though)
(define extend-env
  (lambda (v val env)
    (cons (list v val) env)
  )
)

;; for test purpose
(define test-env
    (extend-env 'a 7
        (extend-env 'b 5
            (extend-env 'c 6
                (extend-env 'b 4
                    (extend-env 'a 1
                        (extend-env 'b 2
                            (extend-env 'c 3
                                (extend-env 'b 4
                                  (make-empty-env)))))))))
)
