# 📘 Normalization Report – Airbnb Clone Database

## ✅ Objective

To ensure that the database schema adheres to the principles of normalization, particularly up to **Third Normal Form (3NF)**. This helps in minimizing redundancy, improving data integrity, and optimizing storage.

---

## 🔍 Step-by-Step Normalization

### 🔹 First Normal Form (1NF)

**Definition:**

- Eliminate repeating groups.
- Ensure that each column holds atomic (indivisible) values.

**✔ Achieved:**

- All tables have atomic fields.
- No multi-valued or composite attributes.
- Each row is uniquely identified by a primary key.

✅ Example:

- `phone_number` in the `users` table is a single value per user.
- `roles` is stored as a single ENUM value.

---

### 🔹 Second Normal Form (2NF)

**Definition:**

- Be in 1NF.
- Remove partial dependencies (i.e., non-key attributes depend on entire primary key).

**✔ Achieved:**

- All tables have **single-column primary keys** (UUIDs), so no partial dependencies exist.
- All non-key attributes in each table fully depend on their primary key.

✅ Example:

- In the `bookings` table, `start_date`, `end_date`, and `status` depend only on `booking_id`, not partially on `user_id` or `property_id`.

---

### 🔹 Third Normal Form (3NF)

**Definition:**

- Be in 2NF.
- Remove transitive dependencies (i.e., non-key attributes depending on other non-key attributes).

**✔ Achieved:**

- No transitive dependencies exist.
- All non-key attributes directly describe the primary key.

✅ Example:

- In `users`, `email`, `first_name`, `role`, etc. all describe `user_id`.
- In `payments`, `amount`, `payment_method` all relate directly to `payment_id`.

---

## 🧹 Design Adjustments Made

### ❌ No major violations found in original schema

However, we reviewed these possible issues:

| Area                         | Adjustment                           | Reason                                                                    |
| ---------------------------- | ------------------------------------ | ------------------------------------------------------------------------- |
| `payment.booking_id`         | ✅ Kept as FK                        | Payment is always tied to a booking — not repeated across tables          |
| `messages` (sender/receiver) | ✅ Structured properly               | Two FKs used; each message is atomic and has one sender and one recipient |
| `role` in users              | ✅ Used ENUM instead of lookup table | Acceptable for limited, unchanging set (guest, host, admin)               |

---

## ✅ Summary

The database has been reviewed and confirmed to meet:

- 1NF: Atomic values, no repeating groups
- 2NF: All non-key columns fully dependent on the whole primary key
- 3NF: No transitive dependencies

This structure ensures the system is **efficient, scalable, and maintainable**.
