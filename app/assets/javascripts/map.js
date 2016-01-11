// In the following example, markers appear when the user clicks on the map.
// The markers are stored in an array.
// The user can then click an option to hide, show or delete the markers.
var map;
var markers = [];

function initMap() {

  map = new google.maps.Map(document.getElementById('main_map'), {
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.STREET
  });

  //recenters map on Geolocation of user if it can find a geolocation
  if (navigator.geolocation) {
     navigator.geolocation.getCurrentPosition(function (position) {
         initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
         map.setCenter(initialLocation);
     });
  }


  var all_markers = gon.all_markers;

  for(var i=0; i<all_markers.length; i++) {
    var latLng = { lat: all_markers[i].lat, lng: all_markers[i].lon };
    var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        title: gon.all_markers[i].marker_title,
        desc: gon.all_markers[i].infowindow
    });
    console.log(marker.desc)
    markers.push(marker);
  };

  // This event listener will call addMarker() when the map is clicked.
  map.addListener('click', function(event) {
    addMarker(event.latLng);
      
  });

  marker.addListener('click', function() {
    var infowindow = new google.maps.InfoWindow({
    content: marker.desc
    });
    infowindow.open(map, marker);
  });

}

// Adds a marker to the map and push to the array.
function addMarker(location) {
  var location = location;
  var marker = new google.maps.Marker({
    position: location,
    title: String(location),
    map: map
  });
  var infowindow = new google.maps.InfoWindow({
      content: document.getElementById('marker_create_form')
     });
  document.getElementById('latitude_field').value = location.lat();
  document.getElementById('longitude_field').value = location.lng();
  clearMarkers();
  infowindow.open(map, marker);
  markers.push(marker);
  marker.addListener('click', function(location) {
    infowindow.open(map, marker);
  });
}

// Sets the map on all markers in the array.
function setMapOnAll(map) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
  setMapOnAll(null);
}

// Shows any markers currently in the array.
function showMarkers() {
  setMapOnAll(map);
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
  clearMarkers();
  markers = [];
}

window.onload = initMap;