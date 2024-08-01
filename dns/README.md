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
    S->>D: Query SPF, DKIM, and DMARC records
    D-->>S: Return SPF, DKIM, and DMARC records

    Note over S: SPF Check
    S->>R: Send email
    R->>D: Query SPF record
    D-->>R: Return SPF record
    R->>R: Validate SPF (IP match)

    Note over S: DKIM Signing
    S->>S: Generate DKIM signature
    S->>R: Send email with DKIM signature
    R->>D: Query DKIM public key
    D-->>R: Return DKIM public key
    R->>R: Validate DKIM signature

    Note over R: DMARC Check
    R->>D: Query DMARC record
    D-->>R: Return DMARC record
    R->>R: Evaluate DMARC policy (SPF, DKIM results)

    R->>S: Send email accepted/rejected notification
```