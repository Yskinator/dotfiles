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
      (run-command "xte 'key F4'")
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

(first-binding-b9)
(first-binding-b8)
