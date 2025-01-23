# **Patient-Chart**

A Swift project designed to manage patient data, including medications, personal information, and medical history. The app provides functionality to track prescribed medications, filter active medications, and ensure no duplicate prescriptions are added.

## **Features**
- **Patient Management**:
  - Add new patients with required fields (first name, last name, date of birth, height, and weight) and optional blood type.
  - Dynamically calculate and display the patient’s age based on the date of birth.
  - View a list of all patients, sorted alphabetically by last name, with search functionality to filter by last name.
- **Medication Tracking**:
  - Add medications with details like dose, route, frequency, and duration.
  - Automatically filter active (incomplete) medications.
  - Prevent duplicate medications from being prescribed.
  - Display a patient's current medications with all relevant details.
- **Accessibility**:
  - UI components are built with accessibility features such as identifiers and labels for better usability.
- **State Management**:
  - Uses `@State`, `@Binding`, and `@Observable` for managing UI state and patient data.

## **UI Functionality**

### **1. Patient List View**
- Displays all patients in the system, sorted alphabetically by last name.
- Each entry shows:
  - Full name
  - Age
  - Medical record number (MRN)
- Search functionality filters patients by last name dynamically.
- Tapping on a patient navigates to the **Patient Detail View**.
- A button in the toolbar allows the user to add a new patient.

### **2. New Patient Form**
- A form to add new patients with the following fields:
  - **Required**: First name, last name, date of birth, height, and weight.
  - **Optional**: Blood type.
- Validation:
  - The "Save" button remains disabled until all required fields are filled.
  - Displays error messages for invalid inputs, such as non-positive height or weight.
- Automatically dismisses after successfully saving a new patient.

### **3. Patient Detail View**
- Displays a patient’s personal details, including:
  - Full name and age.
  - Height, weight, and blood type (if available).
  - Medical record number.
- Shows a list of the patient’s current medications with details like:
  - Name, dose, route, frequency, and duration.
- A button allows the user to prescribe a new medication, opening the **Prescribe Medication View** as a sheet.

### **4. Prescribe Medication View**
- A form to add medications to the selected patient.
- Input fields:
  - Name
  - Dose
  - Route
  - Frequency (e.g., times per day)
  - Duration (in days)
- Validation:
  - Checks for duplicate medications and shows an error message if the medication is already prescribed.
  - The "Save" button is disabled until all fields are correctly filled.
- Dismisses after successfully saving the new medication.
 
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
