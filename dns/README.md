# DNS

Knowledgebase for all things DNS.


## Mail Records

DMARC, DKIM, and SPF... GAAHHHH!!!

Yeah, I remember not knowing what the heck these things meant. Its really weird how things that were once mysterious are now simple. I hope is to explain these abbreviations in the simplest way I know how.

```mermaid
sequenceDiagram
    participant S as Sending Mail Server
    participant R as Receiving Mail Server
    participant D as DNS Server

    Note over S: Mail Preparation
    S->>R: Send email

    Note over R: SPF Check
    R->>D: Query SPF record
    D-->>R: Return SPF record
    R->>R: Validate SPF (IP match)

    Note over R: DKIM Verification
    R->>D: Query DKIM public key
    D-->>R: Return DKIM public key
    R->>R: Validate DKIM signature

    Note over R: DMARC Check
    R->>D: Query DMARC record
    D-->>R: Return DMARC record
    R->>R: Evaluate DMARC policy (SPF, DKIM results)

    R->>S: Send email accepted/rejected notification

```