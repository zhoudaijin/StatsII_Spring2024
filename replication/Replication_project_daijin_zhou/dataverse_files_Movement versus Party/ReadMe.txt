* Paper: Ellinas, A. A. & Lamprianou, I. -  Movement versus party: The electoral effects of anti-far right protests in Greece 


* INTRODUCTION
----------------
Project files for the article titled: "Movement versus party: The electoral effects of anti-far right protests in Greece", conditionally accepted at *American Political Science Review*. The files in this reproduction archive exist at the APSR dataverse archive.

* Proposed Dataverse citation: Ellinas, A. A. & Lamprianou, I. (2023). Movement versus party: The electoral effects of anti-far right protests in Greece, American Political Science Review




* CONTENTS
----------
This file includes:
Abstract: This is a copy the abstract, as shown in the printed version of the paper.
Part A: Key Information and Explanation on Dataverse files 
Part B: Software versions and packages
Part C: References for packages used



* ABSTRACT
-----------
The way social protest affects electoral outcomes remains a lacuna. This article helps fill this gap by examining how social protest against far right actors affects their electoral standing. The article utilizes a unique dataset of 4,745 local protest events to investigate how mobilization against the far right in Greece affected its electoral performance. The article finds that protest activity depressed the electoral results of the far right Golden Dawn by as much as 16%, after controlling for a number of important variables. The article identifies and specifies the patterns through which protests against the far right affect its electoral standing. Protests are effective when following the “tango” pattern – when there is close interaction of far right and anti-far right events. The timing of protest is also important and the article shows how the synchronization of protest and electoral cycles affects electoral outcomes. The article uses the findings to discuss the varying impact of protest across electoral cycles.


* Part A: Key Information and Explanation on Dataverse files 
-------------------------------------------------------------

The Dataversion collection of files includes the following:
(a) This "ReadMe.txt" file, which provides information on the available material/files
(b) The file "R code Replication.R", which provides all code necessary to load libraries, data, run models, reconstruct tables and figures etc.
(c) The "raw.Rda" file, which is a native R dataset. This includes 4745 records of events. This file is filtered in various ways, depending on the analysis required.
(d) The "Municipality_Level.Rda" file, which is a native R dataset. This includes 325 records, one per Municipality in Greece.  
(e) The "DtaD.xlsx", which is a MS Excel file. This is the dataset of the *first* coder - see 'coding reliability analysis', Appendix I, in Supplementary Material
(f) The "DtaE.xlsx", which is a MS Excel file. This is the dataset of the *second* coder - see 'coding reliability analysis', Appendix I, in Supplementary Material
(g) The "Full_Supplementary_Material.pdf", which is an Acrobat file. This file includes all appendices, additional tables, figures, details regarding the coding of data etc.
(h) The "elstat_ypes.Rda" file, which is a native R dataset. This holds primary keys (variables) which can be used to link our data to the official data released by the Greek Government - for more details see the file "R code Replication.R".


* Part B: Software versions and packages
------------------------------------------

(a) R version 4.2.2 (2022-10-31 ucrt) -- "Innocent and Trusting"

(b) RStudio 2023.03.0+386 "Cherry Blossom" Release (3c53477afb13ab959aeb5b34df1f10c237b256c3, 2023-03-09) for Windows Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) RStudio/2023.03.0+386 Chrome/108.0.5359.179 Electron/22.0.3 Safari/537.36

(c) Libraries for data handling and data analysis - see pertinent code in "R code Replication.R"

> library(tidyverse); packageVersion("tidyverse") # Library used for data handling and house keeping
[1] ‘2.0.0’
> library(lme4); packageVersion("lme4") # Library used for mixed effects models
[1] ‘1.1.31’
> library(sjPlot); packageVersion("sjPlot") # Library used to display results of lmer library
[1] ‘2.8.12’
> library(readxl); packageVersion("readxl") # Library necessary to read MS Excel files used for coding reliability
[1] ‘1.4.2’
> library(AER); packageVersion("AER") # Library necessary to the ivreg function for the 2-step regression (for instrument variable)
[1] ‘1.2.10


Tidyverse dependencies versions:
✔ dplyr     1.1.0     ✔ readr     2.1.4
✔ forcats   1.0.0     ✔ stringr   1.5.0
✔ ggplot2   3.4.1     ✔ tibble    3.1.8
✔ lubridate 1.9.2     ✔ tidyr     1.3.0
✔ purrr     1.0.1 



* Part C: References for packages
----------------------------------

Bates, D., Maechler, M., Bolker, B., & Walker, S. (2015). Fitting Linear Mixed-Effects Models Using lme4. Journal of Statistical Software, 67(1), 1-48. doi:10.18637/jss.v067.i01.

Kleiber, C., & Zeileis, A. (2008). Applied Econometrics with R. New York: Springer-Verlag. ISBN 978-0-387-77316-2. URL https://CRAN.R-project.org/package=AER

Lüdecke D (2022). _sjPlot: Data Visualization for Statistics in Social Science_. R package version 2.8.12,
  <https://CRAN.R-project.org/package=sjPlot>.

Posit team (2023). RStudio: Integrated Development Environment for R. Posit Software, PBC, Boston, MA. URL http://www.posit.co/.

R Core Team (2022). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.

Wickham H, Averick M, Bryan J, Chang W, McGowan LD, François R, Grolemund G, Hayes A, Henry L, Hester J, Kuhn M, Pedersen TL, Miller E, Bache SM, Müller K, Ooms J, Robinson D, Seidel DP, Spinu V, Takahashi K, Vaughan D, Wilke C, Woo K, Yutani H (2019). Welcome to the tidyverse, Journal of Open Source Software, 4 (43), 1686. doi:10.21105/joss.01686 <https://doi.org/10.21105/joss.01686>.

Wickham H, Bryan J (2023). _readxl: Read Excel Files_. R package version 1.4.2, <https://CRAN.R-project.org/package=readxl>.


