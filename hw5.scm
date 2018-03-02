

; A list is made up of pairs and one pair has the firm (car.cdr)
; A list of the elements 2,3 is made up like (2.(3.() ))
; A list that has a pair as it's cdr can be shown without the dot
; and the parents such that (2.(3.())) is the same as (2 3 .())



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
		    (or (not (pair? obj)) (not (pair? (car obj) ) ) (null? obj)) 		    #f
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
	    ( "What")
	)

)

; returns an element
(
    define (car-ld listdiff)
	(
            if (or (null-ld? listdiff) (not (ld? listdiff)) )
            (error "error")
	    (car (car listdiff))
	)

)

; returns a list in the form of a listdiff
(
    define (cdr-ld listdiff)
        (
	   if(or (null-ld? listdiff) (not (ld? listdiff)) )
	   (error "error")
	   (cons (cdr (car listdiff)) (cdr listdiff))
	)
)

; returns a newly allocated listdiff of its argument
; would need tail-recursion (maybe not)
; (obj.'())
(
    define (ld obj . args)
	(
	    cons(cons obj args) '()
	)
)

; returns a number
(
    define (length-ld listdiff)
	(
            if (null-ld? listdiff) 
                0
	    (+ 1 (length-ld (cdr-ld listdiff)))
	)

)

(
    define (append-ld listdiff . args)
    (
                if (null-ld? args) 
                    listdiff
	        (append-ld (cons (append (ld->list listdiff)(car (car args))) (cdr (car args)))  (cdr args))
    
)


(
    define (ld-tail listdiff k)
        (
             if (equal? k 0) 
                listdiff
	     (ld-tail (cdr-ld listdiff) (- k 1))
        )
)

(
    define (list->ld list)
        (
            if(not (list? list))
            (error "error")
            (ld cons( (car list) (cdr list) ) )
        )

)

(
    define (memberx lst e)
        (
            cond ((null? lst)#f)
	    ((eq? (car lst) e)#t)
	    ((memberx (cdr lst) e))
	)

)

(
    define (aux listdiff acc) (
	if (memberx (cdr listdiff) (car listdiff))
	acc
	(aux listdiff (append acc (car listdiff)))
        )
)     
    
(
    define (ld->list listdiff)
            ;(aux listdiff '())
    (
        if(or (not(ld? listdiff)) (null-ld? listdiff))
        (error "error")
        (take (car listdiff) (length-ld listdiff))
    )
)



(define ils (append '(a e i o u) 'y))
(define d1 (cons ils (cdr (cdr ils))))
(define d2 (cons ils ils))
(define d3 (cons ils (append '(a e i o u) 'y)))
(define d4 (cons '() ils))
(define d5 0)
(define d6 (ld ils d1 37))
