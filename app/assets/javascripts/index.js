// In the following example, markers appear when the user clicks on the map.
// The markers are stored in an array.
// The user can then click an option to hide, show or delete the markers.
var map;
var markers = [];
var all_markers_json = gon.all_markers_json;
var single_marker_json = gon.single_marker_json

function initMap() {

  if (document.getElementById('main_map')!==null) {
    loadMainMap();
  } else if (document.getElementById('marker_map')!==null) {
    loadSingleMarkerMap();
  };

}

function loadMainMap() {
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

    for(var i in all_markers_json) {
    var values = all_markers_json[i];
    var latLng = new google.maps.LatLng(values.lat, values.lng);
    var content_string = "<h4><b>" + values.title + "</b></h4>" +
                     "<p>" + values.description + "</p>" + 
                     "<a href='/markers/" + values.id + "'>Click Here</a>";
    var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        clickable: true,
    });
    attachMarkerInfo(marker, content_string);
  };

  // This event listener will call addMarker() when the map is clicked.
  map.addListener('click', function(event) {
    addMarker(event.latLng);
  });
}

function loadSingleMarkerMap() {
  console.log(single_marker_json.lat, single_marker_json.lon)
  
  var latLng = new google.maps.LatLng(single_marker_json.lat, single_marker_json.lon);
  
  map = new google.maps.Map(document.getElementById('marker_map'), {
    zoom: 14,
    mapTypeId: google.maps.MapTypeId.STREET,
    center: latLng
  });

  
  var content_string = "<h4><b>" + single_marker_json.title + "</b></h4>" +
                     "<p>" + single_marker_json.description + "</p>";

  var marker = new google.maps.Marker({
      position: latLng,
      map: map,
      clickable: true,
  });
  attachMarkerInfo(marker, content_string);

  // This event listener will call addMarker() when the map is clicked.
  map.addListener('click', function(event) {
    addMarker(event.latLng);
  });
};

// Adds a marker to the map and push to the array.
function addMarker(location) {
  var location = location;
  var marker = new google.maps.Marker({
    position: location,
    title: String(location),
    map: map
  });
  var infowindow = new google.maps.InfoWindow({
        content: '<a href="/markers/new?lat=' + String(location.lat()) + '&lng=' + 
                String(location.lng()) + '" class="button">Drop a buck</a>',
        maxWidth: 200
     });
  // document.getElementById('latitude_field').value = location.lat();
  // document.getElementById('longitude_field').value = location.lng();
  clearMarkers();
  infowindow.open(map, marker);
  markers.push(marker);
  marker.addListener('click', function(location) {
    infowindow.open(map, marker);
  });
}

function attachMarkerInfo(marker, markerInfo) {
  var infowindow = new google.maps.InfoWindow({
    content: markerInfo,
    maxWidth: 200
  });

  marker.addListener('click', function() {
    infowindow.open(marker.get('map'), marker);
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

// window.onload = initMap;
$(document).ready(initMap);
$(document).on('page:load', initMap);