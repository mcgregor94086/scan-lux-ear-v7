## Summary

## Locator / Maps Checklist
- [ ] `v7/index.html` has **exactly one** Google Maps loader
- [ ] Loader **does not** include `callback=initMap`
- [ ] Loader tag includes `data-lock="LuxEarMapsLoader"`
- [ ] `<script type="module" src="app/main.js">` present
- [ ] `<script type="module" src="app/map-init.js">` present
- [ ] Map init handled by `app/map-init.js` (polls `window.google.maps`)
- [ ] `scripts/verify-maps-loader.sh` passes locally
