# Part 1
  - form with input fields for the necessary data
  - two page setup/confirmation page is implemented in jquery
  - sessions controller allows someone to login just with their email
  - added index on email to application table to speed up login

# Part 2
  - Given a start_date and end_date, a function splits up the range into weeks
  - for each week, a database query does a `group by` to get counts of statuses
  - added index to created_at to speed up lookup, roughly doubled performance
  - ideally this would be reduced to one query. I couldn't figure out how to do this with ActiveRecord despite much research. Raw SQL would go something like this, and the date functions would depend on what type of database we are using:
    ```sql
    SELECT
      date(created_at, 'weekday 0', '-6 days') as monday,
      workflow_state,
      count(*)
    FROM
      applications
    WHERE
      created_at > :start_date AND
      created_at < :end_date
    GROUP BY
      date(created_at, 'weekday 0', '-6 days'),
      workflow_state
    ```
  - currently the funnels controller is never sent any start/end data from the dashboard, with more time I would put a date picker on there.
