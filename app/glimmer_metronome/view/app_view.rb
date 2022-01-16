# Copyright (c) 2022 Andy Maleh
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

require_relative '../model/rhythm'

class GlimmerMetronome
  module View
    class AppView
      include Glimmer::UI::CustomShell
      
      import 'javax.sound.sampled'
      
      FILE_SOUND_METRONOME_UP = File.join(APP_ROOT, 'sounds', 'metronome-up.wav')
      FILE_SOUND_METRONOME_DOWN = File.join(APP_ROOT, 'sounds', 'metronome-down.wav')
      COLOR_BEAT_UP = :yellow
      COLOR_BEAT_DOWN = :white
          
      attr_accessor :muted, :stopped
      alias muted? muted
      alias stopped? stopped
          
      before_body do
        @rhythm = Model::Rhythm.new(4)
        
        display {
          on_about do
            display_about_dialog
          end
          
          on_preferences do
            display_about_dialog
          end
          
          on_swt_keydown do |event|
            @rhythm.tap! if event.keyCode == swt(:cr)
          end
        }
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
          
          menu_bar {
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
          
          tool_bar {
            tool_item { |ti|
              image ICON_STOP
              hot_image ICON_HOT_STOP
              
              on_widget_selected do
                toggle_metronome!
                ti.image = @stopped ? ICON_PLAY : ICON_STOP
                ti.hot_image = @stopped ? ICON_HOT_PLAY : ICON_HOT_STOP
              end
            }
            
            tool_item { |ti|
              image ICON_SOUND
              hot_image ICON_HOT_MUTE
              
              on_widget_selected do
                self.muted = !@muted
                ti.image = @muted ? ICON_MUTE : ICON_SOUND
                ti.hot_image = @muted ? ICON_HOT_SOUND : ICON_HOT_MUTE
              end
            }
          }
          
          label {
            text 'Beat Count'
            font height: 30, style: :bold
            foreground :yellow
          }
          
          spinner {
            minimum 1
            maximum 64
            selection <=> [@rhythm, :beat_count, after_write: method(:build_beats)]
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
            selection <=> [@rhythm, :tempo]
            font height: 30
          }
          
          @beat_container = composite {
            grid_layout(@rhythm.beat_count, true)
            
            background :red
            
            @beats = @rhythm.beat_count.times.map { |n|
              beat(n)
            }
          }
          
          on_swt_show {
            build_beats
          }
          
          on_widget_disposed {
            stop_metronome!
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
            background <= [@rhythm, "beats[#{beat_index}].up", on_read: ->(up) { up ? COLOR_BEAT_UP : COLOR_BEAT_DOWN}]
          }
          polygon(18, 16, 34, 25, 18, 34) {
            background <= [@rhythm, "beats[#{beat_index}].on", on_read: ->(on) { on ? :black : (@rhythm.beats[beat_index].up? ? COLOR_BEAT_UP : COLOR_BEAT_DOWN)}]
            background <= [@rhythm, "beats[#{beat_index}].up", on_read: ->(up) { @rhythm.beats[beat_index].on? ? :black : (up ? COLOR_BEAT_UP : COLOR_BEAT_DOWN)}]
          }
          
          on_mouse_up do
            if @rhythm.beats[beat_index].up?
              @rhythm.beats[beat_index].down!
            else
              @rhythm.beats[beat_index].up!
            end
          end
        }
      end
      
      def start_metronome!
        self.stopped = false
        @thread ||= Thread.new do
          @rhythm.beat_count.times.cycle { |n|
            begin
              @rhythm.on_beat!(n)
            rescue => e
              puts e.full_message
            end
            sound_file = @rhythm.beats[n].up? ? FILE_SOUND_METRONOME_UP : FILE_SOUND_METRONOME_DOWN
            play_sound(sound_file)
            sleep(60.0/@rhythm.tempo.to_f)
          }
        end
      end
      
      def stop_metronome!
        self.stopped = true
        @thread&.kill # not dangerous in this case and is useful to stop sleep
        @thread = nil
        @rhythm.off!
      end
      
      def toggle_metronome!
        if stopped?
          start_metronome!
        else
          stop_metronome!
        end
      end
      
      def build_beats
        stop_metronome!
        beat_container_layout_change = @rhythm.beat_count != @beats.count && (@rhythm.beat_count < 9 || @beats.count < 9)
        if @rhythm.beat_count > @beats.count
          index_start = @beats.count
          @beat_container.content {
            @beats += (@rhythm.beat_count - @beats.count).times.map do |n|
              beat(index_start + n)
            end
          }
        elsif @rhythm.beat_count < @beats.count
          first_index_to_dispose = -(@beats.count - @rhythm.beat_count)
          @beats[first_index_to_dispose..-1].each(&:dispose)
          @beats = @beats[0...first_index_to_dispose]
        end
        update_beat_container_layout if beat_container_layout_change
        start_metronome!
      end
      
      def update_beat_container_layout
        @beat_container.content {
          if @rhythm.beat_count < 8
            grid_layout(@rhythm.beat_count, true)
          else
            grid_layout(8, true)
          end
        }
        body_root.layout(true, true)
        body_root.pack(true)
        body_root.center_within_display
      end
      
      # Play sound with the Java Sound library
      def play_sound(sound_file)
        return if @muted
        begin
          audio_input = build_audio_input(sound_file)
          audio_stream = AudioSystem.get_audio_input_stream(audio_input)
          clip = AudioSystem.clip
          clip.open(audio_stream)
          clip.start
        rescue => e
          puts e.full_message
        ensure
          Thread.new do
            sleep(0.01) while clip.running?
            clip.close
          end
        end
      end
      
      def build_audio_input(sound_file)
        # if running from packaged JAR, we get a uri:classloader sound_file
        if sound_file.start_with?('uri:classloader')
          jar_file_path = sound_file
          file_path = jar_file_path.sub(/^uri\:classloader\:/, '').sub(/^\/+/, '')
          require 'jruby'
          jcl = JRuby.runtime.jruby_class_loader
          resource = jcl.get_resource_as_stream(file_path)
          file_input_stream = resource.to_io.to_input_stream
          java.io.BufferedInputStream.new(file_input_stream)
        else
          java.io.File.new(sound_file)
        end
      end
      
      def display_about_dialog
        dialog(body_root) {
          grid_layout(2, false) {
            margin_width 15
            margin_height 15
          }
          
          background :white
          image ICON
          text 'About'
          
          label {
            layout_data :center, :center, false, false
            background :white
            image ICON, height: 260
          }
          label {
            layout_data :fill, :fill, true, true
            background :white
            text "Glimmer Metronome #{VERSION}\n\n#{LICENSE}\n\nGlimmer Metronome icon made by Freepik from www.flaticon.com"
          }
        }.open
      end
    end
  end
end
