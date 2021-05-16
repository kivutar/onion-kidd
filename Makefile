OnionKidd.lutro:
	zip -9 -r OnionKidd.lutro ./*

OnionKidd.js:
	python3 ~/emsdk/upstream/emscripten/tools/file_packager.py OnionKidd.data --preload . --js-output=OnionKidd.js

clean:
	@$(RM) -f OnionKidd.*

.PHONY: all clean
