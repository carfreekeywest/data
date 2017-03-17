datadir = data
bbox = 24.539394,-81.822309,24.600046,-81.723003

clean_osm:
	rm -rf $(datadir)/osmlines.*

osm_bikelanes: clean_osm
	mkdir -p $(datadir)
	@echo "Downloading OSM data..."
	@echo "Heads up: you need to have osmtogeojson installed for this part: https://github.com/tyrasd/osmtogeojson"
	wget -O $(datadir)/osmlines.json "http://overpass-api.de/api/interpreter?data=[out:json]; ( way[bicycle][bicycle!=no]($(bbox)); way[~\"cycleway\"~\".*\"]($(bbox)); way[highway=cycleway]($(bbox));); out body; >; out skel qt;"
	osmtogeojson $(datadir)/osmlines.json > $(datadir)/osmlines.geojson
     
	@echo "Deleting original files"
	rm $(datadir)/osmlines.json
