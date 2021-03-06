# Chutes and Ladders
Chutes and Ladders simulator in Ruby that outputs a histogram of turns it takes to win.

Multithreaded speedup supported with ```--threads N``` option in JRuby or Rubinius. The standard MRI you will so no speedup with multiple threads due to the Global Interpreter Lock (GIL).

Just run ```ruby chutes_and_ladders.rb```

```
ruby chutes_and_ladders.rb --help
Usage: chutes_and_ladders.rb [options]
    -g, --games GAMES                Number of games to simulate [1000000]
    -t, --threads THREADS            Number of Threads to use [1]
        --max-turns TURNS            Max number of turns to let a game go for [150]
    -h, --help                       Show this message
```

## Credits

Ethan Markowitz and his article analyzing chutes and ladder: http://ethanmarkowitz.com/index.php/2015/05/24/hacking-chutes-and-ladders-using-r/
