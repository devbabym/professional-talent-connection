;; Professional Talent Connection Platform on stacks
;; A decentralized system for connecting talent with opportunities
;; This smart contract enables talent registration, business registration,
;; and opportunity posting with secure profile management.

;; ======== ERROR DEFINITIONS ========

(define-constant ERR-NOT-FOUND (err u404))
(define-constant ERR-ALREADY-EXISTS (err u409))
(define-constant ERR-INVALID-SKILLS (err u400))
(define-constant ERR-INVALID-LOCATION (err u401))
(define-constant ERR-INVALID-RESUME (err u402))
(define-constant ERR-INVALID-JOB-POST (err u403))
(define-constant ERR-ORGANIZATION-MISSING (err u404))

;; ======== DATA STRUCTURES ========

;; Database for professional profiles
(define-map professional-records
    principal
    {
        name: (string-ascii 100),
        skills: (list 10 (string-ascii 50)),
        location: (string-ascii 100),
        resume: (string-ascii 500)
    }
)

;; Registry of companies on platform
(define-map company-registry
    principal
    {
        company-name: (string-ascii 100),
        industry: (string-ascii 50),
        location: (string-ascii 100)
    }
)

;; Repository of available job listings
(define-map job-listings
    principal
    {
        title: (string-ascii 100),
        description: (string-ascii 500),
        company-id: principal,
        location: (string-ascii 100),
        requirements: (list 10 (string-ascii 50))
    }
)

;; ======== PUBLIC FUNCTIONS ========

;; Register a new company profile
(define-public (register-company 
    (company-name (string-ascii 100))
    (industry (string-ascii 50))
    (location (string-ascii 100)))
    (let
        (
            (owner-id tx-sender)
            (existing-company (map-get? company-registry owner-id))
        )
        ;; Verify no existing registration
        (if (is-none existing-company)
            (begin
                ;; Ensure all fields contain data
                (if (or (is-eq company-name "")
                        (is-eq industry "")
                        (is-eq location ""))
                    (err ERR-INVALID-LOCATION)
                    (begin
                        ;; Store company information
                        (map-set company-registry owner-id
                            {
                                company-name: company-name,
                                industry: industry,
                                location: location
                            }
                        )
                        (ok "Company successfully registered in the network.")
                    )
                )
            )
            (err ERR-ALREADY-EXISTS)
        )
    )
)

;; Create a new job listing
(define-public (create-job-listing 
    (title (string-ascii 100))
    (description (string-ascii 500))
    (location (string-ascii 100))
    (requirements (list 10 (string-ascii 50))))
    (let
        (
            (owner-id tx-sender)
            (existing-listing (map-get? job-listings owner-id))
        )
        ;; Check if listing already exists
        (if (is-none existing-listing)
            (begin
                ;; Validate mandatory fields
                (if (or (is-eq title "")
                        (is-eq description "")
                        (is-eq location "")
                        (is-eq (len requirements) u0))
                    (err ERR-INVALID-JOB-POST)
                    (begin
                        ;; Record the job opportunity
                        (map-set job-listings owner-id
                            {
                                title: title,
                                description: description,
                                company-id: owner-id,
                                location: location,
                                requirements: requirements
                            }
                        )
                        (ok "Job listing successfully published to network.")
                    )
                )
            )
            (err ERR-ALREADY-EXISTS)
        )
    )
)

;; Register as a professional
(define-public (register-professional 
    (name (string-ascii 100))
    (skills (list 10 (string-ascii 50)))
    (location (string-ascii 100))
    (resume (string-ascii 500)))
    (let
        (
            (user-id tx-sender)
            (existing-profile (map-get? professional-records user-id))
        )
        ;; Ensure profile doesn't already exist
        (if (is-none existing-profile)
            (begin
                ;; Check for valid information
                (if (or (is-eq name "")
                        (is-eq location "")
                        (is-eq (len skills) u0)
                        (is-eq resume ""))
                    (err ERR-INVALID-RESUME)
                    (begin
                        ;; Add professional to platform
                        (map-set professional-records user-id
                            {
                                name: name,
                                skills: skills,
                                location: location,
                                resume: resume
                            }
                        )
                        (ok "Professional profile successfully registered.")
                    )
                )
            )
            (err ERR-ALREADY-EXISTS)
        )
    )
)

;; ======== READ-ONLY FUNCTIONS ========

;; Retrieve professional's information
(define-read-only (get-professional-info (user-id principal))
    (match (map-get? professional-records user-id)
        profile-data (ok profile-data)
        ERR-NOT-FOUND
    )
)

;; Access company information
(define-read-only (get-company-info (company-id principal))
    (match (map-get? company-registry company-id)
        company-data (ok company-data)
        ERR-NOT-FOUND
    )
)

;; View job listing details
(define-read-only (get-job-details (listing-id principal))
    (match (map-get? job-listings listing-id)
        listing-data (ok listing-data)
        ERR-NOT-FOUND
    )
)
