/*

OPEN STREETS
============

A TileMill map style for OpenStreetMap. For PostGIS databases created 
by osm2pgsql with a default style file, or style that is compatible 
with the default.

Use the included `configure.py` script to customize your database and
extent settings. See the README for more info.

<http://github.com/mapbox/open-streets-style>

*/

/* ---- PALETTE ---- */

@water:     #c0d8ff;
@land:      #f4f6f0;
@forest:    #c7e6a8;
@agriculture:#f4f0e0;
@grass:     lighten(@forest,5);
@park:      lighten(@forest,10);
@beach:     #ffeec7;
@building:  darken(#e8e4e4,8);

/* ---- NATURAL & LANDUSE ---- */

Map { background-color: @water; }

#world[zoom<6],
#shoreline_300[zoom>=6][zoom<10],
#processed_p[zoom>=10] {
  polygon-fill: @land;
}

.water[zoom>6] {
  polygon-fill:@water;
  polygon-gamma:0.8;
}
.water-outline[zoom>11] {
  line-color:darken(@water,10);
  [zoom=12] { line-width:0.8; }
  [zoom=13] { line-width:1.2; }
  [zoom=14] { line-width:1.4; }
  [zoom=15] { line-width:1.6; }
  [zoom=16] { line-width:1.8; }
  [zoom>16] { line-width:2; }
}

.forest[zoom>7] {
  /* At lower zoom levels forests are dense and distracting. 
     Ramp them in gradually. */
  [zoom=8] { polygon-fill:lighten(@forest,16); }
  [zoom=9] { polygon-fill:lighten(@forest,12); }
  [zoom=10]{ polygon-fill:lighten(@forest,8); }
  [zoom=11]{ polygon-fill:lighten(@forest,4); }
  [zoom>11] { polygon-fill:@forest; }
  /* These outlines create a slight faux-blur effect. */
  [zoom>14] {
    line-color:@forest;
    line-opacity:0.4;
    line-join:round; }
  [zoom=15] { line-width:1.6; }
  [zoom=16] { line-width:2.6; }
  [zoom=17] { line-width:3.6; }
  [zoom>=18] { line-width:4.6; }
  /* a second outline for addtional blur */
  ::xtra {
    [zoom>16] {
      line-color:@forest;
      line-opacity:0.2;
      line-join:round; }
    [zoom=17] { line-width:7; }
    [zoom>=18] { line-width:9; }
  }
}

.agriculture[zoom>9] {
  polygon-fill:@agriculture;
}

.beach[zoom>9] {
  polygon-fill:@beach;
}

.grass[zoom>9] {
  polygon-fill:@grass;
}

.park[zoom>9] {
  polygon-fill:@park;
  [zoom>13] { line-color:darken(@park,20); }
  [zoom=14] { line-width:0.6; }
  [zoom=15] { line-width:0.8; }
  [zoom>15] { line-width:1.2; }
}

/* ---- CAMPUSES ---- */
/* Note that amenity=school, amenity=hospital, etc are ideally polygons of the
   *campus*, but are occasionally applied to the physical building instead. */
@campus: #ECF;
.campus[zoom>9] {
  polygon-opacity:0.2;
  line-opacity:0.4;
  polygon-fill:@campus;
  line-color:spin(darken(@campus,20),20);
  [zoom=10] { line-width:0.2; }
  [zoom=11] { line-width:0.3; }
  [zoom=12] { line-width:0.4; }
  [zoom=13] { line-width:0.5; }
  [zoom=14] { line-width:0.6; }
  [zoom=15] { line-width:0.7; }
  [zoom=16] { line-width:0.8; }
  [zoom=17] { line-width:0.9; }
  [zoom=18] { line-width:1.0; }
}

/* ---- BUILDINGS ---- */
/* Transparent buildings account for situations where routes go
   in or under them */
.building[zoom>10][zoom<17] {
  polygon-fill:@building,8;
  [zoom=11] { polygon-opacity:0.1; }
  [zoom=12] { polygon-opacity:0.2; }
  [zoom=13] { polygon-opacity:0.3; }
  [zoom>13] {
    polygon-opacity:0.4;
    line-color:darken(@building,5);
    line-width:0.2;
  }
  [zoom>15] {
    line-color:darken(@building,10);
    line-width:0.4;
  }
}
.building[zoom>=17] {
  building-fill:lighten(@building,4);
  building-fill-opacity: 0.8;
  building-height:1.2;
}