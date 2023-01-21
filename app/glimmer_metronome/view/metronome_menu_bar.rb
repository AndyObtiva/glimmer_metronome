class GlimmerMetronome
  module View
    class MetronomeMenuBar
      include Glimmer::UI::CustomWidget
      
      option :metronome
  
      body {
        menu_bar {
          menu {
            text '&Action'
            
            menu_item {
              text '&Play'
              
              on_widget_selected do
                metronome.play!
              end
            }
            
            menu_item {
              text '&Stop'
              
              on_widget_selected do
                metronome.stop!
              end
            }
            
            menu_item { |mi|
              text '&Mute'
              
              on_widget_selected do
                metronome.toggle_mute!
                mi.text = metronome.muted ? '&Unmute' : '&Mute'
              end
            }
          }
          
          menu {
            text '&Help'
            
            menu_item {
              text '&Tips'
              
              on_widget_selected do
                message_box {
                  text 'Glimmer Metronome - Tips'
                  message <<~MULTI_LINE_STRING
                    Tap ENTER repeatedly to get Tempo calculated automatically
                    
                    Click a beat to change it between an Up beat (yellow) and Down beat (white)
                  MULTI_LINE_STRING
                }.open
              end
            }
            
            menu_item {
              text '&About'
              
              on_widget_selected do
                display_about_dialog
              end
            }
          }
        }
      }
    end
  end
end
