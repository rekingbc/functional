; Part 2 - Expression Evaluator
; This section has one supporting function meant to improve the readability of the main program.

; myeval evaluates the expression expr with variables from the environment env. expr can contain variables from the environment - these are evaluated. Division by 0 is handled by the standard division function. Does not perfectly check the expression for grammatical errors, instead it truncates extra expressions.
(define myeval
	(lambda (expr env)
		(cond
			((null? expr)
				(error "myeval: unknown expression type"))
			((number? expr)
				expr)
			((symbol? expr)
				(apply-env env expr))
			((is-inc-dec? (first expr))
				(let ((left (first expr))
				      (right (myeval (second expr) env)))
					(cond
						((equal? left 'inc)
							(+ right 1))
						((equal? left 'dec)
							(- right 1)))))
			(else
				(let ((left (myeval (first expr) env))
				      (right (myeval (third expr) env))
					  (operator (second expr)))
					(cond
						((equal? operator '+)
							(+ left right))
						((equal? operator '-)
							(- left right))
						((equal? operator '*)
							(* left right))
						((equal? operator '/)
							(/ left right))
						((equal? operator '**)
							(expt left right))))))))

; is-inc-dec? returns true if the argument passed to it equal inc or dec (symbol)
(define is-inc-dec?
	(lambda (s)
		(cond
			((equal? s 'inc)
				#t)
			((equal? s 'dec)
				#t)
			(else
				#f))))