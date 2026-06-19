# Project_1

A SQL query for analyzing lead and order data across different marketing segments.

---

## Use Case

Business teams run multiple marketing forms targeting different audiences (engineering students, coders, non-coders, website visitors, referrals, influencers). This query helps understand how many leads from each segment converted into paying orders, and what their profession breakdown looks like — enabling better targeting and campaign evaluation.

---

## SQL File Description

### `file_1`

A multi-step SQL query built using CTEs (Common Table Expressions):

1. **`raw` CTE** — Fetches distinct leads from specific form IDs within a given date range, along with their profession response (e.g. Student, Salaried Professional, Self-Employed, Founder)

2. **`orders` CTE** — Fetches distinct users who made successful payments via specific payment links, and labels them by segment (`Eng_perf` or `others`)

3. **`finals` CTE** — Maps each form ID to a human-readable segment name and normalizes profession values into three buckets:
   - `Student`
   - `Working Professional` (covers Salaried Professional, Self-Employed, Founder)
   - `Others`

4. **`combined` CTE** — Merges leads and orders into a single dataset using `UNION ALL`

5. **Final output** — Returns a count of distinct emails grouped by `segment` and `profession`

---

## Output Screenshots

### Query Results
![Output 1](image1.png)

![Output 2](image2.png)

