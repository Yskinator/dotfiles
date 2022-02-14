(define (reset-first-binding)
  "reset first binding"
  (ungrab-all-keys)
  (remove-all-keys)
)

(define (first-binding-b9)
  (xbindkey-function '("b:9") second-binding-b9)
)

(define (second-binding-b9)
  "Button Extra Functions"
  (reset-first-binding)

  (xbindkey-function '("b:8")
    (lambda ()
      (reset-first-binding)
      (run-command "xte 'key F4'")
      (run-command "killall xbindkeys; xbindkeys")
    )
  )

  (xbindkey-function '(release "b:9") 
    (lambda ()
      (reset-first-binding)
      (run-command "xte 'key F2'")
      (run-command "killall xbindkeys; xbindkeys")
    )
  )
)

(define (first-binding-b8)
  (xbindkey-function '("b:8") second-binding-b8)
)

(define (second-binding-b8)
  "Button Extra Functions"
  (reset-first-binding)

  (xbindkey-function '("b:9")
    (lambda ()
      (reset-first-binding)
      (run-command "xte 'key F5'")
      (run-command "killall xbindkeys; xbindkeys")
    )
  )

  (xbindkey-function '(release "b:8") 
    (lambda ()
      (reset-first-binding)
      (run-command "xte 'key F3'")
      (run-command "killall xbindkeys; xbindkeys")
    )
  )
)

(define (bind_bar_to_shift_keypad_1_to_3)
  (xbindkey '(release "c:34") "xte 'key bar'")
  (xbindkey '(release shift "c:34") "xte 'keydown Shift_L' 'key bar' 'keyup Shift_L'")
  (xbindkey '(release "c:135") "xte 'keydown ISO_Level3_Shift' 'key bar' 'keyup ISO_Level3_Shift'")
)
(define (bind_control_r_to_mouse1)
 (xbindkey '("Control_R") "xte 'mouseclick 1'")
)

(first-binding-b9)
(first-binding-b8)
(bind_bar_to_shift_keypad_1_to_3)
(bind_control_r_to_mouse1)
