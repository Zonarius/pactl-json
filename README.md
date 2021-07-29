# pactl-json

# Description
Aims to be `pactl` but with JSON output.

# Rationale
3 reasons for making this:
* I want to create an app similar to [Volume2](https://github.com/irzyxa/Volume2). The main feature I'm using is to control the volume of certain applications with a global hotkey.
* I don't want to parse `pactl` output.
* I wanted to try and experiment with D and libpulse.

# Running Requirements
* `libpulse`

# Building Requirements
* `dmd`
* `dub`

# Building
```sh
dub build -c release --build=release
```

# TODO
Currently only lists sink-inputs. This aims to have the same usage as `pactl`, just with JSON output