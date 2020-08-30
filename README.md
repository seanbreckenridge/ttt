# ttt

Logs metadata for shell commands; an extension to my shell history.

This is essentially a wrapper script to store metadata. The wrapper script `ttt` takes any other command as input, stores some metadata about it in a history file, and then runs the command as normal.

## But Why?

Shell history is nice, but it doesn't provide me context; e.g. what directory was this command run in?

Additionally, not all commands are saved in shell history. If you have some keybinding to launch a script/application, or force-quit the terminal without exiting, your commands don't get saved in your shell history.

This gives me finer control on what gets logged, so I can analysis on it later from [`HPI`](https://github.com/seanbreckenridge/HPI).

One could also just use this to log generic events. `ttt_log` just saves whatever arguments you pass it with some metadata about where/when, so could be used to track habits/my behaviour like:

```
#!/bin/sh

# every minute, if I'm watching something, save what movie/music I'm listening to
# using my https://github.com/seanbreckenridge/mpv-sockets script

while true; do
  if MEDIA_PATH="$(mpv-currently-playing)"; do
    ttt_log "mpv_playing_media:$MEDIA_PATH"
  fi
  sleep 60
done
```

## How?

This consists of:
  - `ttt` (the wrapper shell script)
  - `ttt_log` (log metadata to the history file)

The point here is to be transparent. So, at the top of any script which I want to log, I add the line:

```
command -v ttt >/dev/null 2>&1 && ttt_log "$@"
```

If I'm launching the command with a keybinding or from another program that accepts a command as input (e.g. [`rifle`](https://github.com/ranger/ranger) (my file manager) or from my [`window manager`](https://i3wm.org/), I'd modify the line like:

```
# launch firefox
bindsym $mod+f exec firefox-developer-edition
```

... to ...

```
bindsym $mod+f exec ttt firefox-developer-edition
```

That *does* mean that the command would fail if `ttt` isn't installed, but I'm willing to live with that.

## Install

Copy `ttt` onto your path, and `go get` `ttt_log`.

```
```

You can change which file `ttt_log` writes to by setting the `TTT_HISTFILE` environment variable.

