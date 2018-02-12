class JsonResponse
  def self.build(status, data)
    [
      status,
      { 'Content-Type' => 'application/json' },
      [data.to_json]
    ]
  end
end
