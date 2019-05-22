;; helper functions
(define nlist?
  (lambda (lst n)
    (and (list? lst)
         (= n (length lst)))
  )
)

(define is-unary-op?
  (lambda (lst op)
    (and (nlist? lst 2)             ;; must be a length 2 since unary operator has only one operand
         (equal? op (first lst)))
  )
)

(define is-binary-op?
  (lambda (lst op)
    (and (nlist? lst 3)             ;; must be a length 3. 2 operands and 1 operator
         (equal? op (second lst)))
  )
)

(define is-inc? (lambda (lst) (is-unary-op? lst 'inc)))
(define is-dec? (lambda (lst) (is-unary-op? lst 'dec)))
(define is-add? (lambda (lst) (is-binary-op? lst '+)))
(define is-sub? (lambda (lst) (is-binary-op? lst '-)))
(define is-mul? (lambda (lst) (is-binary-op? lst '*)))
(define is-div? (lambda (lst) (is-binary-op? lst '/)))
(define is-exp? (lambda (lst) (is-binary-op? lst '**)))

(define myeval
  (lambda (expr env)
    (cond
      ((symbol? expr)                           ;; base cases
        (apply-env env expr))
      ((number? expr)
        expr)
      ((is-inc? expr)                           ;; calculations
        (+ (myeval (second expr) env) 1))
      ((is-dec? expr)
        (- (myeval (second expr) env) 1))
      ((is-add? expr)
        (+ (myeval (first expr) env) (myeval (third expr) env)))
      ((is-sub? expr)
        (- (myeval (first expr) env) (myeval (third expr) env)))
      ((is-mul? expr)
        (* (myeval (first expr) env) (myeval (third expr) env)))
      ((is-div? expr)
        (/ (myeval (first expr) env) (myeval (third expr) env)))
      ((is-exp? expr)
        (expt (myeval (first expr) env) (myeval (third expr) env)))
      (else (error "Invalid expression."))      ;; error
    )
  )
)

;; for test purpose
(define env1
    (extend-env 'x 0
        (extend-env 'y 4
            (extend-env 'x 1
                (make-empty-env))))
)

(define env2
    (extend-env 'm -1
        (extend-env 'a 4
            (make-empty-env)))
)

(define env3
    (extend-env 'q -1
        (extend-env 'r 4
            (make-empty-env)))
)
