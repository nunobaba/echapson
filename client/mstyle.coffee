Session.set "map.style", 
  map: [
      featureType: "water"
      elementType: "all"
      stylers: [
        hue: "#888888"
      ,
        saturation: -100
      ,
        lightness: -30
      ,
        visibility: "on"
      ]
    ,
      featureType: "landscape"
      elementType: "all"
      stylers: [
        hue: "#666666"
      ,
        saturation: -100
      ,
        lightness: -55
      ,
        visibility: "on"
      ]
    ,
      featureType: "administrative.province"
      elementType: "all"
      stylers: [
        hue: "#444444"
      ,
        saturation: 0
      ,
        lightness: -48
      ,
        visibility: "off"
      ]
    ,
      featureType: "road"
      elementType: "all"
      stylers: [
        hue: "#444444"
      ,
        saturation: -100
      ,
        lightness: -58
      ,
        visibility: "off"
      ]
    ,
      featureType: "poi"
      elementType: "all"
      stylers: [
        hue: "#444444"
      ,
        saturation: -100
      ,
        lightness: -66
      ,
        visibility: "off"
      ]
    ,
      featureType: "transit"
      elementType: "all"
      stylers: [
        hue: "#444444"
      ,
        saturation: 0
      ,
        lightness: -64
      ,
        visibility: "off"
      ]
    ,
      featureType: "administrative.neighborhood"
      elementType: "all"
      stylers: [
        hue: "#444444"
      ,
        saturation: 0
      ,
        lightness: -48
      ,
        visibility: "off"
      ]
    ,
      featureType: "administrative.locality"
      elementType: "all"
      stylers: [
        hue: "#444444"
      ,
        saturation: 0
      ,
        lightness: 27
      ,
        visibility: "on"
      ]
    ,
      featureType: "administrative.land_parcel"
      elementType: "all"
      stylers: [
        hue: "#444444"
      ,
        saturation: 0
      ,
        lightness: -48
      ,
        visibility: "off"
      ]
    ,
      featureType: "administrative.country"
      elementType: "labels"
      stylers: [
        hue: "#444444"
      ,
        saturation: 0
      ,
        lightness: -48
      ,
        visibility: "off"
      ]
    ,
      featureType: "administrative.country"
      elementType: "geometry"
      stylers: [
        hue: "#444444"
      ,
        saturation: 0
      ,
        lightness: -48
      ,
        visibility: "on"
      ]
    ,
      featureType: "administrative"
      elementType: "geometry"
      stylers: [
        hue: "#444444"
      ,
        saturation: 0
      ,
        lightness: -48
      ,
        visibility: "off"
      ]
    ,
      featureType: "administrative"
      elementType: "labels"
      stylers: [
        hue: "#444444"
      ,
        saturation: 0
      ,
        lightness: -48
      ,
        visibility: "simplified"
      ]
    ]

  marker:
    reg:
      # The google.maps.SymbolPath.CIRCLE is a constant property
      # of an enum, of value 0. This enables us to create the 
      # parameter object without requiring the google.maps library:
      path: 0
      fillColor: "#B8DC3C"
      fillOpacity: 1
      scale: 3
      strokeColor: "#B8DC3C"
      strokeOpacity: .4
      strokeWeight: 8

  polyline:
    reg:
      strokeColor: "#B8DC3C"
      strokeOpacity: 1.0
      strokeWeight: 1.5

