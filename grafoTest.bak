#lang racket

;;Test de funciones que crean el grafo


(require "../Grafo/grafo.rkt")


;;Lista vacia para ir agregando nodos y crear el grafo 
(define graph '())


;;Agrega los nodos recibidos en la lista al grafo
(define (addAllTest)
  (set! graph (addAll '(a b c) graph)))

;;Agrega un nuevo nodo en el grafo
(define (addNodeTest)
  (set! graph (addNode 'd graph)))

(define (addEdgeTest)
  (set! graph (addEdge 'a 'b 5 #f graph))
  (set! graph (addEdge 'c 'd 4 #t graph)))
  