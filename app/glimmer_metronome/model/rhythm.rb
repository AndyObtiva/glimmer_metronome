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

require 'bigdecimal'

require_relative 'beat'

class GlimmerMetronome
  module Model
    class Rhythm
      attr_reader :beat_count
      attr_accessor :beats, :tempo
      
      def initialize(beat_count)
        self.beat_count = beat_count
        @tempo = 120
      end
      
      def beat_count=(value)
        @beat_count = value
        reset_beats!
      end
      
      def on_beat!(beat_index)
        off!
        beats[beat_index].on!
      end
      
      def off!
        beats.select(&:on).each(&:off!)
      end
      
      def reset_beats!
        if @beats
          off!
          if beat_count > @beats.count
            @beats += (beat_count - @beats.count).times.map {Beat.new}
          elsif beat_count < @beats.count
            @beats = @beats[0, @beats.count]
          end
        else
          @beats = beat_count.times.map {Beat.new}
        end
        on_beat!(0)
      end
      
      def tap!
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
            self.tempo = (BigDecimal('60.0') / time_difference)
          else
            @tap_time = []
          end
        end
        @tap_time << Time.now
      end
    end
  end
end
