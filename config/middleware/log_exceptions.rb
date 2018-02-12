class Middleware::LogExceptions
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue StandardError => error
    Log.fatal(log_from_error(error))
    raise
  end

  TABULARIZE = ->(log, line) { "#{log}\t#{line}\n" }.freeze

  def log_from_error(error)
    error_msg = error.class.to_s
    cause_msg = error.message.split("\n")
                  .reduce("\n", &TABULARIZE)
    backtrace_msg = error.backtrace.reverse
                      .reduce('', &TABULARIZE)

    [error_msg, backtrace_msg, error_msg, cause_msg].join("\n")
  end
end
