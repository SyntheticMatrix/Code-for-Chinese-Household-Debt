# Code-for-Chinese-Household-Debt

**STEP1**

Run the data-sorting file 'main_data.m' to execute all the data grids

**STEP2**

Run the simulation code to conduct 'main_intertemporal_simu.m', which should also call the KS test for the convergence

**STEP3**

Run the Gini calculator 'main_gini.m' to produce our Gini analysis and the figures in the maintext

**STEP4**

To get the rest replications:
Run 'main_intertemporal_simu2.m' first to get the standard debt function results

Run 'f_statistics.m' and 'f_s2.m' to get the wealth share statistics with various grids

Run 'Fina_drift_calculator.m' to get the Financial asset drift simulation

Run 'stationary_distribution_spp1.m' and 'stationary_distribution_spp2.m' to get the total asset distribution simulation
