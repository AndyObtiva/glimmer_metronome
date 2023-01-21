class GlimmerMetronome
  module View
    class MetronomeToolBar
      include Glimmer::UI::CustomWidget
      
      option :metronome
  
      body {
        tool_bar {
          tool_item { |ti|
            image ICON_STOP
            hot_image ICON_HOT_STOP
            
            on_widget_selected do
              metronome.toggle_metronome!
              ti.image = metronome.stopped ? ICON_PLAY : ICON_STOP
              ti.hot_image = metronome.stopped ? ICON_HOT_PLAY : ICON_HOT_STOP
            end
          }
          
          tool_item { |ti|
            image ICON_SOUND
            hot_image ICON_HOT_MUTE
            
            on_widget_selected do
              metronome.muted = !metronome.muted # TODO consider adding a method to do this
              ti.image = metronome.muted ? ICON_MUTE : ICON_SOUND
              ti.hot_image = metronome.muted ? ICON_HOT_SOUND : ICON_HOT_MUTE
            end
          }
        }
      }
    end
  end
end
