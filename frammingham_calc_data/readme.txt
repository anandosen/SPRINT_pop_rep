Data files: 
HDL_E/F/G.XPT - HDL data from NHANES
SMQ_E/F/G.XPT - Smoking data from NHANES
TCHOL_E/F/G.XPT - Total Cholesterol data from NHANES

Matlab script: 
get_smoking_data.m - Creates a list of patients by their smoking status (from SMQ files). Output written to smoke_data.txt.

get_chol_hdl_data.m - Extracts the total cholesterol and HDL data for patients (from TCHOL and HDL files). Outputs written to chol_data.txt and hdl_data.txt respectively. 

create_table.m - Creates a table of patients with the features to be used for calculation of the framingham scores. The eight features used are age, gender (previously extracted in the demog_data folder), HDL, total cholesterol (extracted in this folder), number of antihypertensive medications (previously extracted in medications_data folder), SBP (previously extracted in bp_data folder), smoking status (extracted in this folder) and diabetes status (previously extracted in diabetes_data folder). Output written to pat_full_data.txt.

fram_main.m - Calculates the framingham scores based on the pat_full_data.txt input. Output written to fram_scores_data.txt.

Output files:
smoke_data.txt - Two-column ASCII file with ID and smoking status. 

hdl_data.txt - Two-column ASCII file with ID and HDL reading. 

chol_data.txt - Two-column ASCII file with ID and total cholesterol reading. 

pat_full_data.txt - Nine-column ASCII file with ID, gender, age, HDL, total cholesterol, number of antihypertensive medications, SBP, smoking status and diabetes status. 

fram_scores_data.txt - Three-column ASCII files with ID, number of points and the Framingham risk (0.5 for <1, 30 for >30).



