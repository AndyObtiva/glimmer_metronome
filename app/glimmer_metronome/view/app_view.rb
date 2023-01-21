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

require_relative '../model/metronome'

require_relative 'metronome_menu_bar'
require_relative 'metronome_tool_bar'
require_relative 'metronome_about_dialog'

class GlimmerMetronome
  module View
    class AppView
      include Glimmer::UI::CustomShell
      
      COLOR_BEAT_UP = :yellow
      COLOR_BEAT_DOWN = :white
          
      before_body do
        @metronome = Model::Metronome.new
        
        display {
          on_about do
            metronome_about_dialog(owner: body_root).open
          end
          
          on_preferences do
            metronome_about_dialog(owner: body_root).open
          end
          
          on_swt_keydown do |event|
            @metronome.rhythm.tap! if event.keyCode == swt(:cr)
          end
        }
      end
      
      after_body do
        observe(@metronome.rhythm, :beat_count) { build_beats }
      end
      
      body {
        shell(:no_resize) {
          row_layout(:vertical) {
            center true
            margin_width 20
            margin_height 20
          }
          text 'Glimmer Metronome'
          background :red
          
          metronome_menu_bar(metronome: @metronome)
          
          metronome_tool_bar(metronome: @metronome)
          
          label {
            text 'Beat Count'
            font height: 30, style: :bold
            foreground :yellow
          }
          
          spinner {
            minimum 1
            maximum 64
            selection <=> [@metronome.rhythm, :beat_count]
            font height: 30
          }
          
          label {
            text 'Tempo'
            font height: 30, style: :bold
            foreground :yellow
          }
          
          spinner {
            minimum 30
            maximum 1000
            selection <=> [@metronome.rhythm, :tempo]
            font height: 30
          }
          
          @beat_container = composite {
            grid_layout(@metronome.rhythm.beat_count, true)
            
            background :red
            
            @beats = @metronome.rhythm.beat_count.times.map { |n|
              beat(n)
            }
          }
          
          on_swt_show {
            build_beats
          }
          
          on_widget_disposed {
            @metronome.stop!
          }
        }
      }
      
      def beat(beat_index)
        canvas {
          layout_data {
            width_hint 50
            height_hint 50
          }
          
          background :red
          
          rectangle(0, 0, :default, :default, 36, 36) {
            background <= [@metronome.rhythm, "beats[#{beat_index}].up", on_read: ->(up) { up ? COLOR_BEAT_UP : COLOR_BEAT_DOWN}]
          }
          polygon(18, 16, 34, 25, 18, 34) {
            background <= [@metronome.rhythm, "beats[#{beat_index}].on", on_read: ->(on) { on ? :black : (@metronome.rhythm.beats[beat_index].up? ? COLOR_BEAT_UP : COLOR_BEAT_DOWN)}]
            background <= [@metronome.rhythm, "beats[#{beat_index}].up", on_read: ->(up) { @metronome.rhythm.beats[beat_index].on? ? :black : (up ? COLOR_BEAT_UP : COLOR_BEAT_DOWN)}]
          }
          
          on_mouse_up do
            if @metronome.rhythm.beats[beat_index].up?
              @metronome.rhythm.beats[beat_index].down!
            else
              @metronome.rhythm.beats[beat_index].up!
            end
          end
        }
      end
      
      def build_beats
        initially_stopped = @metronome.stopped
        @metronome.stop! unless initially_stopped
        beat_container_layout_change = @metronome.rhythm.beat_count != @beats.count && (@metronome.rhythm.beat_count < 9 || @beats.count < 9)
        if @metronome.rhythm.beat_count > @beats.count
          index_start = @beats.count
          @beat_container.content {
            @beats += (@metronome.rhythm.beat_count - @beats.count).times.map do |n|
              beat(index_start + n)
            end
          }
        elsif @metronome.rhythm.beat_count < @beats.count
          first_index_to_dispose = -(@beats.count - @metronome.rhythm.beat_count)
          @beats[first_index_to_dispose..-1].each(&:dispose)
          @beats = @beats[0...first_index_to_dispose]
        end
        update_beat_container_layout if beat_container_layout_change
        @metronome.play! unless initially_stopped
      end
      
      def update_beat_container_layout
        @beat_container.content {
          if @metronome.rhythm.beat_count < 8
            grid_layout(@metronome.rhythm.beat_count, true)
          else
            grid_layout(8, true)
          end
        }
        body_root.layout(true, true)
        body_root.pack(true)
        body_root.center_within_display
      end
    end
  end
end
