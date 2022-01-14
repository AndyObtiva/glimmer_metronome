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
            if event.keyCode == swt(:cr)
              new_tap_time = Time.now
              @tap_time ||= []
              time_difference = nil
              if @tap_time.any?
                if @tap_time[-2]
                  time_difference1 = new_tap_time - @tap_time[-1]
                  time_difference2 = @tap_time[-1] - @tap_time[-2]
                  time_difference = BigDecimal((time_difference1 + time_difference2).to_s) / 2.0
                else
                  time_difference = BigDecimal((new_tap_time - @tap_time[-1]).to_s)
                end
              end
              if time_difference
                if time_difference < 2
                  @rhythm.bpm = (BigDecimal('60.0') / time_difference)
                else
                  @tap_time = []
                end
              end
              @tap_time << Time.now
            end
          end
        }
      end
      
      body {
        shell(:no_resize) {
          row_layout(:vertical) {
            center true
          }
          text 'Glimmer Metronome'
          
          label {
            text 'Beat Count'
            font height: 30, style: :bold
          }
          
          spinner {
            minimum 1
            maximum 64
            selection <=> [@rhythm, 'beat_count', after_write: ->(v) {restart_metronome}]
            font height: 30
          }
          
          label {
            text 'BPM'
            font height: 30, style: :bold
          }
          
          spinner {
            minimum 30
            maximum 1000
            selection <=> [@rhythm, 'bpm']
            font height: 30
          }
          
          @beat_container = beat_container
          
          on_swt_show {
            start_metronome
          }
          
          on_widget_disposed {
            stop_metronome
          }
        }
      }
      
      def beat_container
        composite {
          grid_layout(@rhythm.beat_count, true)
          
          @rhythm.beat_count.times { |n|
            canvas {
              layout_data {
                width_hint 50
                height_hint 50
              }
              rectangle(0, 0, :default, :default, 36, 36) {
                background <= [@rhythm, "beats[#{n}].on", on_read: ->(on) { on ? :red : :yellow}]
              }
            }
          }
        }
      end
      
      def start_metronome
        @thread ||= Thread.new {
          @rhythm.beat_count.times.cycle { |n|
            sleep(60.0/@rhythm.bpm.to_f)
            @rhythm.beats.each(&:off!)
            @rhythm.beats[n].on!
            sound_file = n == 0 ? FILE_SOUND_METRONOME_UP : FILE_SOUND_METRONOME_DOWN
            play_sound(sound_file)
          }
        }
        if @beat_container.nil?
          body_root.content {
            @beat_container = beat_container
          }
          body_root.layout(true, true)
          body_root.pack(true)
        end
      end
      
      def stop_metronome
        @thread&.kill # safe since no stored data is involved
        @thread = nil
        @beat_container&.dispose
        @beat_container = nil
      end
      
      def restart_metronome
        stop_metronome
        start_metronome
      end
      
      # Play sound with the Java Sound library
      def play_sound(sound_file)
        begin
          audio_input = build_audio_input(sound_file)
          audio_stream = AudioSystem.get_audio_input_stream(audio_input)
          clip = AudioSystem.clip
          clip.open(audio_stream)
          clip.start
        rescue => e
          puts e.full_message
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
