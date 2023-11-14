;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab10-snakev2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Dylan Bloch and TJ Tracy

(require 2htdp/universe)
(require 2htdp/image)
(require racket/list)

;; snake is (make-snake body direction died?))
;; - body is a list-of-posns
;; - direction is one of:
;; - "up"
;; - "down"
;; - "right"
;; - "left"
;; - died? is a boolean

#;
(define (direction-func a-direction)
  (cond
    [(string=? "up") ...a-direction...]
    [(string=? "down") ...a-direction...]
    [(string=? "right") ...a-direction...]
    [(string=? "left") ...a-direction...]))

(define circle-size
  12)
(define food-size
  12)
(define scene-ceiling
  0)
(define right-wall
  480)
(define left-wall
  0)
(define scene-floor
  336)
(define SCENE
  (empty-scene 480 336 "black"))

(define-struct snake (a-lop a-direction died?))

(check-expect (snake-a-lop SNAKE1) (list
 (make-posn 50 30)
 (make-posn 50 34)
 (make-posn 50 38)
 (make-posn 50 42)))
(check-expect (empty? (snake-a-lop SNAKE1)) false)

(define (snake-func a-snake)
  (cond
    [(snake-a-lop a-snake) ...]
    [(snake-a-direction a-snake) ...]
    [(snake-died? a-snake) ...]))

(define SNAKE1 (make-snake (list (make-posn 50 30) (make-posn 50 34) (make-posn 50 38) (make-posn 50 42)) "up" false))
(define SNAKE2 (make-snake (list (make-posn 30 50) (make-posn 34 50) (make-posn 38 50) (make-posn 42 50)) "left" false))

(define UPSNAKE (make-snake (list (make-posn 50 30) (make-posn 50 34) (make-posn 50 38) (make-posn 50 42)) "up" false))
(define DOWNSNAKE (make-snake (list (make-posn 50 30) (make-posn 50 34) (make-posn 50 38) (make-posn 50 42)) "down" false))
(define LEFTSNAKE (make-snake (list (make-posn 30 50) (make-posn 34 50) (make-posn 38 50) (make-posn 42 50)) "left" false))
(define RIGHTSNAKE (make-snake (list (make-posn 30 50) (make-posn 34 50) (make-posn 38 50) (make-posn 42 50)) "right" false))

(define TESTSNAKE (make-snake (list (make-posn 50 50) (make-posn 4 50) (make-posn 8 50) (make-posn 12 50)) "down" true))
(define TESTSNAKE2 (make-snake (list (make-posn 50 12) (make-posn 50 4) (make-posn 50 8) (make-posn 50 12)) "right" false))
(define TESTSNAKE3 (make-snake (list (make-posn 50 42) (make-posn 50 38) (make-posn 50 34) (make-posn 46 34) (make-posn 42 34) (make-posn 42 38) (make-posn 42 42) (make-posn 46 42) (make-posn 50 42)) "up" false))

(define-struct foods (a-lop))
;; foods is a list-of-posns

(define FOODS1 (list(make-posn 67 85) (make-posn 23 64)))
(define FOODSTEST (list(make-posn 50 30) (make-posn 30 50)))
(define FOODSTEST2 (list (make-posn 50 50)))
(define NEWGAMEFOODS (list (make-posn 50 50) (make-posn 27 13) (make-posn 76 87) (make-posn 15 15) (make-posn 45 87)))

(define-struct ticks (number))
;; ticks is a positive integer

(define TICKS1 0)

(define (ticks-func a-tick)
  (cond
    [(ticks-number a-tick) ...]))

(define-struct game (snake good-food bad-food ticks))
;; a game is either:
;; - a snake
;; - a good-food
;; - a bad-food, or
;; - a tick

(define GAME1 (make-game SNAKE1 FOODSTEST2 (list (make-posn 50 50)) TICKS1))
(define TESTGAME (make-game TESTSNAKE FOODS1 (list (make-posn 50 50)) TICKS1))
(define NEWGAME (make-game (make-snake (list (make-posn 200 200) (make-posn 200 224) (make-posn 200 248)) "up" false)
                           (list (make-posn 100 100) (make-posn 250 300) (make-posn 300 300) (make-posn 200 150) (make-posn 250 250))
                           (list (make-posn 50 50) (make-posn 400 300))
                           0))

