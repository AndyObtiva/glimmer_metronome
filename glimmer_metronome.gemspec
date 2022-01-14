# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: glimmer_metronome 1.0.0 ruby vendor lib app

Gem::Specification.new do |s|
  s.name = "glimmer_metronome".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["vendor".freeze, "lib".freeze, "app".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2022-01-14"
  s.description = "Glimmer Metronome (JRuby application built with Glimmer DSL for SWT)".freeze
  s.email = "andy.am@gmail.com".freeze
  s.executables = ["glimmer_metronome".freeze]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md",
    "VERSION",
    "app/glimmer_metronome.rb",
    "app/glimmer_metronome/launch.rb",
    "app/glimmer_metronome/model/beat.rb",
    "app/glimmer_metronome/model/rhythm.rb",
    "app/glimmer_metronome/view/app_view.rb",
    "bin/glimmer_metronome",
    "config/warble.rb",
    "glimmer_metronome.gemspec",
    "icons/linux/Glimmer Metronome.png",
    "icons/macosx/Glimmer Metronome.icns",
    "icons/windows/Glimmer Metronome.ico",
    "sounds/metronome-down.wav",
    "sounds/metronome-up.wav"
  ]
  s.homepage = "http://github.com/AndyObtiva/glimmer_metronome".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.29".freeze
  s.summary = "Glimmer Metronome".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 4.22.1.1"])
    s.add_runtime_dependency(%q<psych>.freeze, ["= 3.3.2"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_development_dependency(%q<juwelier>.freeze, ["= 2.4.9"])
    s.add_development_dependency(%q<warbler>.freeze, ["= 2.0.5"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  else
    s.add_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 4.22.1.1"])
    s.add_dependency(%q<psych>.freeze, ["= 3.3.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<juwelier>.freeze, ["= 2.4.9"])
    s.add_dependency(%q<warbler>.freeze, ["= 2.0.5"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end

