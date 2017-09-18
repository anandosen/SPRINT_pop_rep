sp_with_elig.m - This is an aggregates of all demographic and BP information for a generic
hypertensive population (defined by SBP > 130 OR on antihypertensive medications) and then
applies the SPRINT eligibility criteria to identify the SPRINT-eligible patients. The
generic hypertensive population is written to 'target_pop.txt' and eligible patients to
'study_pop.txt'.

target_pop.txt - Seven column ASCII file with ID, gender, age, race, SBP, DBP and
medications for the generic hypertensive population.

study_pop.txt - Seven column ASCII file with ID, gender, age, race, SBP, DBP and
medications for the SPRINT-eligible population.

format_tp_sp.m - Consolidates all eligibility traits and formats the TP into a structured
table format with all traits. Output files are given below.

target_pop2_input.txt - twelve-column ASCII file of TP with the following traits (in
order): diabetes, stroke, proteinuria, heart failure, ESRD, Clinical CVD, eGFR, Framingham
risk, age, SBP, medications, age. Age is present twice - once to determine eligibility,
and once to determine seniority.

overall_elig2.txt - One column ASCII file with overall eligibility status of patients in
target_pop2_input.txt.

elig_traits_tp2.txt - Trait-wise eligibility status for the twelve columns of
target_pop2_input.txt.

target_pop1_input.txt - Similar file to target_pop2_input.txt but with 9 columns. The
high-risk criteria is condensed into one categorical variable. (This is not used anymore.
As aren't the corresponding files overall_elg.txt, elig_traits_tp1.txt)

Other files are no longer necessary.