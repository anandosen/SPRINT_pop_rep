Data files: 
RXQ_RX__E/F/G.XPT - Medications data from NHANES
RXQ_DRUG.XPT - Categorization for all medications into drug classes in form of a 3-layer tree from NHANES

Matlab script: 
get_medics.m - First identifies the individual medications in the already-known drug classes of anti-hypertensives. This is followed by calculating the number of antihypertensive medications prescribed to a patient.

Output file:
nomed_table.txt - Two-column ASCII file with ID and the number of antihypertensive medications prescribed respectively.