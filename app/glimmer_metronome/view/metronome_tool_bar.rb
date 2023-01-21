# Copyright (c) 2022-2023 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

class GlimmerMetronome
  module View
    class MetronomeToolBar
      include Glimmer::UI::CustomWidget
      
      option :metronome
  
      body {
        tool_bar {
          tool_item { |ti|
            image <= [metronome, :stopped, on_read: ->(value) { value ? ICON_PLAY : ICON_STOP }]
            hot_image <= [metronome, :stopped, on_read: ->(value) { value ? ICON_HOT_PLAY : ICON_HOT_STOP }]
            
            on_widget_selected do
              metronome.toggle_playback!
            end
          }
          
          tool_item { |ti|
            image <= [metronome, :muted, on_read: ->(value) { value ? ICON_MUTE : ICON_SOUND }]
            hot_image <= [metronome, :muted, on_read: ->(value) { value ? ICON_HOT_SOUND : ICON_HOT_MUTE }]
            
            on_widget_selected do
              metronome.toggle_mute!
            end
          }
        }
      }
    end
  end
end
