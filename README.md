# **Patient-Chart**

A Swift project designed to manage patient data, including medications, personal information, and medical history. The app provides functionality to track prescribed medications, filter active medications, and ensure no duplicate prescriptions are added.

## **Features**
- Manage patient details (name, age, height, weight, blood type).
- Track prescribed medications with attributes like dose, route, frequency, and duration.
- Automatically filter active (incomplete) medications.
- Prevent duplicate medications from being prescribed.
- Calculate the patient's full name and age dynamically.

## **Project Structure**
- **Models**:
  - `Patient`: Represents a patient's personal details and medical records.
  - `Medication`: Tracks details about a prescribed medication.
  - `BloodType`: Enum representing all possible blood types.
- **Unit Tests**:
  - Validate the functionality of filtering, sorting, and preventing duplicate medications.

## **Getting Started**
1. **Clone the repository**:
   ```bash
   git clone <repository-url>