(define (game-func a-game)
  (cond
    [(game-snake a-game) ...]
    [(game-good-food a-game) ...]
    [(game-bad-food a-game) ...]
    [(game-ticks a-game) ...]))

;; score : Game -> Number
;; produces the score for the current state of the game

(define (score a-game)
  (- (* 25 (snake-length (game-snake a-game)))
     (game-ticks a-game)))

(check-expect (count-seg (make-posn 1 1)) 1)

;; count-seg : posn -> number
;; counts the segments of the snake 

(define (count-seg p)
  (if (posn? p)
    1
    0))

;; num-posns : Listof Posns -> Number
;; computes the length of the snake
(check-expect (num-posns (list (make-posn 1 1) (make-posn 1 1) (make-posn 1 1))) 3)

(define (num-posns a-lop)
  (foldr + 0 (map count-seg a-lop)))
                      

;; snake-length : Snake -> Number
;; produces the number of segments in the snake
(check-expect (snake-length UPSNAKE) 4)

(define (snake-length a-snake)
  (num-posns (snake-a-lop a-snake)))
   

;; draw-snake-alive : Posn Image -> Image
;; draws the snake when snake-died? is false onto the given image

(define (draw-snake-alive p img)
  (if (posn? p)
;      (place-image (circle circle-size "solid" "red") (posn-x (first (snake-a-lop snake))) (posn-y (first (snake-a-lop snake)))
;                   (render-snake (make-snake (rest (snake-a-lop snake)) (snake-a-direction snake) (snake-died? snake)) img))
      (place-image (circle circle-size "solid" "green") (posn-x p) (posn-y p) img)
      img))

;; draw-snake-dead : Posn Image -> Image
;; draws the snake when snake-died? is true onto the given image

(define (draw-snake-dead p img)
   (if (posn? p)
       (place-image (circle circle-size "solid" "red") (posn-x p) (posn-y p) img)
       img))

;; render-snake : snake -> image
;; renders a snake state as an image

