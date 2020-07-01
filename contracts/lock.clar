;; initialize variable
;; syntax: <variable> <type> <value>
;; about: initialize variable using defining statement that must be at top of file
;; it is stored in data space of this smart contract and is persisted
;; acting as global shared state.
(define-data-var counter int 0)

;; public function getter
(define-public (get-counter)
  (ok (var-get counter)))

;; 
(define-public (increment)
  ;; evaluate multi-line expression
  (begin
    ;; set new value
    (var-set counter (+ (var-get counter) 1))
      ;; return new value
      (ok (var-get counter))))