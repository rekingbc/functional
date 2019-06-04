; Part 1 - Environments
; Implemented with lists. Each environment is a list of variable/value pairs. Old variable values are not removed, instead this function returns the first value associated with a variable that it finds. I had a remove function, but removed it for simplicity.

; make-empty-env returns a new empty environment.
(define make-empty-env
	(lambda ()
		'()))

; apply-env returns the value of variable v in environment env and raises an error if v does not exist in env
(define apply-env
	(lambda (env v)
		(cond
			((null? env)
				(error "apply-env: empty environment"))
			((equal? (car (car env)) v)
				(second (car env)))
			(else
				(apply-env (cdr env) v)))))

; extend-env returns a new environment that is the same as env except that the value of v in it is val. If v already has a value in env, then in the newly returned environment this value will be shadowed.
(define extend-env
	(lambda (v val env)
		(cons (create-var-pair v val) env)))

; create-var-pair creates a list containing v as the first element and val as the second.
(define create-var-pair
	(lambda (v val)
		(cons v (cons val '()))))