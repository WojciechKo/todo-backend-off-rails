class Log
  class << self
    %i[fatal error warn info debug].each do |level|
      define_method(level) do |*arg|
        logger.send(level, *arg)
      end
    end

    def logger
      @logger ||= Logger.new(MultiIO.new(STDOUT, log_file))
    end

    def error_stream
      MultiIO.new(STDERR, log_file)
    end

    def log_file
      File.new("log/#{ENV.fetch('RACK_ENV')}.log", 'a+').tap do |file|
        file.sync = true
      end
    end
  end

  class MultiIO
    def initialize(*targets)
      @targets = targets
    end

    def write(*args)
      @targets.each { |t| t.write(*args) }
    end

    def flush(*args)
      @targets.each { |t| t.flush(*args) }
    end

    def puts(*args)
      @targets.each { |t| t.puts(*args) }
    end

    def close
      @targets.each(&:close)
    end
  end
end
