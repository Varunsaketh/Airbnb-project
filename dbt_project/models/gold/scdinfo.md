What is a Slowly Changing Dimension?
A Slowly Changing Dimension (SCD) is a data warehousing technique for managing changes to dimension attributes over time.

There are different types of SCD, but let's focus on Types 1 and 2.
SCD Type 1 — Overwrite old values
SCD Type 1 updates the existing record without preserving its previous value.


Notice that the old city disappears.

When to use it:
- Correcting spelling mistakes.
- Fixing invalid email addresses.
- Correcting inaccurate source data.
- When historical values aren't required.
SCD Type 1 behaves much like a conventional UPSERT for changed records.
SCD Type 2 — Preserve historical changes
SCD Type 2 creates a new version of the record when a tracked attribute changes.

Suppose Rahul moves from Hyderabad to Bangalore on January 1, 2026.


Instead of overwriting the old record, we preserve it and insert a new version.

Now you can answer both questions:
- Where does Rahul live now? Bangalore.
- Where did Rahul live in 2025? Hyderabad.
That's the main benefit of SCD Type 2.

we are using scd type 2 here 