var map;  
App.messages = App.cable.subscriptions.create('SightingsChannel', {  
  received: function(data) {
    console.log(data);
    if (data.sighting.location_id !== null) {
          $.ajax({
            url: "/api/locations/?id=" + data.sighting.location_id,
            async: false
          })
            .done(function (location) {

              data.location = {};

              data.location.lat = location.lat;
              data.location.lng = location.lng;

              $.ajax({
                url: "/api/species?id=" + data.sighting.species_id,
                async: false
              })
              .done(function (species) {
                  data.species = {};
                  data.species.name = species.name;

                  add_species([data.location.lat, data.location.lng], data.species.name, data.sighting.photo_cdn);

                });
            });
        }
  }
});
function initMap() {
  navigator.geolocation.getCurrentPosition(function(location) {
    
    var infowindow = new google.maps.InfoWindow();
    latLng = new google.maps.LatLng(location.coords.latitude, location.coords.longitude);
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 5,
      center: latLng,
      mapTypeId: 'terrain'
    });

    map.data.addListener('click', function(event) {
       infowindow.setContent(event.feature.getProperty('name')+"<br>"+"<br><img src=\""+ event.feature.getProperty('photo') + "\">");
       infowindow.setPosition(event.latLng);
       infowindow.setOptions({pixelOffset: new google.maps.Size(0,-34)});
       infowindow.open(map);
    });
    
    $.ajax({
      url: "/api/sightings",
      async: false
    })
    .done(function(data) {

      data.forEach(function(sighting) {
        if (sighting.location_id !== null) {
          $.ajax({
            url: "/api/locations/?id=" + sighting.location_id,
            async: false
          })
            .done(function (location) {

              sighting.location = {};

              sighting.location.lat = location.lat;
              sighting.location.lng = location.lng;

              $.ajax({
                url: "/api/species?id=" + sighting.species_id,
                async: false
              })
                .done(function (species) {
                  sighting.species = {};
                  sighting.species.name = species.name;

                  add_species([sighting.location.lat, sighting.location.lng], sighting.species.name, sighting.photo_cdn);

                });
            });
        }
      });
    });

    // Create a <script> tag and set the USGS URL as the source.
    // var script = document.createElement('script');

    // // This example uses a local copy of the GeoJSON stored at
    // // http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_week.geojsonp
    // script.src = './test.js';
    // document.getElementsByTagName('head')[0].appendChild(script);

    google.maps.event.addListener(map, 'click', function() {
      infowindow.close();
    });

    map.data.setStyle(function() {
        return {
          icon: getCircle(),
        };
      });
    });
}

function getCircle() {
  return {
    path: google.maps.SymbolPath.CIRCLE,
    fillColor: 'green',
    fillOpacity: .4,
    scale: 16.245,
    strokeColor: 'green',
    strokeWeight: .8
  };
}

function add_species(coordinates, title, photo) {
  var result = {
    "type":"FeatureCollection",
    "features":[{
        "type":"Feature",
        "geometry":{
          "type":"Point",
          "coordinates":[parseInt(coordinates[0]), parseInt(coordinates[1]), 20],
        },
        "properties": {
          "name": title,
          "photo": photo
        }
    }]
  };

  map.data.addGeoJson(result);
}
