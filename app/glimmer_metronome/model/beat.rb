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

class GlimmerMetronome
  module Model
    class Beat
      attr_accessor :on, :up
      alias on? on
      alias up? up
      
      def initialize(is_up)
        self.up = is_up
      end
      
      def off=(is_off)
        self.on = !is_off
      end
      
      def off
        !on
      end
      alias off? off
      
      def off!
        self.on = false
      end
      
      def on!
        self.on = true
      end
      
      def down=(is_down)
        self.up = !is_down
      end
      
      def down
        !up
      end
      alias down? down
      
      def up!
        self.up = true
      end
      
      def down!
        self.down = true
      end
    end
  end
end
