#lang racket

;; Recursos utilizados para la implementación de la interfaz
(require racket/gui) ;; Biblioteca para la interfaz
(require racket/draw)
(require racket/gui map-widget) ;; Biblioteca para el uso de la API del mapa
(require 2htdp/batch-io) ;;Biblioteca para el manejo de archivos externos
(require "grafo.rkt") ;; Lógica del programa





;; Definición del frame principal de la aplicación
;; Label: Etiqueta el frame
;; streacheble width y heignt: falso para que ventana no se expanda
(define frame (new frame%
                   [label "Wazitico"]
                   [stretchable-width #f]
                   [stretchable-height #f]))


;;Define un panel horizontal para elementos de la interfaz
;; Parent: Donde se ubica el panel
;; streacheble width y heignt: falso para que panel no se expanda
(define all (new horizontal-panel%
                  [parent frame]                 
                  [stretchable-width #f]	 
                  [stretchable-height #f]))




;-----------------------------------------------------------Panel para mapa-----------------------------------------------


;; Define un panel horizontal para mostrar el mapa 
;; Parent: Donde se ubica el pane
;; min width y heignt: tamaño del panel
;; streacheble width y heignt: falso para que panel no se expanda
(define mapa (new horizontal-panel%
                  [parent all]
                  [min-width 600]	 
                  [min-height 400]
                  [stretchable-width #f]	 
                  [stretchable-height #f]))


;; Define el mapa-widhet y lo muestra
;; Parent: Donde se ubica el mapa
;; Position: En que posición se ubica por primera vez el mapa
(define mapaa (new map-widget% [parent mapa]
                 [position #(40.6943 -73.9249)]))


;(send mapaa add-track '(#(40.6943 -73.9249) #(41.8379 -87.6828)) #f)


;; Devuelve el nombre de la ciudad, que es el primer elemento de una lista
;; list-c: Lista de la ciudad y sus coordenadas
(define (name list-c)
  (car list-c))

     
;; Devuelve una lista con las coordenadas de una ciudad
;; list-c: Lista de la ciudad y sus coordenadas 
(define (posi list-c)
  (cdr list-c))

;; Genera vector de laas coordnedas de la ciudad
;; list-c: Lista de la ciudad y sus coordenadas
(define (vec list-c)
  (vector (string->number(car (posi list-c)))
          (* -1 (string->number (cadr (posi list-c))))))

;; Pone marca en el mapa de la interfaz
;; Name: nombre de la ciudad
;; lon-lat: vector de coordenadas de la ciudad
(define (marca name lon-lat)
   (send mapaa add-marker lon-lat name -1 (make-color 0 135 36))) ;;Utiliza método add-mark de Map-widget

;; Para una lista de ciudades genera una marca en el mapa de la interfaz con el método marca.
;; list: lista de ciudades
(define (pos list)
  (for-each (lambda(city) ;; city: elementos de la lista en la iteración for-each
       (marca (name city) (vec city))) ;; llamada del método marca
       list ))


;; lista de las ciudades, inicia con datos del txt
(define ciudades-map (read-words/line "data.txt"))


; Se agregan las marcas de los nodos del grafo 
(pos ciudades-map)

;; Defino el grafo del mapa
(define graph '())


;;Crea los nodos del mapa
(define (addNodes listaa)
  (set! graph (addAll listaa graph))
  (set! graph (addEdge '("LosAngeles" "34.05223" "118.24368") '("WashingtonD.C." "38.89511" "77.03637") 5 #f graph))
  (set! graph (addEdge '("Denver" "39.73915" "104.9847") '("Nashville" "36.16589" "86.78444") 4 #t graph)))


;; Agrego ciudades de la lista ciudades-map al grafo
(addNodes ciudades-map)

;(print graph)

;-----------------------------------------------------------Panel para mapa-----------------------------------------------



;-----------------------------------------------------------Panel para acciones-----------------------------------------------

;; Define un panel vertical para mostrar los elementos para realizar varias acciones
;; Parent: Donde se ubica el panel
;; min width y heignt: tamaño del panel
;; streacheble width y heignt: falso para que panel no se expanda
(define actions (new vertical-panel%
                  [parent all]
                  [stretchable-width #f]	 
                  [stretchable-height #f]
                  ))

;; Botón para centrar el mapa a punto definido
;; Parent: Donde se ubica el botón
;; Label: etiqueta del botón
;; Callback: Ejecuta función del botón
(define button-centre(new button%
                    (parent actions)
                    (label "Centrar")
                    [callback (lambda (button-centre 'button)
                     (send mapaa move-to #(39.29038 -76.61219)))] ;; Método de map-widget que posiciona el mapa en un punto dado
                    ))

;; Group Box para los elementos necesarios para que el usuario consulte una ruta
;; Parent: Donde se ubica el Group box
;; Label: etiqueta del Group box
(define ruta-box (new group-box-panel%
                             [parent actions]
                             [label "Calcular Ruta"]))


;; Text Field para que el usuario consulte indique el punto de inicio de la ruta a calcular
;; Parent: Donde se ubica text field
;; Label: etiqueta del text field
(define inicio (new text-field%
                        [label "Ingrese Inicio"]
                        [parent ruta-box]))

;; Text Field para que el usuario indique el punto de llegada de la ruta a calcular
;; Parent: Donde se ubica text field
;; Label: etiqueta del text field
(define final (new text-field%
                        [label "Ingrese Final"]
                        (parent ruta-box)))

;; Botón para calcular la ruta indicada por el usuario
;; Parent: Donde se ubica el botón
;; Label: etiqueta del botón
;; Callback: Ejecuta función del botón
(define button (new button%
                    (parent ruta-box)
                    (label "Calcular")
                    ;(callback (print "hellos"))
                    ))


;; Group Box para los elementos necesarios para que el usuario agregue una ciudad
;; Parent: Donde se ubica el Group box
;; Label: etiqueta del Group box
(define nodo-box (new group-box-panel%
                             (parent actions)
                             (label "Agregar Lugar")))

;; Text Field para que el usuario indique el nombre de la ciudad a agregar
;; Parent: Donde se ubica text field
;; Label: etiqueta del text field
(define name-field (new text-field%
                        (label "Nombre")
                        (parent nodo-box)))

;; Text Field para que el usuario indique la longitud de la ciudad a agregar
;; Parent: Donde se ubica text field
;; Label: etiqueta del text field
(define lon-field (new text-field%
                        (label "Longitud")
                        (parent nodo-box)))

;; Text Field para que el usuario indique la latitud de la ciudad a agregar
;; Parent: Donde se ubica text field
;; Label: etiqueta del text field
(define lat-field (new text-field%
                        (label "Latitud")
                        (parent nodo-box)))


;; Añade nodo ingresado por el usuario en la interfaz
;; name: nombre de la ciudad
;; lon: longitudad de la ciudad
;; lat: latitud de la ciudad
(define ( add-node-map name lon lat)
  (set! graph (addNode (list name lon lat) graph)) ;; Se añade el nodo al grafo
  (set! ciudades-map (append (list ( list name lon lat)) ciudades-map)) ;; se añade ciudad a la lista de ciudades
  (marca name (vec (list "a" lon lat))) ;; se hace visible el nodo en la interfaz
  (print ciudades-map))



;; Botón que agrega el nuevo lugar al mapa
;; Parent: Donde se ubica el botón
;; Label: etiqueta del botón
;; Callback: Ejecuta función del botón
(define button-nodo (new button%
                    (parent nodo-box)
                    (label "Agregar")
                    [callback (lambda (button-nodo 'button)
                        (add-node-map (send name-field get-value) (send lon-field get-value) (send lat-field get-value)))]
                    ))




;; Dibuja el camino en la interfaz y agrega edge al grafo
(define (draw-track ini fin peso)
  (send mapaa add-track (list (vec (assoc ini ciudades-map)) (vec (assoc fin ciudades-map))) #f) ;; Método Map-widget para trazar rutas
  (set! graph (addEdge (assoc ini ciudades-map) (assoc fin ciudades-map) peso #f graph)) 
  (print graph))



;; Group Box para los elementos necesarios para que el usuario consulte una ruta
;; Parent: Donde se ubica el Group box
;; Label: etiqueta del Group box
(define camino-box (new group-box-panel%
                             (parent actions)
                             (label "Agregar Rutas")))

;; Text Field para que el usuario indique el punto de salida de la ruta
;; Parent: Donde se ubica text field
;; Label: etiqueta del text field
(define camino-ini (new text-field%
                        (label "Incio")
                        (parent camino-box)))


;; Text Field para que el usuario indique el punto de llegada de la ruta
;; Parent: Donde se ubica text field
;; Label: etiqueta del text field
(define camino-fin (new text-field%
                        (label "Final")
                        (parent camino-box)))


;; Text Field para que el usuario indique el peso de la ruta
;; Parent: Donde se ubica text field
;; Label: etiqueta del text field
(define camino-peso (new text-field%
                        (label "Peso")
                        (parent camino-box)))


;; Botón que agrega el nuevo lugar al mapa
;; Parent: Donde se ubica el botón
;; Label: etiqueta del botón
;; Callback: Ejecuta función del botón
(define button-camino (new button%
                    (parent camino-box)
                    (label "Agregar")
                    [callback (lambda (button-camino 'button) (draw-track (send camino-ini get-value)
                                                                          (send camino-fin get-value)
                                                                          (send camino-peso get-value)))]))

;-----------------------------------------------------------Panel para acciones-----------------------------------------------

;Muestra la ventana
(send frame show #t)






