***Pontus Olofsson, Christopher E. Holden, Eric L. Bullock***![](media/image17.png)![](media/image19.gif)

*Boston Education in Earth Observation Data Analysis/*

*Department of Earth & Environment, Boston University*

**S3. Methods: Change Detection**

S3.1 Applying a matching stretch
--------------------------------

1.  Pick a stretch that you like (one suggestion would be 5-4-3, with min and max values ranging from 0-8000). Apply this stretch to one of the images.

2.  Right click on the image name under *Layers* and go to *Styles &gt; Copy Style*.

> ![](media/image14.png)

1.  To apply this matching stretch to your other image, right click on the second image and go to *Styles &gt; Paste Style*.

S3.2 Perform a single-date transformation
-----------------------------------------

1.  Open up the *Raster Calculator* in QGIS. This is located in *Raster &gt; Raster Calculator.* This tool allows you to perform calculations on the pixel values of raster files.

2.  Under *Raster bands* you will see a list containing each band of each raster file you have opened in your *Layers*. The listing that ends in ‘\_B@1’ corresponds to band 1 of the corresponding file, ‘\_B@2’ is band 2, and so on.

3.  Using the equation from one of the transformations, write the expression under *Raster calculator expression*. Instead of typing in each band name, clicking the band name under *Raster bands* will automatically fill it into the *expression* box.

4.  Put an appropriate name in “3\_changedetection/3\_subset” for the file in *Output layer*, and leave the rest of the boxes as they are. Your *Raster calculator* box should look something like this expression, which is calculating NDVI:

> ![](media/image13.png)

1.  To perform the calculation, click *OK*.

2.  The output file is a transformation for one of your images. If you’d like, stretch the transform image appropriately and compare it to one of your Landsat images.

    1.  To apply a single-band transformation right click on the file and go to *Properties &gt; Style* and under *Render type* select *Singleband pseudocolor.*

    2.  Under *Generate new color map* select a color scheme you are happy with, and click *Load* to load appropriate min and max values.

    3.  Click *Classify* to apply the color stretch to the single-band image.

    4.  Click *OK* and the color scheme and stretch should be applied to your transform.

3.  Switch back and forth between your transform and your Landsat image. How do the transformed values relate to your different land classes?

S3.3 Principal Component Analysis
---------------------------------

1.  Open the multi-date image stack and apply a 3-band stretch on the image.

2.  To open the PCA toolbox return to the *Processing Toolbox*. Go to *Orfeo Toolbox &gt; Image Filtering &gt; DimensionalityReduction (pca)* (see screenshot below)

![](media/image16.png)

1.  For the *Input Image* select your multi-image stack. Uncheck the box that says *Normalize*. This function normalizes the variance of the different variables. This is useful if your variables are in different units (meters and grams). For *Output Image* select an appropriate name and save to “3\_changedetection/3\_subset”. You can also uncheck the box to open the *Inverse Output Image*. That is not necessary for change detection. The number of components depends on the number of input features but for a multitemporal stack of 12 bands, 6-8 components are recommended. Click *Run.*

2.  The resulting image has several principal components (6-8 in this case). The first layer represents the value for each pixel along the first principal component axis of variability. Often, this represents the overall variation in reflectance in the image. The next few components (next few bands) might be where the change is noticeable.

3.  Try to find an area of change and display the different PCs individually to see if any of them capture the change (right click the PCA stack in *Layers* panel &gt; *Properties* &gt; *Style* &gt; *Singleband gray*; change *Band 1 (gray*) and set *Contrast Enhancement* to *Stretch to MinMax*). Does anything stick out to you? Look at areas that you assume to be stable; do any patches present themselves in any of the PC layers? In my example, PCs 4, 5 and 6 turned out to be useful for change detection. Here is an example of areas of deforestation in the second PC (red):

> ![](media/image15.png)

S3.4 Multivariate Alteration Detection
--------------------------------------

1.  Open both of your 8-band Landsat image subsets in QGIS.

2.  <span id="h.dqt9aad5c18z" class="anchor"></span>In the *Processing Toolbox* go to *Orfeo toolbox &gt; Feature Extraction &gt; Multivariate alteration detector*.

3.  For *Input Image 1* select either of your images. For *Input Image 2* select the other image.

4.  For *Change Map* select an appropriate name and location (/4\_Change/MAD\_ChangeMap.tif would work).

5.  Click *Run*

6.  Areas of change should be visible in the first few bands. Try applying a single-band stretch to band one of the output image. Below you will see a Landsat image before a fire (left), after the fire (center), and band 1 of the output MAD image (right).

> *.*

![](media/image07.png)![](media/image12.png)![](media/image11.png)
