; Part 1 - Environments
; Implemented with closures. Each environment is a function that returns the value associated with v. Extending the environment will save the prevous function recursively. Old variable values are not removed, instead this function returns the first value associated with a variable that it finds. It's crazy how simple this was to implement.

; make-empty-env returns a new empty environment.
(define make-empty-env
	(lambda ()
		(lambda (v)
			(error "apply-env: empty environment"))))

; apply-env returns the value of variable v in environment env and raises an error if v does not exist in env.
(define apply-env
	(lambda (env v)
		(env v)))

; extend-env returns a new environment that is the same as env except that the value of v in it is val. If v already has a value in env, then in the newly returned environment this value will be shadowed.
(define extend-env
	(lambda (v val env)
		(lambda (w)
			(cond
				((equal? w v)
					val)
				(else
					(env w))))))