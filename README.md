# Code-for-Chinese-Household-Debt

**IMPORTANCE**
The EMPIRICAL ANALYSIS can be done by running the main_file.m, which will automatically run the data sorting, SVAR model, and cross-correlation test. The ADF test can be done by the matlab function adftest. The DAR and DIR are calculated via STATA files. The two are not included in our main_file.m

**STEP1**
Run main_file.m and get all the SVAR and cross-correlation test results

**STEP1.1**
In case of running the empirical results separately, one could achieve by firstly running our data file 'sort_data.m' and get the sorted data in one matrix 'y'

**STEP1.2**
And then run the 'cross_ana.m' to get the cross-correlation results with two figures

**STEP1.3**
Then run the 'SVAR_main.m' to get the SVAR results with various tests and figures

The relevant functions should be placed at the same directory so that the functions can be called upon

**STEP2**
Open the DAR/DIR calculator 'DARDIR_calculator.dta' with STATA to get the cooked data of CHFS2019, specified for our study. The STATA version should be higher than 13.

**STEP2.1**
Read the log file 'STATA_CODE.log', or run the STATA code in it to check our DAR/DIR calculation.
