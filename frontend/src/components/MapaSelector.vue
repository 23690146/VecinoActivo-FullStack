<template>
  <div id="map" style="height: 400px;"></div>
</template>

<script setup>
import { onMounted } from 'vue'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'

const emit = defineEmits(['ubicacion'])

onMounted(() => {
  const map = L.map('map').setView([21.9833, -99.0167], 14) // Ciudad Valles
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap'
  }).addTo(map)

  map.on('click', (e) => {
    const { lat, lng } = e.latlng
    emit('ubicacion', { lat, lng })
    L.marker([lat, lng]).addTo(map)
  })
})
</script>