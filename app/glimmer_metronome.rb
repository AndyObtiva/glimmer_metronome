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
  APP_ROOT = File.expand_path('../..', __FILE__)
  VERSION = File.read(File.join(APP_ROOT, 'VERSION'))
  LICENSE = File.read(File.join(APP_ROOT, 'LICENSE.txt'))
  ICON = File.join(APP_ROOT, 'icons/linux/Glimmer Metronome.png')
end

require 'glimmer_metronome/view/app_view'
