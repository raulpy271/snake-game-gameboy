EMULATOR=mgba-qt

tiles: tiles/fruit.bin tiles/snake.bin

tiles/snake.bin: img/snake.png
	rgbgfx $^ -o $@

tiles/fruit.bin: img/fruit.png
	rgbgfx $^ -o $@

clean:
	rm build/*
	rm tiles/*

rom: tiles
	rgbasm -L -o build/main.o src/main.asm
	rgblink -o build/main.gb build/main.o
	rgbfix -v -p 0xFF build/main.gb

run: rom
	$(EMULATOR) build/main.gb
