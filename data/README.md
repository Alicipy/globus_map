# Origin of files

## [DE_VG5000.gpkg](external/DE_VG5000.gpkg)

The file is not checked in, as it quite huge (18MB).

© GeoBasis-DE / BKG (2024)
This is the extracted file of
[Verwaltungsgebiete 1:5 000 000, Stand 31.12. (VG5000 31.12.)](https://gdz.bkg.bund.de/index.php/default/digitale-geodaten/verwaltungsgebiete/verwaltungsgebiete-1-5-000-000-stand-31-12-vg5000-12-31.html),
which is free to use. The file is not changed in any way.

## [globus_info.csv](processed/globus_info.csv)

I copied [the market selection](https://www.globus.de/maerkte.php) with Strg+C/V into a text file.
Then, I manipulated the pure text with ``vim`` macros to only contain name and region.

Afterwards, I used [nominatim](https://nominatim.openstreetmap.org/) by OpenStreetMap to search for each
market (by hand), and copied latitude and longitude of the supermarkets.
