require_relative 'lib/cavitty/version'

Gem::Specification.new do |s|
  s.name    = 'cavitty'
  s.version = Cavitty::VERSION
  s.author  = 'Allis IO'
  s.license = 'Unlicense'
  s.summary = 'cavitty = cellular automata visualizations in the terminal, yo!'

  s.metadata['source_code_uri'] = 'https://github.com/allisio/cavitty'
  s.files = Dir.chdir(File.expand_path('..', __FILE__)) {
    `git ls-files -z`.split(?\x0)
  }

  s.bindir       = 'bin'
  s.executables  = 'cavitty'
  s.require_path = 'lib'
end
