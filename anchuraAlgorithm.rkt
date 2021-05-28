#lang racket
#| ANCHURA PRIMERO |#

(provide anchura)

(define (anchura ini fin grafo)
  (anchura-aux (list(list(list ini))) fin grafo '()))

(define (anchura-aux rutas fin grafo total)
  ;;(print (car rutas))
  (cond
    ((null? rutas)(reordenar(mymap-reverse total '())))
    ((solucion? fin (caar rutas)) (anchura-aux (cdr rutas) fin grafo (cons (car rutas) total)))
    (else(anchura-aux (append (cdr rutas) (extender (car rutas) grafo)) fin grafo total))) 
    )
(define (mymap-reverse total resultado)
  (cond
    ((null? total)resultado)
    (else (mymap-reverse (cdr total) (append (list(reverse (car total))) resultado)))))

(define (solucion? fin ruta)
  (equal? fin (car ruta)))


(define (vecinos ele grafo)
    (cond
      ((equal? (assoc ele grafo) #f) #f)
      (else (cadr (assoc ele grafo)))
      ))

(define (extender ruta grafo)
  (append
         (mapMiembro (vecinos (caar ruta) grafo) ruta '())))
;;Elemento que se está obteniendo, vecinos del ele, ruta que se busca de vecinos, resultado que se obtiene
(define (mapMiembro vecinos ruta resultado)
  (cond
    ((null? vecinos) resultado)
    (else(mapMiembro (cdr vecinos) ruta (append resultado (mapMiembro-aux (car vecinos) ruta)))))
    )

(define (mapMiembro-aux nodo ruta)
  (cond
    ((miembro? (car nodo) ruta) '())
    (else(list(cons nodo ruta)))
    ))

(define (miembro? ele lista)
  (cond
    ((null? lista) #f)
    ((equal? ele (caar lista)) #t)
    (else (miembro? ele (cdr lista)))
    )
  )
;;'(((D) (A 4) (C 10) (B 2)) ((D) (A 4) (B 5)) ((D) (C 1) (B 2)))
(define (reordenar rutas)
  (reordenar-aux rutas '() 0))
(define (reordenar-aux rutas resultado sumatoria)
  (cond
    ((null? rutas) resultado)
    ((>= (sumar (cdar rutas) 0) sumatoria) (reordenar-aux (cdr rutas)(append resultado (list(car rutas))) (sumar (cdar rutas) 0)))
    (else(reordenar-aux (cdr rutas)(append (list(car rutas)) resultado) (sumar (cdar rutas) 0)))
    ))
  

(define (sumar rutas resultado)
  (cond
    ((null? rutas) resultado)
    (else(sumar (cdr rutas) (+ resultado (cadar rutas))))
    ))