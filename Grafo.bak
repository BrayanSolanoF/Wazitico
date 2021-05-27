#lang racket

(provide addNode
         addAll
         addEdge)



;;Retorna un booleano indicando si el nodo recibido existe en el grafo
;;Recibe un nodo y un grafo
(define (hasNode node graph)
  (cond ((null? graph)
         #f)
        ((equal? node (caar graph))
         #t)
        (else
         (hasNode node (cdr graph)))))



;;Agrega un nuevo nodo en el grafo
;;Recibe un nodo y un grafo.
(define (addNode newNode graph)
  (cond ((not(hasNode newNode graph))
         (append graph (list (list newNode '()))))
        (else
         graph)))




;;Agrega los nodos recibidos en la lista al grafo
;;Recibe una lista de nodos y un grafo.
(define (addAll nodeList graph)
  (cond ((null? nodeList)
         graph)
        (else
         (addAll (cdr nodeList) (addNode (car nodeList) graph)))))




;;Revisa si el nodo se encuentra en la lista de aristas.
;;Recibe un nodo y una lista con aristas.
(define (hasEdge newNode edgesList)
  (cond ((null? edgesList)
         #f)
        ((equal? newNode (caar edgesList))
         #t)
        (else
         (hasEdge newNode (cdr edgesList)))))





;;Retorna el grafo con la nueva arista
;;Recibe un nodo origen y un nodo destino para crear una nueva arista en el grafo, ademas recibe el peso de la arista y un booleano
(define (addEdge origin end weight directed graph)
  (cond ((and (hasNode origin graph) (hasNode end graph))
         (cond (directed
                (addEdgeAux origin end weight graph))
               (else
                (addEdgeAux end origin weight (addEdgeAux origin end weight graph)))))
        (else
         '())))


(define (addEdgeAux origin end weight tempGraph)
  (cond ((null? tempGraph)
         '())
        ((equal? origin (caar tempGraph))
         (cond ((not(hasEdge end (cadar tempGraph)))
                (cond ((equal? (cadar tempGraph) '())
                       (append (list(list origin (list (list end weight)))) (cdr tempGraph)))
                      (else
                       (append (list(list origin (append (list (list end weight)) (cadar tempGraph)))) (cdr tempGraph)))))
               (else
                (append tempGraph (addEdgeAux origin end weight '())))))
        (else
         (append (list(car tempGraph)) (addEdgeAux origin end weight (cdr tempGraph))))))


