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

require_relative 'metronome_about_dialog'

class GlimmerMetronome
  module View
    class MetronomeMenuBar
      include Glimmer::UI::CustomWidget
      
      KEY_SHORTCUT = OS.mac? ? :command : :ctrl
      
      option :metronome
  
      body {
        menu_bar {
          menu {
            text '&Action'
            
            menu_item {
              text '&Stop'
              enabled <= [metronome, :playing]
              accelerator KEY_SHORTCUT, :s
              
              on_widget_selected do
                metronome.stop!
              end
            }
            
            menu_item {
              text '&Play'
              enabled <= [metronome, :stopped]
              accelerator KEY_SHORTCUT, :p
              
              on_widget_selected do
                metronome.play!
              end
            }
            
            menu_item(:separator)
            
            menu_item { |mi|
              text '&Mute'
              enabled <= [metronome, :muted, on_read: :!]
              accelerator KEY_SHORTCUT, :m
              
              on_widget_selected do
                metronome.mute!
              end
            }
            
            menu_item { |mi|
              text '&Unmute'
              enabled <= [metronome, :muted]
              accelerator KEY_SHORTCUT, :u
              
              on_widget_selected do
                metronome.unmute!
              end
            }
            
            menu_item(:separator)
            
            menu_item { |mi|
              text 'E&xit'
              accelerator :alt, :f4
              
              on_widget_selected do
                shell_proxy.close
              end
            }
          }
          
          menu {
            text '&Help'
            
            menu_item {
              text '&Tips'
              accelerator KEY_SHORTCUT, :t
              
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
              accelerator KEY_SHORTCUT, :a
              
              on_widget_selected do
                metronome_about_dialog(owner: shell_proxy).open
              end
            }
          }
        }
      }
    end
  end
end
