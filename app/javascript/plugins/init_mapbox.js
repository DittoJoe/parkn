import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/dittojoe/ckp5bqvej0xlt18lrqh6k0g52/'
    });
    const markers = JSON.parse(mapElement.dataset.markers);
      markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window);
        new mapboxgl.Marker({ "color": "#c44536" })
          .setLngLat([ marker.lng, marker.lat ])
          .setPopup(popup)
          .addTo(map);
          if (markers.length > 1) {
            fitMapToMarkers(map, markers);
          } else {
            map.flyTo({center: [ marker.lng, marker.lat ], zoom: 14})
          }
    });
  }
};

export { initMapbox };

