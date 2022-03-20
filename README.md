# snake-game-gameboy
An snake game written to run in gameboy console

# Execution

To create the rom you should type:

```
make rom
```

And you can emulate the game using:

```
make run EMULATOR=mgba-qt
```

This will execute the emulator and pass the path of the rom. Like this `gmba-qt build/game.gb`. You can set then `EMULATOR` variable to other value, based of your favorite emulator.

