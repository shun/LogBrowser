var map;
var marker;

function initialize() {
  var latlng = new google.maps.LatLng(43.037234, 141.499349);
  var opts = {
    zoom: 13,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map_canvas"), opts);
  marker = null;
}

function setposition(lat, lng) {
    var latlng = new google.maps.LatLng(lat,lng);
    var opts = {
      zoom: 13,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map_canvas"), opts);
}

function setmaker(lat, lng) {
    var latlng = new google.maps.LatLng(lat,lng);
	map.panTo(new google.maps.LatLng(lat, lng));

	var mopts1 = {
		position: latlng,
		map: map
	};

	if (marker == null) {
		marker = new google.maps.Marker(mopts1);
	}
	else {
		var mopts2 = {
			position: latlng,
			map: map
		};
		marker.setOptions(mopts2);
	}
}

function drawline(orgcoords) {
	//線(Polyline)のインスタンスを格納する配列
    var latlng;
	var polylines = [] ;
	var array = [ ];
	
	var coordslist = orgcoords.split("\n");
	var coords = coordslist[0].split(",");

	for (var i = 0; i < coordslist.length; i++) {
		coords = coordslist[i].split(",");
		latlng = new google.maps.LatLng(parseFloat(coords[0]), parseFloat(coords[1]));
		array.push(latlng);
	}

	var paths = new google.maps.Polyline({
		path: array,
		geodesic: false,
		strokeColor: '#FF0000',
		strokeOpacity: 1.0,
		strokeWeight: 2
	});

  paths.setMap(map);
}

function drawcircle(orgitems) {
	var itemlist = orgitems.split("\n");
	var items = [];

	for (var i = 0; i < itemlist.length; i++) {
		items = itemlist[i].split(",");
		latlng = new google.maps.LatLng(parseFloat(items[0]), parseFloat(items[1]));

		var opts = {
		      strokeColor: '#FF0000',
		      strokeOpacity: 0.8,
		      strokeWeight: 2,
		      fillOpacity: 0.0,
		      map: map,
		      center: latlng,
		      radius: parseFloat(items[2])
		    };
		new google.maps.Circle(opts);
	}

}
