# Code-for-Chinese-Household-Debt

**IMPORTANCE**
The EMPIRICAL ANALYSIS can be done by running the main_file.m, which will automatically run the data sorting, SVAR model, and cross-correlation test. The ADF test can be done by the matlab function adftest. The DAR and DIR are calculated via STATA files. The two are not included in our main_file.m

**STEP1**
Run main_file.m and get all the SVAR and cross-correlation test results

**STEP1.1**
In case of running the empirical results separately, one could achieve by firstly running our data file 'sort_data.m' and get the sorted data in one matrix 'y'

**STEP1.2**
And then run the 'cross_ana.m' to get the cross-correlation results with two figures

**NEW STEP**
Run the 'SVAR_IRF_def.m' to define the cholesky sequences and therefore the subtitles of each panel will be displayed.

**IMPORTANCE ADD-ON**
To get the rest robustness tests in Appendix, please mannually change the data series in the Alternative Cholesky Sequences, they denote the case 2, 3, and 4, respectively. Please also change the substitle from 'title_IRF_v1' to 'title_IRF_v2', 'title_IRF_v3', and 'title_IRF_v4' accordingly, in order to display the correct substitles of the Cholesky Sequences.

To get the rest robustness tests in the response letter, please mannually change the data series in the robustness test alternative section.

**STEP1.3**
Then run the 'SVAR_main.m' to get the SVAR results with various tests and figures

The relevant functions should be placed at the same directory so that the functions can be called upon

**STEP2**
Open the DAR/DIR calculator 'DARDIR_calculator.dta' with STATA to get the cooked data of CHFS2019, specified for our study. The STATA version should be higher than 13.

**STEP2.1**
Read the log file 'STATA_CODE.log', or run the STATA code in it to check our DAR/DIR calculation.
