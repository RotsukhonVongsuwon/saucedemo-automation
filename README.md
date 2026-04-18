# 🔐 Saucedemo Automation (Learning Project)

## 📌 About This Project
This project is created as part of my self-learning journey to transition from **Manual QA to Automation QA**.

I am currently learning how to build automated tests using Robot Framework and applying real-world testing concepts such as test case design (TCM), reusable keywords, and basic reporting integration.

---

## 🎯 Purpose
- Practice automation testing skills
- Apply test cases from TCM into automation scripts
- Learn how to structure a small automation project
- Explore integration with external tools (Google Sheets)

---

## 🛠 Tools & Technologies
- Robot Framework
- Browser Library (Playwright)
- RequestsLibrary
- Google Sheets (via Apps Script)

---

## 📂 Project Structure

- tests/
  - login.robot
  - product.robot
- keywords/
  - common.robot
- resources/
  - config.yaml

---

## 🧪 Test Coverage (Based on TCM)

### ✅ Completed
- **Login Flow**
  - Invalid username
  - Invalid password
  - Empty username
  - Empty password
  - Locked out user
  - Problem user
  - Valid login
- **Product Flow** (In progress)
  - Display product list
  - Display product name
  - Display product price
  - Display product image
  - Display product description


### 🚧 In Progress (Coming Soon)
- Product Flow >> (In progress)
- Cart Flow
- Checkout Flow

---

## 🚀 How to Run

```bash
pip install robotframework
pip install robotframework-browser
pip install robotframework-requests
rfbrowser init
robot tests/login.robot
```

---

## 📊 Test Result

Test execution is working locally and results are generated using Robot Framework (report.html / log.html).

Test results are also logged to Google Sheets (for tracking test execution status):
https://docs.google.com/spreadsheets/d/1SjNGOeavPd044FWMiPMH09Glsur_8l3ZjkQ5ScZKAKE/edit?usp=sharing
