; A list is made up of pairs and one pair has the firm (car.cdr)
; A list of the elements 2,3 is made up like (2.(3.() ))
; A list that has a pair as it's cdr can be shown without the dot
; and the parents such that (2.(3.())) is the same as (2 3 .())

(define ils (append '(a e i o u) 'y))
(define d1 (cons ils (cdr (cdr ils))))
(define d2 (cons ils ils))
(define d3 (cons ils (append '(a e i o u) 'y)))
(define d4 (cons '() ils))
(define d5 0)


(
    define (null-ld? obj)
	(if
	(not (pair? obj))
	    #f
        (eq? (car obj) (cdr obj))
	)
)

(
    define (ld? obj)
	( cond
		[
		    (null-ld? obj) #t
		]
		[
		    (or (not (pair? (car obj) ) ) (not (pair? obj)) (null? obj)) #f
		]
		[
		    else (ld? (cons (cdr (car obj)) (cdr obj)))
		]
	
	)
)

; returns a listdiff of listdiffs
; '('(obj) listdiff)-> ('(obj listdiff).()) -> ('(obj car())
(
   define (cons-ld obj listdiff)
	(
	    if(and (not(null? obj)) (ld? listdiff))
	    (cons (cons obj (car listdiff)) (cdr listdiff))
	    (error "What")
	)

)

; returns an element
(
    define (car-ld listdiff)
	(
	    car (car listdiff)
	)

)

; returns a list in the form of a listdiff
(
    define (cdr-ld listdiff)
        (
	   cons ((cdr (car listdiff)) (cdr listdiff)) 
	)
)

; returns a newly allocated listdiff of its argument
; would need tail-recursioni (maybe not)
; (obj.'())
(
    define (ld obj)
	(
	    cons(cons (car obj) (cdr obj)) '()
	)
)

; returns a number
(
    define (length-ld listdiff)
	(
            cond [(?null-ld listdiff) 0]
	    [else (+ 1 (length-ld (cdr-ld listdiff)))]
	)

)

(
    define (append-ld listdiff.v)
        (
            
        )
)

(
    define (ld-tail listdiff k)
        (
             if (equal? k 0) 
                listdiff
	     (ld-tail (cdr-ld listdiff) (- k 1))
        )
)



(define (lsadasd? obj)
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

