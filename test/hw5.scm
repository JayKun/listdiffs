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
		    (or (not (pair? obj)) (not (pair? (car obj) ) ) (null? obj)) #f
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
	    ( error "error")
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
            if( or (null? obj) (null? args) )
            '()
	    (cons(cons obj args) '())
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
                if (or (null-ld? args) (null? args)) 
                    listdiff
	        (apply append-ld (cons (append (ld->list listdiff)(car (car args))) (cdr (car args))) (cdr args))
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

(
    define (list->ld list)
        (
            if (or (not (pair? list)) (not (list? list)))
            (error "error")
            (apply ld (car list) (cdr list) )
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
    (
        if(or (not(ld? listdiff)) (null-ld? listdiff))
        (error "error")
        (take (car listdiff) (length-ld listdiff))
    )
)

(
    define (getlist listdiffs k)(
        if(or (null-ld? listdiffs) (not(pair? listdiffs)))
        '()
        (cons (list-ref (car (car listdiffs)) k)  (getlist (cdr listdiffs) k))
    )
)

(
    define (map-aux proc max_k k listdiffs)(
        if (equal? k max_k)
        '()
        (cons (apply proc (getlist listdiffs k)) (map-aux proc max_k (+ k 1) listdiffs))
    )

)

(
    define (map-ld proc . listdiffs)(
        let ([len (length-ld (car listdiffs))])
          (
               map-aux proc len 0 listdiffs
          )
        
    )
)


(
    define (expr2ld expr)(
        cond[(null? expr)
            expr]
        [(list? expr)
	   ( cons (expr2ld (car expr)) (expr2ld (cdr expr)) )
        ]
        [
           (util expr)
        ]
   
    )
)

(
define (util e) (
    cond
    [ 
      (equal? e 'null)
      'null-ld
    ]
    [
      (equal? e 'list?)
      'ld?
    ]
    [
      (equal? e 'cons)
      'cons-ld
    ]
    [
      (equal? e 'car)
      'car-ld
    ]
    [
      (equal? e 'cdr)
      'cdr-ld
    ]
    [
      (equal? e 'list)
      'ld
    ]
    [
      (equal? e 'length)
      'length-ld
    ]
    [
      (equal? e 'append)
      'append-ld
    ]
    [
      (equal? e 'list-tail)
      'ld-tail
    ]
    [
      (equal? e 'map)
      'map-ld
    ]
    [
      else e
    ]
     
     )
)

(define ils (append '(a e i o u) 'y))
(define d1 (cons ils (cdr (cdr ils))))
(define d2 (cons ils ils))
(define d3 (cons ils (append '(a e i o u) 'y)))
(define d4 (cons '() ils))
(define d5 0)
(define d6 (ld ils d1 37))
(define d7 (append-ld d1 d2 d6))
(define e1 (expr2ld '(map (lambda (x) (+ x 1))
                          (list (length (list d1)) 2 4 8)
                          (append (list) (list-tail (list 1 16 32) 1)))))
