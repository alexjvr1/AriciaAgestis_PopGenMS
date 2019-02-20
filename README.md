# AriciaAgestis_PopGenMS

Data processing and analyses for the manuscript: 

De Jong M, Jansen van Rensburg A, Bridle J (20xx) Few genes of large effect underpin specialisation on host plant in the Brown Argus butterfly in the UK. 


Aims: 

1. Population structure 

2. Genome scan for loci associated with change host plant species. 

3. Determine whether these outliers are linked with traits in female host plant choice experiment

4. Determine the colonisation history of these populations. 


## Map of sample locations

Sample locations, site colonisation history, and dominant host plant data were provided by Maaike. See Brown_Argus_ddRAD_samples.xlsx for info sent June 2018. 

Draw map of locations in R. 

```
pwd /Users/alexjvr/2018.postdoc/BrownArgus_2018/BrownArgusDataMap 

##R

library(sp)  # classes for spatial data
library(raster)  # grids, rasters
library(rasterVis)  # raster visualisation
library(maptools)
library(rgeos)


##get UK map

require(spatial.tools)
elevation<-getData("alt", country = "GB")
x <- terrain(elevation, opt = c("slope", "aspect"), unit = "degrees")
plot(x)
slope <- terrain(elevation, opt = "slope")
aspect <- terrain(elevation, opt = "aspect")
hill <- hillShade(slope, aspect, 40, 270)
plot(hill, col = grey(0:100/100), legend = FALSE, main = "UK")
#plot(elevation, col = rainbow(25, alpha = 0.35), add = TRUE)

##BA data points
BA.SiteInfo <- read.table("BA_SiteInfo", header=T)  ##read table of info into R
UK.coords <- BA.SiteInfo ##change name of file so that it can be manipulated
coordinates(UK.coords) <- c("Long", "Lat")  # set spatial coordinates. Remember to check that these make sense
#plot(CH_coords)
#plot(CH_coords, pch = 20, cex = 1, col = "black")
crs.geo <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84")  # geographical, datum WGS84
proj4string(UK.coords) <- crs.geo  # define projection system of our data
summary(UK.coords)

##add columns for colour (host plant) and shape (new vs old sites). 

UK.coords$pch <- c(17, 15, 17,15, 15, 15, 17, 15, 17)
UK.coords$Colours <- c("gold1", "gold1", "darkorchid3", "gold1", "darkorchid3", "gold1", "darkorchid3", "gold1", "darkorchid3")

##plot map
pdf("BA.sampleMap_20180619.pdf")
plot(hill, col = grey(0:100/100), legend = FALSE, main = "UK")
plot(UK.coords, pch=UK.coords$pch, cex=2, col=UK.coords$Colours, add=T)
dev.off()
```

![alt_txt][Fig1]

[Fig1]:https://user-images.githubusercontent.com/12142475/41651877-90a4bb8c-7479-11e8-9549-821f4ee84895.png


## 1.RawData_to_Variants.md

Processing of raw Illumina data to a variant file. 

## 2.SNPfiltering.md

Filtering of SNPs for 1) population genetic analyses, and 2) outlier/Environmental association analyses. 

## 3.GeneticDiversity&Structure.md

1) Estimates of genetic diversity

2) Genetic distance between populations (Fst)

3) Estimate of Isolation by distance

4) PCA

5) fineRADstructure

## 4.ColonisationHistory

How did A.agestis colonise the UK? 

  - fastSimCoal analyses


## 5.SpecialisationAtRangeMargin.md

Have population at the range margin become specialised? What are the main drivers of genetic divergence here? 

   - Redundancy and partial Redundancy analyses


## 6.AdaptationtoHostPlant.md

Has A.agestis specialised on new host plant at range margins? 

   - Environmental Association Analysis
      
      Identify outliers 




