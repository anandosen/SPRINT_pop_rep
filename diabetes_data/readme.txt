Data files: 
DIQ_E/F/G.XPT - Diabetes diagnosis data from NHANES
GHB_E/F/G.XPT - Hba1c data from NHANES
GLU_E/F/G.XPT - Fasting glucose data from NHANES
OGTT_E/F/G.XPT - 2 hour glucose data from NHANES

Matlab script: 
diabetes_diag.m - Extracts the patients who have a previous diagnosis of diabetes. Output written to diab_patients_by_diag.txt.

diabetes_medics.m - Extracts patients who are on insulin or oral hypoglycemic medications. Output written to diab_patients_by_medics.txt.

diabetes_lab.m - Extracts the patients who meet the lab criteria for diabetes - fasting glucose >126 (from GLU files), hba1c >6.5 (from GHB files), other glucose measurements >200 (from OGTT and BIOPRO [in the gfr_calc_data folder] files). Output written to diab_patients_by_lab.txt.

diabetes_combined.m - Identifies diabetic patients as previous diagnosis with current use of medication OR meeting one of the lab criteria for diabetes.

Intermediate Output files:
diab_patients_by_diag.txt - One-column ASCII file with IDs of patients with diabetes diagnosis. 

diab_patients_by_medics.txt - One-column ASCII file with IDs of patients on insulin or oral hypoglycemic medications.

diab_patients_by_lab.txt - One-column ASCII file with IDs of patients meeting the lab criteria for diabetes.

Output file:
diab_patients_overall.txt - Two-column ASCII file with ID and diabetes status.