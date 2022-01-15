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
      background :widget_background
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
      background :widget_background
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
      background :widget_background
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
      background :widget_background
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
      background :widget_background
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
      background :widget_background
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
      background :widget_background
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
      background :widget_background
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
