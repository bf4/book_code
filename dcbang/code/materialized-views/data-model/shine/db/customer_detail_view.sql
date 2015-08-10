-- START:select
SELECT
  customers.id             AS customer_id,
  customers.first_name     AS first_name,
  customers.last_name      AS last_name,
  customers.email          AS email,
  customers.username       AS username,
  customers.created_at     AS joined_at,
  billing_address.id       AS billing_address_id,
  billing_address.street   AS billing_street,
  billing_address.city     AS billing_city,
  billing_state.code       AS billing_state,
  billing_address.zipcode  AS billing_zipcode,
  shipping_address.id      AS shipping_address_id,
  shipping_address.street  AS shipping_street,
  shipping_address.city    AS shipping_city,
  shipping_state.code      AS shipping_state,
  shipping_address.zipcode AS shipping_zipcode
FROM
  customers
-- END:select
-- START: customers_billing_addresses
JOIN customers_billing_addresses  ON
  customers.id = customers_billing_addresses.customer_id
-- END: customers_billing_addresses
-- START: billing_address
JOIN addresses billing_address    ON
  billing_address.id = customers_billing_addresses.address_id
-- END: billing_address
-- START: billing_state
JOIN states billing_state         ON
  billing_address.state_id = billing_state.id
-- END: billing_state
-- START: shipping_address
JOIN customers_shipping_addresses ON
  customers.id = customers_shipping_addresses.customer_id
  AND customers_shipping_addresses.primary = true
JOIN addresses shipping_address   ON
  shipping_address.id = customers_shipping_addresses.address_id
JOIN states shipping_state        ON
  shipping_address.state_id = shipping_state.id
-- END: shipping_address
;
