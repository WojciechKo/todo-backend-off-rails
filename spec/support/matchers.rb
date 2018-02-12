REGEXES = {
  uuid: /[a-z0-9]{8}\-[a-z0-9]{4}\-[a-z0-9]{4}\-[a-z0-9]{4}\-[a-z0-9]{12}/
}.freeze

RSpec::Matchers.define :be_uuid do
  match { |actual| actual.match(REGEXES[:uuid]) }
end

RSpec::Matchers.define :be_url do |*parts|
  match { |actual| actual.match(path_matcher(parts)) }

  def path_matcher(parts)
    parts.reduce(/http:\/\/example.org/) do |product, elem|
      regex_source = product.source
      case elem
      when String then Regexp.new "#{regex_source}/#{elem}"
      when Symbol then Regexp.new "#{regex_source}\/#{REGEXES[elem].source}"
      end
    end
  end
end

RSpec::Matchers.define :return_json do |status, body|
  match do |actual|
    expect(actual).to return_status(status)
    expect(actual).to return_body(body)
    expect(actual).to be_json
  end
  description { "return status #{status} and json #{surface_descriptions_in(body)}" }
  failure_message do |actual|
    "expected #{[actual.status, actual.json, actual.headers]} to have status #{status}, body #{body} and be json"
  end
end

RSpec::Matchers.define :return_status do |status|
  match { |actual| expect(actual).to have_attributes(status: status) }
end

RSpec::Matchers.define :return_body do |json|
  match { |actual| expect(actual).to have_attributes(json: json) }
  description { "return body #{surface_descriptions_in(json)}" }
end

RSpec::Matchers.define :return_headers do |headers|
  match { |actual| expect(actual).to have_attributes(headers: headers) }
end

RSpec::Matchers.define :be_json do
  match do |actual|
    expect(actual).to return_headers(include('Content-Type' => 'application/json'))
  end
end
