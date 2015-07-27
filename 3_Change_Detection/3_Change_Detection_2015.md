***Pontus Olofsson, Christopher E. Holden, Eric L. Bullock***![](media/image01.gif)![](media/image05.png)

*Boston Education in Earth Observation Data Analysis/*

*Department of Earth & Environment, Boston University*

**3. Change detection**

3.1 Introduction
----------------

The goal of this assignment is use what you have learned so far during this workshop to produce a change map. It requires two dates of imagery (we will call these to images Date 1 and Date 2), sufficiently far apart for change detection. You can chose to study forest loss and/or regrowth or any other land change process. You need to apply what you learned about atmospheric correction, cloud screening and classification to produce your change map. There are various different methods of change detection, all with their pros and cons. This workshop will introduce you to just a few, which may or may not be suitable to your needs in the future.

Historically, the most common method of change detection in remote sensing has been post-classification comparison. Using this method you would classify two maps separately, and create a change map out of where they differ. While this is computationally efficient compared to other methods, it is not recommended and will not be utilized in this workshop. There are a few reasons why this is not recommended:

1.  Errors in the change map are multiplicative from the errors of the two classified single-date maps. Since the accuracy of the change map is directly dependent on the accuracies of the parent maps, overall change accuracy tends to be low. This often results in over-estimated total change area.

2.  This method tends to ignore subtle changes within a class. It is difficult to study classes such as degradation and regrowth when change is solely based on map classification. For these reasons, we recommend creating change maps based on changes in the raw data instead of changes in maps. In this exercise, you will learn how to directly classify change based on the information in both of your images.

3.2 Goals
---------

-   Make sure you start with two cloud-screened images from different dates in the units of surface reflectance.

-   Create a multi-temporal transform to help locate areas on change in your images. We will introduce you to a few possible ways of doing this to exploit the differences in the images.

-   Create ROIs for your map, containing regions of stable classes and whatever change classes you have defined for your final change map.

-   Produce a change map. Like creating your classification images, this may take a few tries to perfect.

3.3 Create file structure
-------------------------

Create the following structure in your work directory using either *Caja* or *MATE Terminal*:
---------------------------------------------------------------------------------------------

3\_change\_detection
--------------------

0\_sourcedata 
--------------

1\_extract
----------

2\_stack
--------

3\_subset
---------

4\_training
-----------

5\_map
------

If you don’t want use the image you worked on in Module 1 *Introduction*, copy a suitable image from your data directory to “0\_sourcedata” that you just created, extract the bands to “1\_extract” and create a stack in “2\_stack” -- this will be either the Date 1 or Date 2 image; lets assume that it’s the Date 1 image. If you have forgotten how to complete these steps, refer to Module 1 *Introduction*. If you do want to use the image you already extracted and stacked, it is better to create symbolic links to the original files (sourcedata, extracted and stacked data, and potentially the training data) rather than copying it as this will save space. If you have forgotten how to complete these steps, refer to Module 1 *Introduction* and Module 2 *Classification*. Note that you will need a Date 2 image of the same area to make a change map. 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

3.4 Open Your Images
--------------------

You will need to create a stack of the second image (Date 1) -- make sure that the stack contains the same bands as the Date 1 stack; pay special attention to this if one of the images is a L8 image and the other a L5 or 7 image. It is also recommended that the two images are subsetted. To begin this assignment, open the two subsetted stacks; not the classified maps you made in Module 2. Display the images in matching stretches. **Reference Subsection 3.1 in Supplementary Tutorial 3 *Methods Change Detection* for instructions on how to apply matching stretches**; and **Subsection 2.1 in Supplementary Tutorial 2 *Methods Classification* for instructions on how to subset images. **

3.5 Create a Single-Date Transform
----------------------------------

Click back and forth between your images. Are there any distinct areas that seem to be changing? Large changes are likely to be visible by doing this, but small changes will not be. Even large changes can be difficult to detect by just comparing the original images. One method to help changes stand out more clearly is by creating a multi-temporal transform.

To do this, you must first decide on what type of transformation you would like to do to your imagery. There are different types of transforms, each with their own advantages. By creating a transform we are leveraging multiple bands of information in an image to highlight specific information that we are looking for. The transformation that you do should correspond with what type of change you are looking for.

Use the following table to guide you in deciding what transformation you would like to do. This is just a small list of some of the more common transformations, but is by no means all of them. Once you have decided on a transformation, you will perform it on both images, and the difference in the resulting images will be your multi-temporal transformation. Once you have decided on a transformation to use, you are going to perform the calculation in QGIS. **Reference Subsection 3.2 in Tutorial 3 *Methods Change Detection* for instructions on using *Raster Calculator* in QGIS.**

| **Transform**                                 | **Formula**                                                    | **Purpose**                                                                                                             |
|-----------------------------------------------|----------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------|
| Normalized Difference Vegetation Index (NDVI) | (NIR – RED) /                                                  
                                                                                                                 
                                                 (NIR + RED)                                                     | Differentiates between vegetated and non-vegetated land. Ranges from -1 to 1.                                           |
| Normalized Burn Ratio (NBR)                   | (NIR-SWIR2) / (NIR+SWIR2)                                      | Highlight burn scars and severity. Works well for other types of change as well.                                        |
| Enhanced Vegetation Index (EVI)               | 2.5 \* ( NIR - RED ) / ( NIR + 6.0 \* RED - 7.5 \* BLUE + 1.0) | Alternative to NDVI for highlighting vegetation. It is intended to be sensitive to pixels with high biomass.            |
| Tasseled Cap (Brightness, Greenness, Wetness) | See note below                                                 | Linear combinations of spectral bands that produce bands corresponding to the brightness, greenness, wetness (see note) |

3.6 Create a Multi-Temporal Transform
-------------------------------------

Repeat Step 3.4 for your second image. Now that you have single-date transformations, you can use them to create a multi-temporal transform. Since these indices are used to highlight information in the individual images, differencing them will help highlight areas of change in the images. **Reference Supplementary Tutorial 2 *Methods Classification* for a reminder on using *Raster Calculator* in QGIS.** The suggested *Raster Calculator* syntax is as followed: "transform\_date2@1" - "transform\_date1@1"

Apply a stretch to the resulting file and analyze the results. A large difference value could possibly indicate change between the images. Use the multi-temporal transform image, in addition to the Landsat images, to try and find some clear examples of change. If you are having trouble finding examples of change, try one of the techniques in the optional Subsection 3.6 below.

3.7 OPTIONAL: Advanced Multi-Temporal Transforms:
-------------------------------------------------

*3.7.1 Principal Component Analysis (PCA)*

One slightly more advanced method of data exploration that can be utilized in change detection is Principal Component Analysis (PCA). PCA transforms the data along orthogonal axes of variability in spectral space. In other words, PCA transforms the spectral bands into new variables that are uncorrelated with one another. Since the spectral bands are highly correlated, this can be a way of reducing the amount of variables needed to produce the same amount of information. The Principal Components are ordered so that the first few will contain the most variation from the original variables, while the last few will contain the least.

One way of using PCA for change detection is by performing it on a multi-date image stack. Since areas of change will have low correlation between all the variables (spectral bands) when compared to stable pixels, these changes will be accentuated in the Principal Components. The output of doing so will be a Principal Components image with N number of Components (With N representing the number of bands in the multi-date image stack). The first few will capture the majority of the variation within the bands. Since changed pixels will have the highest variation, these Components will be largest in areas of change.

To perform a PCA, first stack your two Landsat images. **If needed, reference Tutorial 1 *Introduction* for a reminder on how to stack images in QGIS.** Using the stacked output, perform the PCA. **Please reference Subsection 3.3 in Supplementary Tutorial 3 *Methods Change Detection* for directions on how to perform a PCA in QGIS.**

*3.7.2 Multivariate Alteration Detection (MAD)*

Another method for change detection between multiple images is called the Multivariate Alteration Detector. MAD is based on the theory of conical correlation analysis, which when used on remote sensing data seeks to transform the data through linear combinations that maximize correlation between the variables. Each image is transformed into new images with layers representing each canonical variate. The first variate represents the linear combination containing the most correlation in the image, and with subsequent layers containing decreasing correlations. The theory of MAD is that by performing this linear transformation on both images, the difference between the two will accentuate areas of change in the image. **Please reference Subsection 3.4 in Supplementary Tutorial 3 *Methods Change Detection* for directions on how to perform a PCA in QGIS.** Once you have your output map, try looking at the first few layers. Does anything stick out? If there are any unusual areas where you thought it was stable, this could be areas of change.

3.8 Stack your images with your multi-temporal transform
--------------------------------------------------------

To classify change in your images, you are going to use a direct change classification approach. For this, you are classifying your images in a similar fashion to how you classified them in the previous exercise. However, now you are going to include change classes in the classification. For this to work your images must be stacked. Create an image stack with both images in addition to your multi-temporal transform. If you did one of the optional transforms (PCA or MAD), try including that in the stack. Save as “input\_d1d2\_pca\_stack\_subset.tif” to 3\_changedetection/3\_subset”. **If needed, reference Tutorial 1 *Introduction* for a reminder on how to stack images in QGIS.** Note that the transform stack and the Landsat stack most likely have different precisions (“Float32” and “Int16”, respectively). The gdal\_merge program, which we execute to create stacks, allows the user to specify the precision of the stack but this is not an option in the *Merge* menu dialog in QGIS. To specify the precision, click the edit button in the *Merge* dialog (the button with a pencil) and add “-ot Float32” to the expression to store the stack in 32 bit precision.

3.9 Define your ROIs for change classification
----------------------------------------------

Using your input stack to locate areas of change in your image, collect ROIs for the different map classes (including your change class/classes!). You should have ROIs for both the stable and the change classes. The change classes you choose are based upon what you are trying to study. If you are looking for deforestation, find examples of such areas and collect ROIs and label them as “deforestation”. If you want to study urbanization, include that as a change class. Use what you learned in the previous exercise to help guide you in creating appropriate ROIs. **If needed, Reference subsections 2.2 in Supplementary Tutorial 2 *Methods: Classification* for instructions on how to collect ROIs.**

3.10 Classify your change map
-----------------------------

Now that you have collected your ROIs your can classify your change map. Use the same methodology that you performed in the previous exercise (train your classifier and then classify using Random Forests). **Reference subsections 2.4 and 2.5 in Supplementary Tutorial 2 *Methods: Classification* for instructions on classifying your map**. Inspect the results, modify ROIs and input data and redo just as you did when creating the single date land cover map. Your results will only be as accurate as your input data and input ROIs, so repeat until you are happy with the results.
