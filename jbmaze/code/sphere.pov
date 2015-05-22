#version 3.7;
#include "colors.inc"

background { color White }

camera {
  location <0,0,-2.5>
  look_at  <0,0,0>
}

light_source {
  <-50, 50, -50>
  color White
}

sphere {
  <0,0,0>, 1
  texture {
    pigment {
      image_map {
        png "sphere-map.png"
        map_type 1
      }
    }
    finish { ambient 0.3 diffuse 0.5 specular 0.2 }
  }

  rotate z*30
  rotate -x*30
}
