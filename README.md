# Ember to Ocean

**NASA Space Apps 2026.** A single-page, white "lab report" site that follows one chain across three whole
countries, 2012–2025: **wildfire → air quality (AOD) → water condition → salmon fishery money**, for Canada,
the United States (incl. Alaska) and Russia, with one case-study basin each (Fraser, Yukon–Kuskokwim, Amur)
where satellite water measurements make the full chain testable.

Plain JavaScript ES modules, no build step, three CDN libraries (MapLibre GL 5, maplibre-contour 0.1.0,
Observable Plot 0.6). Runs from any static server and from **GitHub Pages** as is.

## Run it

- **Windows:** double-click `START-HERE.cmd`. It starts a local server and opens the site in your browser. Node.js 18 or later must be installed.
- **Other platforms:** run `node serve-local.mjs` from this folder, then open http://127.0.0.1:4173.

- **GitHub Pages:** push to `main`; `.github/workflows/deploy-pages.yml` publishes the interface automatically. The full source data remains in the public repository and is fetched from its raw-content URLs, keeping the Pages artifact below GitHub's 1 GB published-site limit.
- **Published site:** https://hasanahmad211a.github.io/Correction-VR/

## What is on the page

Header (country tabs, *Whole country / Case study* toggle) · year slider with play and fire-year markers ·
map (globe with 0.5° fire cells, smoke haze, rivers that turn purple near fires, clickable orange case-study
outline; basin view with 2.5D terrain, contours, 0.1° fires and the water measurement box) · infobox with
sparklines · Fig. 1 trend (Mann-Kendall + Sen slope) · Fig. 2 before/after a fire year (Welch, Mann-Whitney,
Cohen's d) · Fig. 3 the chain (Spearman lag links) · Methods / Data / Statistics / Caveats / Team / Credits.

## Adding Your CSV Data

All mock datasets have been removed. You can **copy-paste an entire yearly CSV folder** (like `USA_forest_fires_final` or `csv_by_year` containing `USA_VIIRS_2012.csv`, `USA_MODIS_2015.csv`, etc.) straight into:

- **`data/`** (e.g. `data/USA_forest_fires_final/csv_by_year/...`), or
- **`data/<country>/`** (`data/canada/`, `data/usa/`, `data/russia/`), or
- **`data/<country>/<basin>/`** (`data/canada/fraser/`, `data/usa/yukon/`, `data/russia/amur/`).

The app scans `data/` automatically on dev & build (`/data/manifest.json`), picks `VIIRS` per year (falling back to `MODIS` when `VIIRS` is absent), streams 20–60+ MB CSVs without blocking the UI, and clips country CSVs automatically to case-study basins when dedicated basin files aren't provided.

For air and time-series metrics in each scope folder (`data/<scope>/`):
- `air.csv` — `latitude,longitude,year,aod,pm25`
- `series.csv` — `variable,date,value,water_body` (`date` as `YYYY-MM` or `YYYY`)

## Layout

```
index.html  css/tokens.css  css/layout.css  js/main.js      app shell (slots, tokens, 5-row grid)
js/store.js  js/data-config.js  js/data.js  js/theme.js     state store, CSV/GeoJSON loader, colours
js/ui/header.js  slider.js  infobox.js                      header tabs + toggle, year slider, infobox
js/charts/fig1-trend.js  fig2-before-after.js  fig3-chain.js figures (Plot, Plot, hand-built SVG)
js/map/map.js  fires.js  water.js  air.js  legend.js         MapLibre map and layers
data/regions.json  data/<scope>/{geo,rivers}.geojson  {fires,air,series}.csv
pipeline/                                                   optional Python preprocessing P0–P7
```


