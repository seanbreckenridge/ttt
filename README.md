# ttt

Logs metadata for shell scripts/invocations; an extension to my shell history.

This is essentially a wrapper script to store metadata. The wrapper script `ttt` takes any other command as input, stores some metadata about it in a history file, and then runs the command as normal. Its quite literally:

```
#!/bin/sh
tttlog "$@"
exec "$@"
```

## But Why?

Shell history is nice, but it doesn't provide me context; like what directory was this command run in?

Additionally, not all commands are saved in shell history. If you have some keybinding to launch a script/application, or force-quit the terminal without exiting, your commands don't get saved in your shell history.

This gives me finer control on what gets logged, so I can do analysis on it later from [`HPI`](https://github.com/seanbreckenridge/HPI#readme).

## How?

This consists of:
  - `ttt` (the wrapper shell script)
  - `tttlog` (log metadata to the history file)

The point here is to be transparent and easy to add. So, at the top of any script which I want to log, I add the line:

```
command -v tttlog >/dev/null 2>&1 && tttlog "$(basename "$0") $@"
```

If I'm launching the command with a keybinding or from another program that accepts a command as input (e.g. [`rifle`](https://github.com/ranger/ranger) (my file manager) or from my [`window manager`](https://i3wm.org/), I'd modify the line from:

```
# launch firefox
bindsym $mod+f exec firefox-developer-edition
```

... to ...

```
bindsym $mod+f exec ttt firefox-developer-edition
```

That *does* mean that the command would fail if `ttt` isn't installed, but I'm willing to live with that.

If this can't find the current working directory (i.e. if you deleted the current directory and called it from there), it sets `-`, which signifies an error.

I recommend you symlink `#!/bin/sh` to something faster than `bash`, like `dash`, to improve startup times. See [`here`](https://wiki.archlinux.org/index.php/Dash) for more info.

An example of what this logs to the CSV file:

```
1599523020,/home/sean/Repos/ttt,fzf-cd /home/sean/Repos/ttt
1599523021,/home/sean/Repos/ttt,nvim ./tttlog.go
1599523446,/home/sean,alacritty
1599523626,/home/sean,keepassxc
```

One could also just use this to log generic events. `tttlog` just saves whatever arguments you pass it with some metadata about where/when, so could be used to track habits/my behaviour like:

```
#!/bin/sh

# every minute, if I'm watching something, save what movie/music I'm listening to
# using my https://github.com/seanbreckenridge/mpv-sockets script

while true; do
  if MEDIA_PATH="$(mpv-currently-playing)"; do
    tttlog "mpv_playing_media:$MEDIA_PATH"
  fi
  sleep 60
done
```

For examples of where this is used in my [dotfiles](https://github.com/seanbreckenridge/dotfiles/), see [here](https://gist.github.com/seanbreckenridge/996126c45a4b3ed10941c7f190ac0605).

## Install

Requires `go`

```bash
git clone "https://github.com/seanbreckenridge/ttt" && cd ./ttt
make
```

You could also just download `ttt` onto your `$PATH`, and `wget`/`go install` `tttlog.go` manually.

You can change which file `tttlog` writes to by setting the `TTT_HISTFILE` environment variable. The default location is `${XDG_DATA_HOME:-$HOME/.local/share}/ttt_history.csv`

### Tests

```bash
cd test
./test
```

### Benchmarks

Just to have some numbers here, the overhead that `ttt` (wrapper shell script running `tttlog`) causes is about `3ms`

```
Benchmark #1: /bin/sh
  Time (mean ± σ):       0.6 ms ±   0.3 ms    [User: 0.5 ms, System: 0.4 ms]
  Range (min … max):     0.0 ms …   1.5 ms    1621 runs

Benchmark #2: printf hi >/dev/null
  Time (mean ± σ):       0.1 ms ±   0.1 ms    [User: 0.2 ms, System: 0.2 ms]
  Range (min … max):     0.0 ms …   1.3 ms    1935 runs

Benchmark #3: /home/sean/Repos/ttt/test/../ttt printf hi >/dev/null
  Time (mean ± σ):       3.8 ms ±   0.7 ms    [User: 2.3 ms, System: 2.3 ms]
  Range (min … max):     2.3 ms …   5.8 ms    522 runs
```

#### ttt?

Naming things relating to shell history/logging is hard...

I just wanted something that would be easy to type, so I can add it to wherever I want quickly. Is just the first thing that came to mind, when I was trying to figure out how to track rifle/i3 bindsyms; 'track the things'

