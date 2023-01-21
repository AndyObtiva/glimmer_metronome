# Change Log

## 1.1.4

- Implement menu actions for play/stop/mute/unmute
- Upgrade to glimmer-dsl-swt 4.26.0.1
- Start and Stop menu items supporting accelerators (keyboard shortcuts)
- Mute and Unmute menu items supporting accelerators (keyboard shortcuts)
- Beat Count -> Increment/Decrement menu items supporting accelerators (keyboard shortcuts)
- Tempo -> Increment/Decrement/Increment-by-10/Decrement-by-10 menu items supporting accelerators (keyboard shortcuts)

## 1.1.3

- Fix issue with changing the beat count while the metronome is stopped resulting in starting the metronome while the play button status is stuck as if it is stopped

## 1.1.2

- ARM64/AARCH64 support via jruby-9.3.3.0 & glimmer-dsl-swt v4.22.2.1

## 1.1.1

- Menu bar with Help Tips and Aboute

- Avoid opening audio clip if muted
- Clean audio clip resources after performing clip.open and clip.start

## 1.1.0

- Tap-based calculation of tempo through hitting ENTER key
- Mute metronome
- Stop/Start metronome
- Let user pick which beats are up or down by clicking on them (switching color between red [up] and yellow [down])
- Show "play logo" triangle inside "ON" beat for accessibility support (e.g. color blind users)
- Show only 8 beats max horizontally, creating lines of beats if beat count is greater than 8

## 1.0.0

- Initial version with Beat Count and BPM options
