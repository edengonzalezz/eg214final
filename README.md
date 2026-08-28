# Ion concentrations in Puerto Rico streams before and after Hurricane Hugo (1989)



## Purpose
This repository contains R code for the replication of Figure 3 from [Schaefer et al. (2000)](https://www.cambridge.org/core/journals/journal-of-tropical-ecology/article/effects-of-hurricane-disturbance-on-stream-water-concentrations-and-fluxes-in-eight-tropical-forest-watersheds-of-the-luquillo-experimental-forest-puerto-rico/2511D4A53DA2C95406014ED75441E77B) (see below), which graphs the concentration of five different ions in different streams in Puerto Rico before and after Hurricane Hugo. 

The graph places Year on the x-axis (1988-1994) facets by ion (potassium, nitrate, magnesium, calcium, and amonium), and plots the 9-week moving average ion concentrations among four streams (Puente Roto Mameyes, Bisley Quebrada 1, Bisley Quebrada 2, Bisley Quebrada 3) on the y-axis.



![[Schaefer et al. (2000)](https://www.cambridge.org/core/journals/journal-of-tropical-ecology/article/effects-of-hurricane-disturbance-on-stream-water-concentrations-and-fluxes-in-eight-tropical-forest-watersheds-of-the-luquillo-experimental-forest-puerto-rico/2511D4A53DA2C95406014ED75441E77B)](../figs/figure3schaefer2000.png)


## Contents

The GitHub reprository contains the following:

* 1_clean_data.R
    - R script that processes files from data/ and creates clean data files, i.e., output.csv.
* data/
    - four downloaded .csv files, each corresponding to a stream in the study.
* docs/
    - paper.html, the rendered quarto document of analysis.
* figs/
    - .png of rendered figure from paper.qmd
* output/
    - output.csv, a cleaned .csv file that combines all files in data/ into a single file to be used for analysis.
* paper/  
    - paper.qmd, which runs the analysis and generates the figure.
* R/
    - moving_average.R, which creates a function that calculates the 9-week moving average of ion concentrations for each stream. 
* scratch/ 
    - exploratory R scripts. 



## Data access

The .zip file containing the data provided by the Environmental Data Initiative were downloaded from [McDowell and International Institute Of Tropical Forestry (IITF) 2024](https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-luq.20.4923064).

## Contributors

@Karlavramos
@olivrwitt

## References 

McDowell, William H., and USDA Forest Service. International Institute Of Tropical Forestry (IITF). 2024. “Chemistry of Stream Water from the Luquillo Mountains.” Environmental Data Initiative. [https://doi.org/10.6073/PASTA/F31349BEBDC304F758718F4798D25458](https://doi.org/10.6073/PASTA/F31349BEBDC304F758718F4798D25458).


Schaefer, Douglas. A., William H. McDowell, Fredrick N. Scatena, and Clyde E. Asbury. 2000. “Effects of Hurricane Disturbance on Stream Water Concentrations and Fluxes in Eight Tropical Forest Watersheds of the Luquillo Experimental Forest, Puerto Rico.” Journal of Tropical Ecology 16 (2): 189–207. [https://doi.org/10.1017/s0266467400001358.](https://doi.org/10.1017/s0266467400001358).


