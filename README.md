# <img src="https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/icons/linux/Glimmer%20Metronome.png" height=85 /> Glimmer Metronome 1.1.3
## [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 /> Glimmer Application](https://github.com/AndyObtiva/glimmer-dsl-swt)
[![Gem Version](https://badge.fury.io/rb/glimmer_metronome.svg)](http://badge.fury.io/rb/glimmer_metronome)

<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/icons/linux/Glimmer%20Metronome.png" height=40 /> [Download Glimmer Metronome 1.1.3 DMG for Mac (ARM64 Ventura and Older)](https://www.dropbox.com/s/pwwpdj3sjggqokz/Glimmer%20Metronome-1.1.3-arm64.dmg?dl=1)

<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/icons/linux/Glimmer%20Metronome.png" height=40 /> [Download Glimmer Metronome 1.1.1 DMG for Mac (x64 Catalina and Older)](https://www.dropbox.com/s/ecwe0ukjldag6hu/Glimmer%20Metronome-1.1.1.dmg?dl=1)

![metronome demo](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome.gif)

Metronome

![metronome](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome.png)

Beat Count Change

![metronome beat count changed](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome-beat-count-changed.png)

Tempo Change (hit ENTER repeatedly to auto-calculate tempo)

![metronome tempo changed](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome-tempo-changed.png)

Up Beat Change (via mouse-click on beats to toggle up [yellow] or down [white])

![metronome up beats changed](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome-up-beats-changed.png)

For hardcore music buffs out there who are shocked at my reversal or wrong usage of Up beat and Down beat, here are few explanations to keep in mind. First of all, I am a drumkit (Rock) drummer, not a melodic musician. As such, drumkit drummers call every beat on the rhythm count a DOWNBEAT (i.e. 1, 2, 3, 4). Next, I am a Punk Rocker and I've been known to do some Punk drumming. What do I mean by that!? Punk drummers have a complete lack of respect for music rules. In fact, they write their own rules every day, and OFTEN IN TOTAL OPPOSITION TO MUSIC RULES. So, I just came up with the idea of calling the first beat the UPBEAT because the Metronome makes this HIGHER note shrill sound when it clicks on the first beat. Thank you for your understanding and have an awesome Punk Rocking day while at it!

## Demo

[Video/Audio Demo](https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/screenshots/glimmer-metronome.mp4)

## Software Setup Instructions

You may download a pre-packaged version:

<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/icons/linux/Glimmer%20Metronome.png" height=40 /> [Download Glimmer Metronome 1.1.3 DMG for Mac (ARM64 Ventura and Older)](https://www.dropbox.com/s/pwwpdj3sjggqokz/Glimmer%20Metronome-1.1.3-arm64.dmg?dl=1)

<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer_metronome/master/icons/linux/Glimmer%20Metronome.png" height=40 /> [Download Glimmer Metronome 1.1.1 DMG for Mac (x64 Catalina and Older)](https://www.dropbox.com/s/ecwe0ukjldag6hu/Glimmer%20Metronome-1.1.1.dmg?dl=1)

Alternatively, if you are a software engineer and would like to install this application as a [Ruby gem](https://guides.rubygems.org/what-is-a-gem/), you may follow these instructions:

- Ensure you have [Glimmer DSL for SWT 4.22.2.1 prerequisites setup (like JDK and JRuby)](https://github.com/AndyObtiva/glimmer-dsl-swt/tree/v4.22.2.1#pre-requisites).
- Install gem via `gem install glimmer_metronome -v1.1.3` command
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
