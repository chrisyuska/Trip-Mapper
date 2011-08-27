var infowindow = null;
  var markers = [];

  window.onload = function() {
    //initialize map
    var latlng = new google.maps.LatLng(json[0].lat, json[0].lng);
    var myOptions = {
      zoom: 6,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      mapTypeControl: true
    };
    var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

    // draw flight path
    var pathCoords = [];
    for (var i=json.length-1;i>=0;i--) {
      pathCoords.push(new google.maps.LatLng(json[i].lat, json[i].lng));
    }
    var flightPath = new google.maps.Polyline({
      path: pathCoords,
      strokeColor: "#FF0000",
      strokeOpacity: 1.0,
      strokeWeight: 2
    });
    flightPath.setMap(map);

    // initialize infowindow
    var infowindow = new google.maps.InfoWindow({
      content: "initialized..."
    });

    // finally, let's guess where we're located right now
    var now = new Date();
    i = 0;
    //first, let's find out where we haven't left yet
    while (i < json.length && now > new Date(json[i].departure)) {
      i++;
    }
    if (i == json.length) {
      //trip is over, place marker at end location
      addCityMarker(i-1, map, infowindow);
    } else if (now > new Date(json[i].arrival) || i == 0) {
      //means we're in a city, place marker in city
      addCityMarker(i, map, infowindow);
    } else {
      //we must be traveling
      addTravelMarker(i, map, infowindow);
    }
  }

  function addCityMarker(i, map, infowindow) {
    var html = "<h1>" + json[i].location + "</h1>";
    if (i > 0) {
      html += "<p><b>Arrived at:</b> " + new Date(json[i].arrival) + "</p>";
    }
    if (i < json.length - 1) {
      html +=  "<p><b>Departing at:</b> " + new Date(json[i].departure) + "</p>";
    }
    if (json[i].description.length > 0) {
      html+= "<h3>Stop Details:</h3><p>" + json[i].description + "</p>";
    }

    latLng = new google.maps.LatLng(json[i].lat, json[i].lng);

    addMarkerAndListener(map, latLng, html, infowindow);
  }

  function addTravelMarker(i, map, infowindow) {
    var html = "<h1>Traveling to " + json[i].location + "</h1>";
    if (i > 0) {
      html += "<p><b>Departed at:</b> " + new Date(json[i-1].departure) + "</p>";
    }
    if (i < json.length - 1) {
      html +=  "<p><b>Arriving at:</b> " + new Date(json[i].arrival) + "</p>";
    }
    if (json[i].travel_info.length > 0) {
      html += "<h3>Travel Details:</h3><p>" + json[i].travel_info + "</p>";
    }

    var now = new Date();
    // ratio is to calculate travel distance (linear estimate of time/distance)
    var ratio = (now.getTime() - Date.parse(json[i-1].departure))/(Date.parse(json[i].arrival) - Date.parse(json[i-1].departure));

    //calculate rough location
    var lat, lng;
    if (json[i].lat != 0 || json[i-1].lat != 0) {
      lat = (json[i].lat - json[i-1].lat)*ratio + json[i-1].lat;
    } else {
      lat = 0;
    }
    if (json[i].lng != 0 || json[i-1].lng != 0) {
      lng = (json[i].lng - json[i-1].lng)*ratio + json[i-1].lng;
    } else {
      lng = 0;
    }

    var latLng = new google.maps.LatLng(lat, lng);

    addMarkerAndListener(map, latLng, html, infowindow);
  }

  function addMarkerAndListener(map, latLng, html, infowindow) {
    map.setCenter(latLng);

    var marker = new google.maps.Marker({
      animation: google.maps.Animation.DROP,
      position: latLng,
      map: map,
      html: html,
      title: "Here we are!",
      icon: "http://chart.apis.google.com/chart?chst=d_map_pin_icon&chld=location|563FFF"
    });

    // add event listener to marker on map
    google.maps.event.addListener(marker, 'click', function() {
      infowindow.setContent(this.html);
      infowindow.open(map,this);
    });
  }

