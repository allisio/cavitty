require 'cavitty/version'

def pretty str
  str.chars.map.with_index { |c, i| "\e[38;5;#{i % 7 + 9}m#{c}\e[0m" }.join
end

HELP = <<~EOH
Usage:
  #{pretty 'cavitty'} [options]

  -h, --help      You are here.
  -v, --version   Show cavitty's version number and exit.

DISPLAY OPTIONS
  -r, --rule      the elementary cellular automaton to visualize (0-255)
                      default: %{rule} (the Turing-complete one)
  -s, --seed      the initial configuration state (binary string)
                      default: "%{seed}"
  -f, --fps       the number of new generations to print per second
                      default: %{fps}

  Bare options are interpreted in strict [rule, seed, fps] order.
EOH

def parse args, conf = {}
  opts = conf.keys

  while arg = args.shift
    case arg
    when /-h|--help/
      abort HELP % conf
    when /-v|--version/
      abort Cavitty::VERSION
    when /-r|--rule/
      arg = args.shift
      abort 'rule must be 0-255' unless (0..255) === arg.to_i
      conf[opts.delete :rule] = arg
    when /-s|--seed/
      arg = args.shift
      abort 'seed must be a binary string' unless arg[/^[01]+$/]
      conf[opts.delete :seed] = arg
    when /-f|--fps/
      arg = args.shift
      abort 'framerate must be >0' if arg.to_i < 1
      conf[opts.delete :fps] = arg
    else
      conf[opts.shift] = arg
    end
  end

  conf
end
