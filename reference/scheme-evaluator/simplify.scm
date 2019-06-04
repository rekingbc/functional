; Part 3 - Expression Simplifier
; This has been broken up into support functions to improve readability and make each action clearer. Uses one function that is identical to the previous section (is-inc-dec?), copied here. Contains no simplifications for division, though they could be added very easily (eg. 0 / x = 0).

; simplify returns, if possible, a simplified version of expr.
(define simplify
	(lambda (expr)
		(cond
			((null? expr)
				(error "simplify: unknown expression type"))
			((number? expr)
				expr)
			((symbol? expr)
				expr)
			((is-inc-dec? (first expr))
				(simplify-inc-dec (first expr)
				                  (simplify (second expr))))
			(else
				(let ((left (simplify (first expr)))
				      (right (simplify (third expr)))
					  (operator (second expr)))
					(cond
						((equal? operator '+)
							(simplify-add left right))
						((equal? operator '-)
							(simplify-subtract left right))
						((equal? operator '*)
							(simplify-multiply left right))
						((equal? operator '**)
							(simplify-exponent left right))
						(else
							expr)))))))

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

; simplify-inc-dec simplifies an increment or decrement expression. Incrementing or decrementing an actual number is evaluated.
(define simplify-inc-dec
	(lambda (left right)
		(if (number? right)
			(cond
				((equal? left 'inc)
					(+ right 1))
				((equal? left 'dec)
					(- right 1)))
			(list left right))))

; simplify-add simplifies an addition expression. Added zero's are removed.
(define simplify-add
	(lambda (left right)
		(cond
			((equal? left 0)
				right)
			((equal? right 0)
				left)
			(else
				(list left '+ right)))))

; simplify-multiply simplifies a multiplication expression. Multiplication by zero returns zero, and multiplication by one is ignored.
(define simplify-multiply
	(lambda (left right)
		(cond
			((equal? left 0)
				0)
			((equal? right 0)
				0)
			((equal? left 1)
				right)
			((equal? right 1)
				left)
			(else
				(list left '* right)))))

; simplify-subtract simplifies a subtraction expression. Subtracting zero is ignored, and subtracting two equal values is zero.
(define simplify-subtract
	(lambda (left right)
		(cond
			((equal? right 0)
				left)
			((equal? left right)
				0)
			(else
				(list left '- right)))))

; simplify-exponent simplifies an exponent expression. Powers of zero are set to one, powers of 1 are ignored, and any exponent on one is ignored.
(define simplify-exponent
	(lambda (left right)
		(cond
			((equal? right 0)
				1)
			((equal? right 1)
				left)
			((equal? left 1)
				1)
			(else
				(list left '** right)))))