# <img src="https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/icons/linux/Glimmer%20Metronome.png" height=85 /> Glimmer Metronome 1.1.4
## [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 /> Glimmer Application](https://github.com/AndyObtiva/glimmer-dsl-swt)
[![Gem Version](https://badge.fury.io/rb/glimmer_metronome.svg)](http://badge.fury.io/rb/glimmer_metronome)

Glimmer Metronome supports different beat counts, click sounds, and tempos, including tap-based tempo calculation [(click to see a video demo)](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome.mp4).

[![metronome demo](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome.gif)](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome.mp4)

<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/icons/linux/Glimmer%20Metronome.png" height=40 /> [Download Glimmer Metronome 1.1.3 DMG for Mac (ARM64 Ventura and Older)](https://www.dropbox.com/s/pwwpdj3sjggqokz/Glimmer%20Metronome-1.1.3-arm64.dmg?dl=1)

<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/icons/linux/Glimmer%20Metronome.png" height=40 /> [Download Glimmer Metronome 1.1.4 DMG for Mac (x64 Catalina and Older)](https://www.dropbox.com/s/rnlh0nv9gj9ntuh/Glimmer%20Metronome-1.1.4.dmg?dl=1)

## Features

![metronome](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome.png)

Beat Count Change

![metronome beat count changed](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome-beat-count-changed.png)

Tempo Change (hit ENTER repeatedly to auto-calculate tempo)

![metronome tempo changed](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome-tempo-changed.png)

Click Sound Change (via mouse-click on beats to toggle yellow or white)

![metronome click sound changed](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome-up-beats-changed.png)

### Menus

### Action Menu

![metronome](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome-menu-action.png)

- Stop (CMD+S on Mac / CTRL+S on Linux/Windows)
- Play (CMD+P on Mac / CTRL+P on Linux/Windows)
- Mute (CMD+M on Mac / CTRL+M on Linux/Windows)
- Unmute (CMD+U on Mac / CTRL+U on Linux/Windows)
- [Beat Count submenu (see below)](#action-menu---beat-count)
- [Tempo submenu (see below)](#action-menu---tempo)
- Exit (ALT+F4)

### Action Menu - Beat Count

![metronome](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome-menu-action-beat-count.png)

- Increment (CMD+= / CTRL+= on Linux/Windows)
- Decrement (CMD+- on Mac / CTRL+- on Linux/Windows)

### Action Menu - Tempo

![metronome](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome-menu-action-tempo.png)

- Increment (CMD+ArrowUp / CTRL+ArrowUp on Linux/Windows)
- Decrement (CMD+ArrowDown on Mac / CTRL+ArrowDown on Linux/Windows)
- Increment by 10 (CMD+SHIFT+ArrowUp / CTRL+SHIFT+ArrowUp on Linux/Windows)
- Decrement by 10 (CMD+SHIFT+ArrowDown on Mac / CTRL+SHIFT+ArrowDown on Linux/Windows)

### Help Menu

![metronome](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome-menu-help.png)

- Tips (CMD+T / CTRL+T on Linux/Windows)
- About (CMD+A / CTRL+A on Linux/Windows)


## Demo

[Video/Audio Demo](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome.mp4)

## Software Setup Instructions

You may download a pre-packaged version:

<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/icons/linux/Glimmer%20Metronome.png" height=40 /> [Download Glimmer Metronome 1.1.3 DMG for Mac (ARM64 Ventura and Older)](https://www.dropbox.com/s/pwwpdj3sjggqokz/Glimmer%20Metronome-1.1.3-arm64.dmg?dl=1)

<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/icons/linux/Glimmer%20Metronome.png" height=40 /> [Download Glimmer Metronome 1.1.4 DMG for Mac (x64 Catalina and Older)](https://www.dropbox.com/s/rnlh0nv9gj9ntuh/Glimmer%20Metronome-1.1.4.dmg?dl=1)

Alternatively, if you are a software engineer and would like to install this application as a [Ruby gem](https://guides.rubygems.org/what-is-a-gem/), you may follow these instructions:

- Ensure you have [Glimmer DSL for SWT 4.22.2.1 prerequisites setup (like JDK and JRuby)](https://github.com/AndyObtiva/glimmer-dsl-swt/tree/v4.22.2.1#pre-requisites).
- Install gem via `gem install glimmer_metronome -v1.1.4` command
- Run `glimmer_metronome` command to start application

Lastly, you can package a native executable for your specific system (e.g. produce MSI/EXE file on Windows 10 x64) by following these instructions instead:
- Ensure you have [Glimmer DSL for SWT 4.22.2.1 prerequisites setup (like JDK and JRuby)](https://github.com/AndyObtiva/glimmer-dsl-swt/tree/v4.22.2.1#pre-requisites).
- Clone repo: `git clone https://github.com/AndyObtiva/glimmer_metronome.git` (or `git clone git@github.com:AndyObtiva/glimmer_metronome.git` if you prefer SSH)
- Go into directory: `cd glimmer_metronome`
- Install project gems: `bundle`
- Package native executable with `glimmer package` to produce APP on Mac, native project directory with exe on Windows, and native project with binary on Linux
- Package native executable with `glimmer "package[dmg]"` to produce DMG file on Mac
- Package native executable with `glimmer "package[msi]"` to produce MSI installer on Windows (assuming you installed the [WiX Toolset](https://wixtoolset.org/) as per the instructions at [Glimmer DSL for SWT Packaging & Distribution](https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_PACKAGING_AND_DISTRIBUTION.md))
- You can also directly run the project from the cloned repo directory with `glimmer run`

## Contributing

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

## Copyright

[MIT](LICENSE.txt)

Copyright (c) 2022-2023 Andy Maleh. See [LICENSE.txt](LICENSE.txt) for further details.

--

Glimmer Metronome icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
