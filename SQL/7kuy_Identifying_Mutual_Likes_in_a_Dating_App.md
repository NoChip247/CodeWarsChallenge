## Identifying Mutual Likes in a Dating App

### Description

Imagine you are working for a dating app. Users of the app can "like" other users, and these interactions are stored in a database table called `user_likes`. The app's key feature is matching users when there is a mutual like, meaning both users have liked each other.

#### user_likes Table Structure
- `id` (int): Primary key
- `liker_id` (int): The ID of the user who sent the like.
- `liked_id` (int): The ID of the user who received the like.

### Task

Write a query to identify mutual likes from the `user_likes` table. A mutual like exists when:
- User A likes User B, and
- User B likes User A.

Additionally:
- Each pair must be reported only once, regardless of the order in which the users liked each other.
- Assign the smaller ID to the first column (`user1_id`) and the larger ID to the second column (`user2_id`).
- The output must be sorted by `user1_id` and then by `user2_id` in ascending order.

### Notes
- Self-likes (e.g., a user liking themselves) are not logical in the context of a dating app and do not exist in the system.
- It is possible to have duplicates recorded multiple times. Ensure each match is returned only once.

### Sample Data

#### Input: user_likes Table

| liker_id  | liked_id |
|-----------|----------|
| 101       | 202      |
| 202       | 101      |
| 303       | 404      |
| 303       | 505      |

#### Expected Output

| user1_id | user2_id |
|----------|----------|
| 101      | 202      |

---

### Solution

```sql
SELECT DISTINCT
    ul1.liker_id AS user1_id,
    ul1.liked_id AS user2_id
FROM
    user_likes AS ul1
JOIN
    user_likes AS ul2
ON
    ul1.liker_id = ul2.liked_id
    AND ul1.liked_id = ul2.liker_id
WHERE
    ul1.liker_id < ul1.liked_id
ORDER BY
    user1_id, user2_id;
