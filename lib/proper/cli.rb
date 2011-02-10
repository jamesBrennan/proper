require 'optparse'
require 'proper'

module Proper
  class CLI
    attr_reader :stdout, :stdin, :stderr
    attr_reader :arguments, :options
    attr_reader :output

    def self.execute(stdout, stdin, stderr, arguments = [])
      @options = {
          :log_file => stderr,
          :output => stdout
      }
      self.parse_options(arguments)
      self.new(stdout, stdin, stderr, arguments, @options).execute!
    end

    def self.option_parser
      @option_parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} [options] <url> [<url> ...]"

        @options[:stylesheets] = []

        opts.on("-l", "--log [OPT]", "Where to write log messages") do |v|
          @options[:log_file] = v || ""
        end

        opts.on("-O", "--output FILE",
                "Where to output processed CSS file") do |v|
          @options[:output] = v
        end

        opts.on("-s", "--stylesheet FILE",
                "Process the specified stylesheet") do |v|
          @options[:stylesheets] << v
        end
      end
    end

    def self.parse_options(arguments = [])
      self.option_parser.parse!(arguments)
      @options
    end

    def initialize(stdout, stdin, stderr, arguments = [], options = {})
      @stdout = stdout
      @stdin = stdin
      @stderr = stderr
      @arguments = arguments
      @options = options
      @output = options[:output]
    end

    def execute!
      if options.empty?
        stdout.puts self.class.option_parser.help
      else
        process
      end
    end

    def process
      proper = Proper.new
      proper.log_file = @options[:log_file]
      proper.stylesheets = @options[:stylesheets]
      proper.output = @options[:output]
      proper.run
    end

  end
end

