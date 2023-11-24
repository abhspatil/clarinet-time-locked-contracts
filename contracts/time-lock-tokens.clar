
;; title: time-lock-tokens
;; version: v0.0.1
;; summary: Lock the tokens till the specific hight is reached
;; description: Lock the tokens till the specific hight is reached

;; traits
;; Owner
(define-constant contract-owner tx-sender)

;; Errors
(define-constant err-owner-only (err u101))
(define-constant err-already-locked (err u102))
(define-constant err-unlock-in-past (err u103))
(define-constant err-no-value (err u104))
(define-constant err-benificiary-only (err u105))
(define-constant err-unlock-hight-not-reached (err u106))

;; data vars
(define-data-var benificiary (optional principal) none)
(define-data-var unlock-hight uint u0)

;; public functions
;;

(define-public (lock-c (n-benificiary principal) (unlock-ht uint) (amount uint))
    (begin
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (asserts! (is-none (var-get benificiary)) err-already-locked)
        (asserts! (> unlock-ht block-height) err-unlock-in-past)
        (asserts! (> amount u0) err-no-value)
        (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
        (var-set benificiary (some n-benificiary))
        (var-set unlock-hight unlock-ht)
        (ok true)
    )
)

(define-public (update-benificiary (n-benificiary principal))
    (begin 
        (asserts! (is-eq (var-get benificiary) (some tx-sender)) err-benificiary-only)
        (var-set benificiary (some n-benificiary))
        (ok true)
    )
)

(define-public (claim) 
    (begin 
        (asserts! (is-eq (some tx-sender) (var-get benificiary)) err-benificiary-only)
        (asserts! (>= block-height (var-get unlock-hight)) err-unlock-hight-not-reached)
        (as-contract (stx-transfer? (stx-get-balance tx-sender) tx-sender (unwrap-panic (var-get benificiary))))
    )
)
