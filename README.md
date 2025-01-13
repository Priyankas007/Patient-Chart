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
 
## **Available Methods**
### **Patient**
- `fullNameAndAge() -> String`: Returns the patient's full name and age in the format `"Last Name, First Name (Age in years)"`.
- `medicationList() -> [Medication]`: Returns a list of medications the patient is currently taking, sorted by date prescribed (newest first), excluding completed medications.
- `prescribeMedication(_ medication: Medication) throws`: Adds a new medication to the patient's list if it doesn't already exist. Throws `DuplicateMedicationError` if a duplicate medication is found.

### **Medication**
- `isCompleted: Bool`: A computed property that returns `true` if the medication has been completed (based on `datePrescribed` and `duration`), otherwise `false`.

### **BloodType**
- `compatibleDonors(for: BloodType) -> [BloodType]`: A static method that returns the list of compatible donor blood types for a given blood type.


## **Getting Started**
1. **Clone the repository**:
   ```bash
   git clone <https://github.com/Priyankas007/Patient-Chart.git>
