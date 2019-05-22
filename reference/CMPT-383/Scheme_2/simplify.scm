;; hard coded - definitely not efficient..
;; check the value is 0 or not
(define is-zero?
  (lambda (expr)
    (if (not (list? expr))
      (if (equal? 0 expr)        ;; true
        #t                          ;; true
        #f                          ;; false
      )
      #f                         ;; false
    )
  )
)

(define simplify
  (lambda (expr)
    (cond

      ;; base cases
      ((symbol? expr)
        expr)
      ((number? expr)
        expr)

      ;; addition
      ((is-add? expr)
        (cond
          ((is-zero? (simplify (first expr)))             ;; if (0 + e) = e
            (simplify (third expr)))
          ((is-zero? (simplify (third expr)))             ;; if (e + 0) = e
            (simplify (first expr)))
          (else
            (list (simplify (first expr)) (second expr) (simplify (third expr)) ))    ;; else - make a list
        )
      )

      ;; multiplication
      ((is-mul? expr)
        (cond
          ((is-zero? (simplify (first expr)))              ;; if (0 * e) = 0
            0)
          ((is-zero? (simplify (third expr)))              ;; if (e * 0) = 0
            0)
          ((equal? 1 (simplify (first expr)))              ;; if (1 * e) = e
            (simplify (third expr)))
          ((equal? 1 (simplify (third expr)))              ;; if (e * 1) = e
            (simplify (first expr)))
          (else
            (list (simplify (first expr)) (second expr) (simplify (third expr)) ))
        )
      )

      ;; division
      ((is-div? expr)
        (cond
          ((= 1 (simplify (third expr)))                   ;; if (e / 1) = e
            (simplify (first expr)))
          (else
            (list (simplify (first expr)) (second expr) (simplify (third expr)) ))
        )
      )

      ;; subtraction
      ((is-sub? expr)
        (cond
          ((is-zero? (simplify (third expr)))                          ;; if (e - 0) = e
            (simplify (first expr)))
          ((equal? (simplify (first expr)) (simplify (third expr)))    ;; if (e - e) = 0
            0)
          (else
            (list (simplify (first expr)) (second expr) (simplify (third expr)) ))
        )
      )

      ;; exponent
      ((is-exp? expr)
        (cond
          ((is-zero? (simplify (third expr)))               ;; (e ** 0) = 1
            1)
          ((equal? 1 (simplify (third expr)))               ;; (e ** 1) = e
            (simplify (first expr)))
          ((equal? 1 (simplify (first expr)))               ;; (1 ** e) = 1
            1)
          (else
            (list (simplify (first expr)) (second expr) (simplify (third expr)) ))
        )
      )

      ;; increment
      ((is-inc? expr)
        (cond
          ((number? (simplify (second expr)))             ;; if n is a number e.g (inc 2)
            (+ 1 (simplify (second expr))))               ;; display 2 + 1 = 3
          (else                                           ;; if x is a variable  i.e., (inc x)
            (list (simplify (second expr)) '+ '1 ))       ;; display it like (x + 1)
        )
      )

      ;; decrement
      ((is-dec? expr)
        (cond
          ((number? (simplify (second expr)))             ;; same as increment except the sign changes
            (- (simplify (second expr)) 1))
          (else
            (list (simplify (second expr)) '- '1 ))
        )
      )
      (else (error "Invalid expression."))                ;; if expression is not in unary or binary operators
    )                                                     ;; display error msg
  )
)
