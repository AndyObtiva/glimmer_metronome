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

$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

begin
  require 'bundler/setup'
  Bundler.require(:default)
rescue
  # this runs when packaged as a gem (no bundler)
  require 'glimmer-dsl-swt'
  # add more gems if needed
end

require 'bigdecimal'

class GlimmerMetronome
  include Glimmer
  
  APP_ROOT = File.expand_path('../..', __FILE__)
  VERSION = File.read(File.join(APP_ROOT, 'VERSION'))
  LICENSE = File.read(File.join(APP_ROOT, 'LICENSE.txt'))
  ICON = File.join(APP_ROOT, 'icons/linux/Glimmer Metronome.png')
  ICON_SOUND = image(36, 36) {
    rectangle(0, 0, 36, 36) {
      background :red # :widget_background
    }
    
    oval(0, 0, 36, 36) {
      background :red
    }
    
    polygon(7, 14, 11, 14, 18, 10, 18, 26, 11, 22, 7, 22) {
      background :white
    }
    
    arc(8, 11, 14, 14, 40, -80) {
      foreground :white
      line_width 2
      line_join :round
      line_cap :round
    }
    
    arc(6, 8, 20, 20, 40, -80) {
      foreground :white
      line_width 2
      line_join :round
      line_cap :round
    }
    
    arc(4, 5, 26, 26, 40, -80) {
      foreground :white
      line_width 2
      line_join :round
      line_cap :round
    }
  }
  ICON_HOT_SOUND = image(36, 36) {
    rectangle(0, 0, 36, 36) {
      background :red # :widget_background
    }
    
    oval(0, 0, 36, 36) {
      background :red
    }
    
    polygon(7, 14, 11, 14, 18, 10, 18, 26, 11, 22, 7, 22) {
      background :yellow
    }
    
    arc(8, 11, 14, 14, 40, -80) {
      foreground :yellow
      line_width 2
      line_join :round
      line_cap :round
    }
    
    arc(6, 8, 20, 20, 40, -80) {
      foreground :yellow
      line_width 2
      line_join :round
      line_cap :round
    }
    
    arc(4, 5, 26, 26, 40, -80) {
      foreground :yellow
      line_width 2
      line_join :round
      line_cap :round
    }
  }
  ICON_MUTE = image(36, 36) {
    rectangle(0, 0, 36, 36) {
      background :red # :widget_background
    }
    
    oval(0, 0, 36, 36) {
      background :red
    }
    
    polygon(7, 14, 11, 14, 18, 10, 18, 26, 11, 22, 7, 22) {
      background :white
    }
  }
  ICON_HOT_MUTE = image(36, 36) {
    rectangle(0, 0, 36, 36) {
      background :red # :widget_background
    }
    
    oval(0, 0, 36, 36) {
      background :red
    }
    
    polygon(7, 14, 11, 14, 18, 10, 18, 26, 11, 22, 7, 22) {
      background :yellow
    }
  }
  ICON_STOP = image(36, 36) {
    rectangle(0, 0, 36, 36) {
      background :red # :widget_background
    }
    
    oval(0, 0, 36, 36) {
      background :red
    }
    
    rectangle(11, 11, 14, 14) {
      background :white
    }
  }
  ICON_HOT_STOP = image(36, 36) {
    rectangle(0, 0, 36, 36) {
      background :red # :widget_background
    }
    
    oval(0, 0, 36, 36) {
      background :red
    }
    
    rectangle(11, 11, 14, 14) {
      background :yellow
    }
  }
  ICON_PLAY = image(36, 36) {
    rectangle(0, 0, 36, 36) {
      background :red # :widget_background
    }
    
    oval(0, 0, 36, 36) {
      background :red
    }
    
    polygon(12, 10, 26, 18, 12, 26) {
      background :white
    }
  }
  ICON_HOT_PLAY = image(36, 36) {
    rectangle(0, 0, 36, 36) {
      background :red # :widget_background
    }
    
    oval(0, 0, 36, 36) {
      background :red
    }
    
    polygon(12, 10, 26, 18, 12, 26) {
      background :yellow
    }
  }
end

require 'glimmer_metronome/view/app_view'
