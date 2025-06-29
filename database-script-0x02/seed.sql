
-- ========================
-- Airbnb Sample Data Seeding
-- ========================

-- Insert Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(gen_random_uuid(), 'Alice', 'Smith', 'alice@example.com', 'hashed_pw1', '1234567890', 'guest'),
(gen_random_uuid(), 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw2', '1234567891', 'host'),
(gen_random_uuid(), 'Charlie', 'Lee', 'charlie@example.com', 'hashed_pw3', '1234567892', 'guest'),
(gen_random_uuid(), 'Diana', 'Moore', 'diana@example.com', 'hashed_pw4', '1234567893', 'host');

-- Insert Properties (2 sample properties, 2 hosts)
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night)
SELECT gen_random_uuid(), user_id,
       name, description, location, price
FROM (VALUES
    ('Beachside Bungalow', 'A cozy beach house with ocean view.', 'Miami, FL', 150.00),
    ('Mountain Cabin', 'A rustic cabin in the mountains.', 'Aspen, CO', 200.00)
) AS p(name, description, location, price),
(SELECT user_id FROM users WHERE role = 'host' ORDER BY user_id LIMIT 2) h;

-- Insert Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT gen_random_uuid(), prop.property_id, guest.user_id,
       CURRENT_DATE + INTERVAL '7 days',
       CURRENT_DATE + INTERVAL '10 days',
       prop.price_per_night * 3,
       'confirmed'
FROM properties prop,
     (SELECT user_id FROM users WHERE role = 'guest' ORDER BY user_id LIMIT 2) guest
LIMIT 2;

-- Insert Payments (linked to bookings)
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
SELECT gen_random_uuid(), b.booking_id, b.total_price, 'credit_card'
FROM bookings b;

-- Insert Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
SELECT gen_random_uuid(), prop.property_id, guest.user_id,
       FLOOR(RANDOM() * 5 + 1), 'Great stay, would recommend!'
FROM properties prop,
     (SELECT user_id FROM users WHERE role = 'guest' ORDER BY user_id LIMIT 2) guest;

-- Insert Messages between guest and host
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
SELECT gen_random_uuid(), guest.user_id, host.user_id, 'Hi, is your place available next weekend?'
FROM (SELECT user_id FROM users WHERE role = 'guest' LIMIT 1) guest,
     (SELECT user_id FROM users WHERE role = 'host' LIMIT 1) host;
