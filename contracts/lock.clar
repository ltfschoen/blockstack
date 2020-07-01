;; contract creation mints a lock-token total supply of 100
;; that are transferred to the contract creator.
;; a recipient may withdraw the total supply from the contract
;; creator after the contract creator has set the lock
;; status of the contract to unlocked;

;; initialize variable
;; syntax: <variable> <type> <value>
;; about: initialize variable using defining statement that must be at top of file
;; it is stored in data space of this smart contract and is persisted
;; acting as global shared state.
(define-data-var is-locked int 0)
(define-data-var contract-owner principal 'STQX02C1KXY4VFYX2ABECJYZ4XAG5KV99WAQ370Z)
(define-constant recipient 'STQX02C1KXY4VFYX2ABECJYZ4XAG5KV99WAQ370Z)

(define-fungible-token lock-token)
;; https://docs.blockstack.org/core/smart/clarityref#ft-mint
(begin (ft-mint? lock-token u100 contract-owner))
(begin (ft-transfer? lock-token u2 contract-owner recipient))

;; get contract owner
;; public function getter read-only
(define-read-only (get-contract-owner)
  (ok (var-get contract-owner)))

;; get lock status (locked: 1, unlocked: 0)
;; public function getter read-only
(define-read-only (get-lock-status)
  (ok (var-get is-locked)))

;; change status to locked
;; public function
(define-public (lock ())
  ;; declare local variable and assign contract storage value
  (let ((owner (var-get contract-owner)))
  ;; check if sender of transaction is the contract owner
  (if (is-eq tx-sender owner)
    ;; evaluate multi-line expression
    (begin
      ;; set new value so status is locked
      (var-set is-locked 1)

      ;; return new value of locked status
      (ok true)))))

;; change status to unlocked
;; public function
(define-public (unlock ())
  ;; declare local variable and assign contract storage value
  (let ((owner (var-get contract-owner)))
  ;; check if sender of transaction is the contract owner
  (if (is-eq tx-sender owner)
    ;; evaluate multi-line expression
    (begin
      ;; set new value so status is unlocked
      (var-set is-locked 0)

      ;; return new value of locked status
      (ok true)))))

;; withdrawal by recipient only when unlocked by contract-owner
;; public function
(define-public (withdraw ())
  ;; declare local variable and assign contract storage value
  (let ((owner (var-get contract-owner)))
    (let ((recipient (var-get recipient)))
      ;; check if sender of transaction is the recipient
      (if (is-eq tx-sender recipient)
        ;; check if the status is unlocked
        (if (is-eq is-locked 0)
          ;; evaluate multi-line expression
          (begin
            ;; transfer token balance of contract-owner to recipient
            (ft-transfer? lock-token u100 contract-owner recipient)
            ;; return new value of locked status
            (ok true)))))))

