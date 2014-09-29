initializeMap = ->
	mapOptions =
		center: new google.maps.LatLng(43.7, -79.4)
		zoom: 11
	new google.maps.Map document.getElementById("map-canvas"), mapOptions


addMarker = (map, x, y, text) -> 
	new google.maps.Marker
    	position: new google.maps.LatLng(x, y)
    	map: map
    	title: text

withData = (callback) -> 
	$.getJSON '/data/water.json', callback


convert = (x, y) -> 
	sourceProj = "+proj=tmerc +lat_0=0 +lon_0=-79.5 +k=0.9999 +x_0=304800 +y_0=0 +ellps=clrk66 +units=m +no_defs"
	destProj = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
	proj4 sourceProj, destProj, [x, y]


@run = -> 
	map = initializeMap()
	$('#play').on 'click', ->
		withData (data) -> 
			index = 0
			handle = null
			tick = -> 
				if index == 10 
					clearInterval handle if handle?
					return
				datum = data[index++]
				[lat, lon] = convert parseFloat(datum.x), parseFloat(datum.y)
				addMarker map, lon, lat, datum.date
			handle = setInterval tick, 500
