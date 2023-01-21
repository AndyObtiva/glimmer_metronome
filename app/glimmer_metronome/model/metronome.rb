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

require_relative 'rhythm'

class GlimmerMetronome
  module Model
    class Metronome
      import 'javax.sound.sampled'
    
      FILE_SOUND_METRONOME_UP = File.join(APP_ROOT, 'sounds', 'metronome-up.wav')
      FILE_SOUND_METRONOME_DOWN = File.join(APP_ROOT, 'sounds', 'metronome-down.wav')
      
      attr_reader :rhythm
      attr_accessor :muted, :stopped
      alias muted? muted
      alias stopped? stopped
      
      def initialize
        @rhythm = Model::Rhythm.new
        @muted = false
        @stopped = false
      end
      
      def stopped=(value)
        @stopped = value
        notify_observers(:playing)
      end
      
      def playing
        !stopped
      end
      alias playing? playing
      
      def playing=(value)
        self.stopped = !value
      end
      
      def play!
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
      
      def stop!
        self.stopped = true
        @thread&.kill # not dangerous in this case and is useful to stop sleep
        @thread = nil
        @rhythm.off!
      end
      
      def toggle_playback!
        if stopped?
          play!
        else
          stop!
        end
      end
      
      def mute!
        self.muted = true
      end
      
      def unmute!
        self.muted = false
      end
      
      def toggle_mute!
        self.muted = !self.muted
      end
      
      # Play sound with the Java Sound library
      def play_sound(sound_file)
        return if muted?
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
    end
  end
end
