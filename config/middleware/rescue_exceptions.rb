class Middleware::RescueExceptions
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue StandardError
    [
      500,
      { 'Content-Type' => 'application/json' },
      ['Internal Server Error'.to_json]
    ]
  end
end
