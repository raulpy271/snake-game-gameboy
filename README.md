# snake-game-gameboy

An snake game written to run in gameboy console.

![Game Running](/assets/example.gif)

# Usage

To execute in your machine, you can use our pre-genereted ROM in your favorite emulator or you can create the ROM for yourself. 

If you only want to use a pre-genereted, use this [link](https://github.com/raulpy271/snake-game-gameboy/raw/main/build/main.gb) to download the ROM and go to section [Related](README.md#Related) to see recomended emulators.

If you want to create the rom, install the tools of [rgbds](https://rgbds.gbdev.io/), after it, you can type the following:

```
make rom
```

This will create the ROM file in `build` directory. And you can emulate the game using:

```
make run EMULATOR=mgba-qt
```

This will execute the emulator and pass the path of the rom. Like this `mgba-qt build/game.gb`. You can set then `EMULATOR` variable to other value, based of your favorite emulator.

# Related

- [mGBA - Emulator](https://mgba.io/)
- [Higan - Emulator](https://higan-emu.com/)
- [gbdev community - Gameboy Documentation](https://gbdev.io/)
