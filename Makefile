EMULATOR=mgba-qt

clean:
	rm build/*
	rm tiles/*

tiles/snake.bin: 
	rgbgfx img/snake.png -o tiles/snake.bin

tiles/fruit.bin: 
	rgbgfx img/fruit.png -o tiles/fruit.bin

tiles: tiles/fruit.bin tiles/snake.bin

rom: tiles
	./run.sh

run: rom
	$(EMULATOR) build/main.gb
