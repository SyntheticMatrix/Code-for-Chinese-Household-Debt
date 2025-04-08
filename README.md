# Code-for-Chinese-Household-Debt

**IMPORTANCE**
All models should be run after the Inter-temporal HJB problem is solved, which should only take a few seconds. They will load the initial states solved by the HJB problem and proceed the impulse response analysis.

Here is the formal steps:

**STEP1**
Run the baseline model 'compl_ge.m', which serves as our baseline ge model (i.e. without projection of the heterogeneity information and endogeneous non-financial asset interest rate)

**STEP2**
Run the endogeneous non-financial asset interest rate extension, named 'dsge_er.m'

**STEP3**
Run the projection of heterogeneity, with the following substeps:

**STEP3.1**
Conduct the residual minimization by running 'projection_method.m'

**STEP3.2**
Conduct the Chebyshev Derivative to get the projectors by running 'chebyshev_derivative.m'

**STEP3.3**
Run the model 'dsge_projection.m'

All above should call upon the QZ solver 'solab.m' and the impulser response creator 'ir.m' and get the impulse responses of the total effects

