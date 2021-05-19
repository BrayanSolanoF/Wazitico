#lang racket

(require racket/gui)
(require racket/draw)
(require "Grafo.rkt")



;Creo el frame de mi ventana
(define frame (new frame%
                   [label "Wazitico"]
                   ;[min-width 1000]
                   ;[min-height 600]
                   [stretchable-width #f]
                   [stretchable-height #f]))

(define all (new horizontal-panel%
                  [parent frame]
                  [alignment '(right top)]
                  [min-width 10]	 
                  [min-height 10]
                  [stretchable-width #f]	 
                  [stretchable-height #f]))

;Creo paneles 
;-----------------------------------------------------------Panel para mapa-----------------------------------------------
(define mapa (new horizontal-panel%
                  [parent all]
                  [alignment '(right top)]
                  [min-width 10]	 
                  [min-height 10]
                  [stretchable-width #f]	 
                  [stretchable-height #f]))


(define canvas-map (new canvas%
                        [parent mapa]
                        [min-width 800]	 
                        [min-height 400]
                        [paint-callback(lambda (canvas-map dc))]))



(define target (make-bitmap 30 30)) ; A 30x30 bitmap

(define dc (new bitmap-dc% [bitmap target]
                (send dc draw-rectangle
                      0 10   
                      30 10) 
                (send dc draw-line
                      0 0    
                      30 30) 
                (send dc draw-line
                      0 30   
                      30 0)))  




;-----------------------------------------------------------Panel para mapa-----------------------------------------------



;-----------------------------------------------------------Panel para acciones-----------------------------------------------
(define actions (new vertical-panel%
                  [parent all]
                  [alignment '(left top)]
                  [stretchable-width #f]	 
                  [stretchable-height #f]
                  ))

;Ruta
(define ruta-box (new group-box-panel%
                             [parent actions]
                             [label "Calcular Ruta"]))

(define inicio (new text-field%
                        [label "Ingrese Inicio"]
                        [parent ruta-box]))

(define final (new text-field%
                        [label "Ingrese Final"]
                        (parent ruta-box)))

;(define prueba(print "hellos"))

(define button (new button%
                    (parent ruta-box)
                    (label "Calcular")
                    ;(callback (print "hellos"))
                    ))


;Agregar Nodo
(define nodo-box (new group-box-panel%
                             (parent actions)
                             (label "Agregar Lugar")))

(define nodo-nombre (new text-field%
                        (label "Ingrese Nombre")
                        (parent nodo-box)))

(define button-nodo (new button%
                    (parent nodo-box)
                    (label "Agregar")
                    [callback (lambda (button-nodo 'button) (print-cake (random 30)))]
                    ))

;Agregar caminos
(define camino-box (new group-box-panel%
                             (parent actions)
                             (label "Agregar Rutas")))

(define camino-ini (new text-field%
                        (label "Incio")
                        (parent camino-box)))

(define camino-fin (new text-field%
                        (label "Final")
                        (parent camino-box)))

(define camino-peso (new text-field%
                        (label "Peso")
                        (parent camino-box)))

(define button-camino (new button%
                    (parent camino-box)
                    (label "Agregar")))
;-----------------------------------------------------------Panel para acciones-----------------------------------------------

;Muestra la ventana
(send frame show #t)





