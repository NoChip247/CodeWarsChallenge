## Description

In baseball, the batting average is a simple and most common way to measure a hitter's performance. It is calculated by dividing a player's total hits by their number of at-bats and is usually displayed as a 3-digit decimal (e.g., 0.300).

Given a `yankees` table with the following schema:

### `yankees` Table Schema

- `player_id` (STRING)
- `player_name` (STRING)
- `primary_position` (STRING)
- `games` (INTEGER)
- `at_bats` (INTEGER)
- `hits` (INTEGER)

Return a table with the following columns:

- `player_name` (STRING)
- `games` (INTEGER)
- `batting_average` (STRING)

Requirements:

- Calculate `batting_average` as `hits` divided by `at_bats`.
- Round `batting_average` to the nearest thousandth (3 decimal places).
- Format `batting_average` as text with exactly 3 digits after the decimal point, padding with zeros if necessary.
- Exclude any player with fewer than 100 at-bats.
- Order the resulting table by `batting_average` in descending order.

## Solution

```sql
SELECT
  player_name,
  games,
  TO_CHAR(hits::numeric / at_bats, '0.000') AS batting_average
FROM yankees
WHERE at_bats >= 100
ORDER BY batting_average DESC;
