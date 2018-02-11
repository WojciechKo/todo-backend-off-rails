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
      case elem
      when String then Regexp.new "#{product.source}/#{elem}"
      when Symbol then Regexp.new "#{product.source}\/#{REGEXES[elem].source}"
      end
    end
  end
end
