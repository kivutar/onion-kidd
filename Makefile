Onion\ Kidd.lutro:
	zip -9 -r Onion\ Kidd.lutro ./*

Onion\ Kidd.js:
	python3 ~/emsdk/upstream/emscripten/tools/file_packager.py Onion\ Kidd.data --preload . --js-output=Onion\ Kidd.js

clean:
	@$(RM) -f Onion\ Kidd.*

.PHONY: all clean
