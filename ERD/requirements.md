# 📄 Airbnb Clone – Database Requirements

## 👋 Introduction

This document outlines the database schema requirements for an Airbnb-like platform. The system enables users to list properties, make bookings, send messages, write reviews, and process payments.

---

## 🧱 Entities and Attributes

### 🧍 User

- `user_id` (PK, UUID, Indexed)
- `first_name` (VARCHAR, NOT NULL)
- `last_name` (VARCHAR, NOT NULL)
- `email` (VARCHAR, UNIQUE, NOT NULL)
- `password_hash` (VARCHAR, NOT NULL)
- `phone_number` (VARCHAR, NULL)
- `role` (ENUM: guest, host, admin, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

---

### 🏠 Property

- `property_id` (PK, UUID, Indexed)
- `host_id` (FK → User.user_id)
- `name` (VARCHAR, NOT NULL)
- `description` (TEXT, NOT NULL)
- `location` (VARCHAR, Indexed, NOT NULL)
- `pricepernight` (DECIMAL, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `updated_at` (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

---

### 📅 Booking

- `booking_id` (PK, UUID, Indexed)
- `property_id` (FK → Property.property_id, Indexed)
- `user_id` (FK → User.user_id, Indexed)
- `start_date` (DATE, NOT NULL)
- `end_date` (DATE, NOT NULL)
- `total_price` (DECIMAL, NOT NULL)
- `status` (ENUM: pending, confirmed, canceled, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

---

### 💳 Payment

- `payment_id` (PK, UUID, Indexed)
- `booking_id` (FK → Booking.booking_id, Indexed)
- `amount` (DECIMAL, NOT NULL)
- `payment_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `payment_method` (ENUM: credit_card, paypal, stripe, NOT NULL)

---

### 📝 Review

- `review_id` (PK, UUID, Indexed)
- `property_id` (FK → Property.property_id)
- `user_id` (FK → User.user_id)
- `rating` (INTEGER, CHECK: rating BETWEEN 1 AND 5, NOT NULL)
- `comment` (TEXT, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

---

### 💬 Message

- `message_id` (PK, UUID, Indexed)
- `sender_id` (FK → User.user_id)
- `recipient_id` (FK → User.user_id)
- `message_body` (TEXT, NOT NULL)
- `sent_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

---

## 🔗 Relationships

| Relationship          | Direction          | Cardinality            | Participation                       |
| --------------------- | ------------------ | ---------------------- | ----------------------------------- |
| User hosts Property   | User → Property    | 1 → 0..N               | Partial (User), Total (Property)    |
| User makes Booking    | User → Booking     | 1 → 0..N               | Partial (User), Total (Booking)     |
| Property is Booked    | Property → Booking | 1 → 0..N               | Partial (Property), Total (Booking) |
| Booking has Payment   | Booking → Payment  | 1 → 0..1               | Total (Booking), Partial (Payment)  |
| User writes Review    | User → Review      | 1 → 0..N               | Partial (User), Total (Review)      |
| Property has Review   | Property → Review  | 1 → 0..N               | Partial (Property), Total (Review)  |
| User sends Message    | User → Message     | 1 → 0..N (as sender)   | Partial                             |
| User receives Message | User → Message     | 1 → 0..N (as receiver) | Partial                             |

---

## 🔒 Constraints and Rules

### 🔑 Keys

- All primary keys are indexed automatically
- Unique constraint on `email` in User table

### 🔗 Foreign Keys with Cascading

- `host_id` in Property → `ON DELETE CASCADE`
- `user_id` in Booking → `ON DELETE CASCADE`
- `property_id` in Booking → `ON DELETE CASCADE`
- `booking_id` in Payment → `ON DELETE CASCADE`
- `user_id` in Review → `ON DELETE CASCADE`
- `property_id` in Review → `ON DELETE CASCADE`
- `sender_id` and `recipient_id` in Message → `ON DELETE CASCADE`

### ✅ ENUM and CHECKs

- `role`: Must be 'guest', 'host', or 'admin'
- `status`: Must be 'pending', 'confirmed', or 'canceled'
- `rating`: Must be between 1 and 5

---

## ⚙️ Indexing Summary

| Table        | Column(s)      | Reason                      |
| ------------ | -------------- | --------------------------- |
| `users`      | `email`        | Fast login/search           |
| `properties` | `location`     | Location-based search       |
| `bookings`   | `property_id`  | JOIN and filtering          |
| `bookings`   | `user_id`      | JOIN with user info         |
| `payments`   | `booking_id`   | Retrieve payment by booking |
| `messages`   | `sender_id`    | User message history        |
| `messages`   | `recipient_id` | Inbox-style messaging       |

---

## 📝 Notes

- `Booking` is dependent on both `User` and `Property`.
- `Payment` is optional (0..1), occurs only after booking.
- `Message` involves two users, one as sender and one as recipient.
- Reviews are tied to both the user (who wrote it) and the property (being reviewed).

---