(define (render-snake a-game a-snake img)
  (if (or (<= (score a-game) 0) (= (snake-length a-snake) 0) (snake-died? a-snake))
;  (cond[(empty? (snake-a-lop snake)) img]
;       [(cons? (snake-a-lop snake)) (if (snake-died? snake)
;                                        (place-image (circle circle-size "solid" "red") (posn-x (first (snake-a-lop snake))) (posn-y (first (snake-a-lop snake)))
;                                      (render-snake (make-snake (rest (snake-a-lop snake)) (snake-a-direction snake) (snake-died? snake)) img))
;                                        (place-image (circle circle-size "solid" "green") (posn-x (first (snake-a-lop snake))) (posn-y (first (snake-a-lop snake)))
;                                      (render-snake (make-snake (rest (snake-a-lop snake)) (snake-a-direction snake) (snake-died? snake)) img)))]
       (foldl draw-snake-dead img (snake-a-lop a-snake))
       (foldl draw-snake-alive img (snake-a-lop a-snake))))
  

;; draw-good-foods : Posn Image -> Image
;; draws the given Listof Posns onto the given image

(define (draw-good-foods p img)
  (if (posn? p)
      (place-image (square food-size "solid" "white") (posn-x p) (posn-y p) img)
      img))

;; draw-bad-foods : Posn Image -> Image
;; draws the given Listof Posns onto the given image

(define (draw-bad-foods p img)
  (if (posn? p)
      (place-image (square food-size "solid" "red") (posn-x p) (posn-y p) img)
      img))
  
;; render-good-foods : a-lop img -> a-lop
;; renders foods as an image

(define (render-good-foods a-lop img)
;  (cond[(cons? a-lop) (place-image (square food-size "solid" "white") (posn-x (first a-lop)) (posn-y (first a-lop))
;                                     (render-foods (rest a-lop) img))]
;       [else img])
  (foldl draw-good-foods img a-lop))

;; render-bad-foods : a-lop img -> a-lop
;; renders foods as an image

(define (render-bad-foods a-lop img)
;  (cond[(cons? a-lop) (place-image (square food-size "solid" "white") (posn-x (first a-lop)) (posn-y (first a-lop))
;                                     (render-foods (rest a-lop) img))]
;       [else img])
  (foldl draw-bad-foods img a-lop))

(define (render-score a-game)
  (overlay/align "right" "top" (text (number->string (score a-game)) 12 "yellow") SCENE))

;; render-game : Game -> image
;;renders a game state as an image

(define (render-game a-game)
  (render-snake a-game (game-snake a-game)
              (render-good-foods (game-good-food a-game)
                                 (render-bad-foods (game-bad-food a-game)
                                                    (render-score a-game)))))

(render-game GAME1)
(render-game TESTGAME)

; SNAKE FUNCTIONS

;; move-up : NEList-of-posns -> NEList-of-posns
;; updates the y-positiosn of a snake moving "up"
(check-expect (move-up (snake-a-lop SNAKE1)) (list (make-posn 50 18) (make-posn 50 30) (make-posn 50 34) (make-posn 50 38)))

(define (move-up a-lop)
  (cons (make-posn (posn-x (first a-lop)) (- (posn-y (first a-lop)) circle-size))
        (remove (last a-lop) a-lop)))

;; move-down : NEList-of-posns -> NEList-of-posns
;; updates the y-positions of a snake moving "down"
 (check-expect (move-down (snake-a-lop SNAKE1)) (list (make-posn 50 42) (make-posn 50 30) (make-posn 50 34) (make-posn 50 38)))

(define (move-down a-lop)
  (cons (make-posn (posn-x (first a-lop)) (+ (posn-y (first a-lop)) circle-size))
        (remove (last a-lop) a-lop)))

;; move-left : NEList-of-posns -> NEList-of-posns
;; updates the x-positions of a snake moving "left"
(check-expect (move-left (snake-a-lop LEFTSNAKE)) (list (make-posn 18 50) (make-posn 30 50) (make-posn 34 50) (make-posn 38 50)))

(define (move-left a-lop)
  (cons (make-posn (- (posn-x (first a-lop)) circle-size) (posn-y (first a-lop)))
        (remove (last a-lop) a-lop)))

;; move-right : NEList-of-posns -> NEList-of-posns
;; updates the x-positions of a snake moving "right"
 (check-expect (move-right (snake-a-lop RIGHTSNAKE)) (list (make-posn 42 50) (make-posn 30 50) (make-posn 34 50) (make-posn 38 50)))

(define (move-right a-lop)
  (cons (make-posn (+ (posn-x (first a-lop)) circle-size) (posn-y (first a-lop)))
        (remove (last a-lop) a-lop)))


;; add-head : Posn List-of-posns -> List-of-posns
;; Adds a "head" onto a snake
(check-expect (add-head (make-posn 50 26) (snake-a-lop SNAKE1)) (list (make-posn 50 26) (make-posn 50 30) (make-posn 50 34) (make-posn 50 38) (make-posn 50 42))) 

(define (add-head p a-lop)
  (cons p a-lop))


;; move-snake : Snake -> Snake
;; Updates the snake depending on direction of snake
(check-expect (move-snake SNAKE1) (make-snake (list (make-posn 50 18) (make-posn 50 30) (make-posn 50 34) (make-posn 50 38)) "up" false))

(define (move-snake a-snake)
  (cond[(string=? "up" (snake-a-direction a-snake)) (make-snake (move-up (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [(string=? "down" (snake-a-direction a-snake)) (make-snake (move-down (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [(string=? "right" (snake-a-direction a-snake)) (make-snake (move-right (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [(string=? "left" (snake-a-direction a-snake)) (make-snake (move-left (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [(snake-died? a-snake) true]))

;; lengthen-snake : Snake Foods -> Snake
;; Adds a segment to the snake if it has "eaten" one of the foods
 (check-expect (lengthen-snake UPSNAKE FOODSTEST) (make-snake (list (make-posn 50 18) (make-posn 50 30) (make-posn 50 34) (make-posn 50 38) (make-posn 50 42)) "up" #false))
 (check-expect (lengthen-snake DOWNSNAKE FOODSTEST) (make-snake (list (make-posn 50 42) (make-posn 50 30) (make-posn 50 34) (make-posn 50 38) (make-posn 50 42)) "down" #false))
 (check-expect (lengthen-snake RIGHTSNAKE FOODSTEST) (make-snake (list (make-posn 42 50) (make-posn 30 50) (make-posn 34 50) (make-posn 38 50) (make-posn 42 50)) "right" #false))
 (check-expect (lengthen-snake LEFTSNAKE FOODSTEST) (make-snake (list (make-posn 18 50) (make-posn 30 50) (make-posn 34 50) (make-posn 38 50) (make-posn 42 50)) "left" #false))

(define (lengthen-snake a-snake good-food)
  (cond[(and (on-posn? (first (snake-a-lop a-snake)) good-food) (string=? (snake-a-direction a-snake) "up"))
        (make-snake (cons (make-posn (posn-x (first (snake-a-lop a-snake))) (- (posn-y (first (snake-a-lop a-snake))) circle-size))
              (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [(and (on-posn? (first (snake-a-lop a-snake)) good-food) (string=? (snake-a-direction a-snake) "down"))
        (make-snake (cons (make-posn (posn-x (first (snake-a-lop a-snake))) (+ (posn-y (first (snake-a-lop a-snake))) circle-size))
              (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [(and (on-posn? (first (snake-a-lop a-snake)) good-food) (string=? (snake-a-direction a-snake) "right"))
        (make-snake (cons (make-posn (+ (posn-x (first (snake-a-lop a-snake))) circle-size) (posn-y (first (snake-a-lop a-snake))))
              (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [(and (on-posn? (first (snake-a-lop a-snake)) good-food) (string=? (snake-a-direction a-snake) "left"))
        (make-snake (cons (make-posn (- (posn-x (first (snake-a-lop a-snake))) circle-size) (posn-y (first (snake-a-lop a-snake))))
              (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [else (make-snake (snake-a-lop a-snake) (snake-a-direction a-snake) (snake-died? a-snake))]))

;; shorten-snake : Snake Foods -> Snake
;; Adds a segment to the snake if it has "eaten" one of the foods
 (check-expect (shorten-snake UPSNAKE FOODSTEST) (make-snake (list (make-posn 50 34) (make-posn 50 38) (make-posn 50 42)) "up" #false))
 (check-expect (shorten-snake DOWNSNAKE FOODSTEST) (make-snake (list (make-posn 50 34) (make-posn 50 38) (make-posn 50 42)) "down" #false))
 (check-expect (shorten-snake RIGHTSNAKE FOODSTEST) (make-snake (list (make-posn 34 50) (make-posn 38 50) (make-posn 42 50)) "right" #false))
 (check-expect (shorten-snake LEFTSNAKE FOODSTEST) (make-snake (list (make-posn 34 50) (make-posn 38 50) (make-posn 42 50)) "left" #false))

(define (shorten-snake a-snake bad-food)
  (cond[(and (on-posn? (first (snake-a-lop a-snake)) bad-food) (string=? (snake-a-direction a-snake) "up"))
        (make-snake (remove (first (snake-a-lop a-snake)) (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [(and (on-posn? (first (snake-a-lop a-snake)) bad-food) (string=? (snake-a-direction a-snake) "down"))
        (make-snake (remove (first (snake-a-lop a-snake)) (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [(and (on-posn? (first (snake-a-lop a-snake)) bad-food) (string=? (snake-a-direction a-snake) "right"))
        (make-snake (remove (first (snake-a-lop a-snake)) (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [(and (on-posn? (first (snake-a-lop a-snake)) bad-food) (string=? (snake-a-direction a-snake) "left"))
        (make-snake (remove (first (snake-a-lop a-snake)) (snake-a-lop a-snake)) (snake-a-direction a-snake) (snake-died? a-snake))]
       [else (make-snake (snake-a-lop a-snake) (snake-a-direction a-snake) (snake-died? a-snake))]))

;; wall? : Posn -> Boolean
;; checks to see if the head of the snake has it the edges of the window
(check-expect (wall? (make-posn 500 500)) true)
(check-expect (wall? (make-posn 50 50)) false)

(define (wall? p)
  (cond[(or (>= (posn-x p) (- right-wall circle-size)) (<= (posn-x p) (+ left-wall circle-size))) true]
                           [(or (>= (posn-y p) (- scene-floor circle-size)) (<= (posn-y p) (+ scene-ceiling circle-size))) true]
                           [else false]))

;; hit-wall? : Snake -> Boolean
;; checks if the snake has collided with the wall
 (check-expect (hit-wall? (snake-a-lop TESTSNAKE)) true)
 (check-expect (hit-wall? (snake-a-lop TESTSNAKE2)) true)
 (check-expect (hit-wall? (snake-a-lop UPSNAKE)) false)

(define (hit-wall? a-lop)
;  (cond[(empty? a-lop) false]
;       [(cons? a-lop) (cond[(or (>= (posn-x (first a-lop)) (- right-wall circle-size)) (<= (posn-x (first a-lop)) (+ left-wall circle-size))) true]
;                           [(or (>= (posn-y (first a-lop)) (- scene-floor circle-size)) (<= (posn-y (first a-lop)) (+ scene-ceiling circle-size))) true]
;                           [else false])]
       (ormap wall? a-lop))

;; snake-contact? : Snake -> Boolean
;; checks to see if the snake has ran into itself
(check-expect (snake-contact? SNAKE1) true)
(check-expect (snake-contact? TESTSNAKE2) true)

(define (snake-contact? a-snake)
  (if (on-posn? (first (snake-a-lop a-snake)) (rest (snake-a-lop a-snake)))
                          true
                          false))

;; hit-snake? : Snake -> Boolean
;; checks if the snake has collided with the wall
(check-expect (hit-snake? TESTSNAKE) false)
(check-expect (hit-snake? TESTSNAKE2) true)
(check-expect (hit-snake? TESTSNAKE3) true)
(check-expect (hit-snake?  UPSNAKE) true)

(define (hit-snake? a-snake)
  (cond[(empty? (snake-a-lop a-snake)) false]
       [(cons? (snake-a-lop a-snake)) (if (on-posn? (first (snake-a-lop a-snake)) (rest (snake-a-lop a-snake)))
                          true
                          false)]
       ))

;; main-snake-func : Snake Foods -> Snake
;; Combines all the functions associated with the snake
 (check-expect (main-snake-func TESTSNAKE2 (list (make-posn 100 100) (make-posn 250 300) (make-posn 300 300) (make-posn 200 150) (make-posn 250 250))
                           (list (make-posn 50 50) (make-posn 400 300))) (make-snake
 (list
  (make-posn 50 12)
  (make-posn 50 4)
  (make-posn 50 8)
  (make-posn 50 12))
 "right"
 #true))
 (check-expect (main-snake-func TESTSNAKE (list (make-posn 100 100) (make-posn 250 300) (make-posn 300 300) (make-posn 200 150) (make-posn 250 250))
                           (list (make-posn 50 50) (make-posn 400 300))) (make-snake
 (list
  (make-posn 50 50)
  (make-posn 4 50)
  (make-posn 8 50)
  (make-posn 12 50))
 "down"
 #true))
 (check-expect (main-snake-func TESTSNAKE (list (make-posn 100 100) (make-posn 250 300) (make-posn 300 300) (make-posn 200 150) (make-posn 250 250))
                           (list (make-posn 50 50) (make-posn 400 300))) (make-snake
 (list
  (make-posn 50 50)
  (make-posn 4 50)
  (make-posn 8 50)
  (make-posn 12 50))
 "down"
 #true))
 (check-expect (main-snake-func TESTSNAKE3 (list (make-posn 100 100) (make-posn 250 300) (make-posn 300 300) (make-posn 200 150) (make-posn 250 250))
                           (list (make-posn 50 50) (make-posn 400 300))) (make-snake
 (list
  (make-posn 50 42)
  (make-posn 50 38)
  (make-posn 50 34)
  (make-posn 46 34)
  (make-posn 42 34)
  (make-posn 42 38)
  (make-posn 42 42)
  (make-posn 46 42)
  (make-posn 50 42))
 "up" true))


(define (main-snake-func a-snake good-food bad-food)
  (cond[(or (hit-snake? a-snake) (hit-wall? (snake-a-lop a-snake)))
        (make-snake (snake-a-lop a-snake) (snake-a-direction a-snake) true)]
       [(on-posn? (first (snake-a-lop a-snake)) good-food) (lengthen-snake a-snake good-food)]
       [(on-posn? (first (snake-a-lop a-snake)) bad-food) (shorten-snake a-snake bad-food)]
       [else (move-snake (lengthen-snake a-snake good-food))]))

; FOOD FUNCTIONS

;;random-posn : Number Number Number -> Posn
;; to invent a new location for a piece of food on a board
;; of size (w,h) where the snake's segment size is cell-size

(define (random-posn w h cell-size)
  (make-posn (+ cell-size (* cell-size (random (- (floor (/ w cell-size)) 1))))
             (+ cell-size (* cell-size (random (- (floor (/ h cell-size)) 1))))))

;; posn-distance : Posn Posn -> Number
;; Checks to see if two posns are equal to each other
(check-expect (posn-distance (make-posn 10 10) (make-posn 10 10)) 0)
(check-expect (posn-distance (make-posn 45 78) (make-posn 45 78)) 0)
(check-expect (posn-distance (make-posn 45 78) (make-posn 50 78)) 5)
(check-expect (posn-distance (make-posn 45 30) (make-posn 45 78)) 48)



(define (posn-distance p1 p2)
  (sqrt (+ (sqr (- (posn-x p1) (posn-x p2)))
           (sqr (- (posn-y p1) (posn-y p2))))))

;; good-posn-equal? Posn Posn -> Posn
;; Checks to see if p1 is plus or minus three units away and produces a random posn if true and the given posn p2 if false
(check-random (good-posn-equal? (make-posn 50 50) (make-posn 50 53)) (random-posn 100 100 food-size))
(check-random (good-posn-equal? (make-posn 50 50) (make-posn 20 20)) (make-posn 20 20))

(define (good-posn-equal? p1 p2)
  (if (and (<= (- circle-size (posn-x p2)) (posn-x p1) (+ circle-size (posn-x p2)))
       (<= (- circle-size (posn-y p2)) (posn-y p1) (+ circle-size (posn-y p2))))
      (random-posn (- right-wall circle-size) (- scene-floor circle-size) food-size)
      p2))

;; bad-posn-equal? Posn Posn -> Boolean
;; Checks to see if p1 is plus or minus three units away and produces a random posn if true and the given posn p2 if false
(check-random (bad-posn-equal? (make-posn 50 50) (make-posn 50 53)) (random-posn 100 100 food-size))
(check-random (bad-posn-equal? (make-posn 50 50) (make-posn 20 20)) (make-posn 20 20))

(define (bad-posn-equal? p1 p2)
  (if (and (<= (- circle-size (posn-x p2)) (posn-x p1) (+ circle-size (posn-x p2)))
       (<= (- circle-size (posn-y p2)) (posn-y p1) (+ circle-size (posn-y p2))))
      (random-posn (- right-wall circle-size) (- scene-floor circle-size) food-size)
      p2))

;; on-posn? : Posn List-of-posns -> Boolean
;; adds a segment to the snake in the location the snake ate the food
(check-expect (on-posn? (make-posn 67 81) (list (make-posn 67 85) (make-posn 23 64))) true)
(check-expect (on-posn? (make-posn 67 85) (list (make-posn 67 85) (make-posn 23 64))) true)
(check-expect (on-posn? (first (snake-a-lop UPSNAKE)) FOODSTEST) true)

(define (on-posn? p1 a-lop)
;  (cond[(empty? a-lop) false]
;       [(cons? a-lop) (or (<= 0 (posn-distance p (first a-lop)) 3)
;      (on-posn? p (rest a-lop)))]
  (ormap (lambda (p2) (<= 0 (posn-distance p1 p2 ) 11))  a-lop))

;; ate-good-food? : Snake Food -> Food
;; If a food has been "eaten" then it generates a new piece of food
(check-random (ate-good-food? TESTSNAKE (list (make-posn 15 15))) (list (make-posn 15 15)))
(check-random (ate-good-food? TESTSNAKE (list (make-posn 20 20))) (list (make-posn 20 20)))
(check-random (ate-good-food? TESTSNAKE (list (make-posn 50 50))) (list (random-posn 440 336 food-size)))

(define (ate-good-food? a-snake good-foods)
;  (cond[(on-posn? p1 food)
;        (cons (random-posn 100 100 food-size) (remove (filter p1 food) food))]
;       [else food])
    (if (on-posn? (first (snake-a-lop a-snake)) good-foods)
        (map (lambda (p1) (good-posn-equal? (first (snake-a-lop a-snake)) p1)) good-foods)
        good-foods))

;; ate-bad-food? : Snake Food -> Boolean
;; If a food has been "eaten" then it generates a new piece of food
(check-random (ate-bad-food? TESTSNAKE (list (make-posn 15 15))) (list (make-posn 15 15)))
(check-random (ate-bad-food? TESTSNAKE (list (make-posn 20 20))) (list (make-posn 20 20)))
(check-random (ate-bad-food? TESTSNAKE (list (make-posn 50 50))) (list (random-posn 440 336 food-size)))

(define (ate-bad-food? a-snake bad-foods)
;  (cond[(on-posn? p1 food)
;        (cons (random-posn 100 100 food-size) (remove (filter p1 food) food))]
;       [else food])
    (if (on-posn? (first (snake-a-lop a-snake)) bad-foods)
        (map (lambda (p1) (bad-posn-equal? (first (snake-a-lop a-snake)) p1)) bad-foods)
        bad-foods))



; TICK FUNCTIONS

;; increment-tick : Tick -> Tick
;; increment the tick field
(check-expect (increment-tick 1) 2)
(check-expect (increment-tick 5) 6)
(check-expect (increment-tick 0) 1)

(define (increment-tick tick)
  (+ 1 tick))


; tick : Game -> Game
; updates the state of the game

(define (tick a-game)
  (make-game
   (main-snake-func (game-snake a-game) (game-good-food a-game) (game-bad-food a-game))
   (ate-good-food? (game-snake a-game) (game-good-food a-game))
   (ate-bad-food? (game-snake a-game) (game-bad-food a-game))
   (increment-tick (game-ticks a-game))))

;; change : Game KeyEvent -> Game
;; Adapts the world based on keyboard input


(define (change a-game key)
  (cond
    [(and (or (string=? "up" (snake-a-direction (game-snake a-game)))
              (string=? "down" (snake-a-direction (game-snake a-game)))
              (string=? "left" (snake-a-direction (game-snake a-game))))
          (key=? key "left"))
          (make-game
           (make-snake (snake-a-lop (game-snake a-game)) "left" (snake-died? (game-snake a-game)))
           (game-good-food a-game)
           (game-bad-food a-game)
           (game-ticks a-game))]
    [(and (or (string=? "up" (snake-a-direction (game-snake a-game)))
              (string=? "down" (snake-a-direction (game-snake a-game)))
              (string=? "right" (snake-a-direction (game-snake a-game))))
          (key=? key "right"))
     (make-game
      (make-snake (snake-a-lop (game-snake a-game)) "right" (snake-died? (game-snake a-game)))
      (game-good-food a-game)
      (game-bad-food a-game)
      (game-ticks a-game))]
    [(and (or (string=? "right" (snake-a-direction (game-snake a-game)))
              (string=? "up" (snake-a-direction (game-snake a-game)))
              (string=? "left" (snake-a-direction (game-snake a-game))))
          (key=? key "up"))
     (make-game
      (make-snake (snake-a-lop (game-snake a-game)) "up" (snake-died? (game-snake a-game)))
      (game-good-food a-game)
      (game-bad-food a-game)
      (game-ticks a-game))]
    [(and (or (string=? "right" (snake-a-direction (game-snake a-game)))
              (string=? "down" (snake-a-direction (game-snake a-game)))
              (string=? "left" (snake-a-direction (game-snake a-game))))
          (key=? key "down"))
     (make-game
      (make-snake (snake-a-lop (game-snake a-game)) "down" (snake-died? (game-snake a-game)))
      (game-good-food a-game)
      (game-bad-food a-game)
      (game-ticks a-game))]
    [(and (string=? "left" (snake-a-direction (game-snake a-game))) (key=? key "right")) (make-game
                                                                                       (game-snake a-game)
                                                                                       (game-good-food a-game)
                                                                                       (game-bad-food a-game)
                                                                                       (game-ticks a-game))]
    [(and (string=? "right" (snake-a-direction (game-snake a-game))) (key=? key "left")) (make-game
                                                                                       (game-snake a-game)
                                                                                       (game-good-food a-game)
                                                                                       (game-bad-food a-game)
                                                                                       (game-ticks a-game))]
    [(and (string=? "up" (snake-a-direction (game-snake a-game))) (key=? key "down")) (make-game
                                                                                       (game-snake a-game)
                                                                                       (game-good-food a-game)
                                                                                       (game-bad-food a-game)
                                                                                       (game-ticks a-game))]
    [(and (string=? "down" (snake-a-direction (game-snake a-game))) (key=? key "up")) (make-game
                                                                                       (game-snake a-game)
                                                                                       (game-good-food a-game)
                                                                                       (game-bad-food a-game)
                                                                                       (game-ticks a-game))]))

;; game-over? : Game -> boolean
;; consumes a game and produces a boolean indicating whether the game should stop

(define (game-over? a-game)
  (if (or (<= (score a-game) 0) (snake-died? (game-snake a-game)) (= (snake-length (game-snake a-game)) 1))
      true
      false))

(define (run ws)
  (big-bang ws
    (on-tick tick 1/8)
    (to-draw render-game)
    (on-key change)
    (stop-when game-over? render-game)))

 (run NEWGAME)


