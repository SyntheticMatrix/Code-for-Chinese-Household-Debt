# Code-for-Chinese-Household-Debt

**IMPORTANCE**
All models should be run after the Inter-temporal HJB problem is solved, which should only take a few seconds. They will load the initial states solved by the HJB problem and proceed the impulse response analysis.

Here is the formal steps:

**STEP1**
Run the endogeneous non-financial asset interest rate extension, named 'dsge_er.m'

**STEP2**
Run the projection of heterogeneity, with the following substeps:

**STEP2.1**
Conduct the residual minimization by running 'projection_method.m'

**STEP2.2**
Conduct the Chebyshev Derivative to get the projectors by running 'chebyshev_derivative.m'

**STEP2.3**
Run the model 'dsge_projection.m'

**STEP3**
Run the regime-switching forward-looking model: 'main_regime.m' and 'regimeswitching.m' to get the IRFs for the k=p=1 case.

**STEP3.1**
Run 'IRRIG.m' to get the figure replication.

**STEP3.2**
Change the monetary policy response parameters in accordance with the instruction in 'main_regime.m' to get the IRFs for the k=p=2 case.

**STEP3.3**
Simiarly, run 'IRRIG.m' again the get the figure replication.

All above should call upon the QZ solver 'solab.m' and the impulse response creator 'ir.m' and get the impulse responses of the total effects

