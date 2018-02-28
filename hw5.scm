(define ils (append '(a e i o u) 'y))
(define d1 (cons ils (cdr (cdr ils))))
(define d2 (cons ils ils))
(define d3 (cons ils (append '(a e i o u) 'y)))
(define d4 (cons '() ils))
(define d5 0)


(define (null-ld? obj) 
(eq? (car obj) (cdr obj)))

(define (ld? obj)
	(cond 
	      [
		(and (equal? (length (cdr obj) 1)) (equal? (length (car obj) 1 )) (eq? (car obj) (cdr obj)))
		#t
	      ]
	      [
	        (and (equal? (length (cdr obj)) 1) (equal! (length (car obj))))
		#f
	      ]
	      [
		(and (null? (car obj)) (null? (cdr obj)))
		#t
	      ]
	      [
		(null? (car obj)) 
		#f
	      ]
	      [
		(null? (cdr obj)) 
		#f
	      ]
	      [
		(eq? (car (car obj)) (car (cdr obj))) 
		(ld? (cons (cdr (car obj)) (cdr (cdr obj))))
	      ]
	      [
		else 
		(ld? (cons (cdr (car obj)) (cdr obj)))
	      ]
	)
)

(define (cons-ld obj listdiff) 
    (
	#t
    )
)

(define (car-ld listdiff)
    (
	#t
    )
)

(define (cdr-ld listdiff)
    (
	#t
    )

)
