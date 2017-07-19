class Hello
  def self.world?
    true
  end
end

RSpec.describe Hello do
  describe '::world?' do
    it 'returns true' do
      expect(Hello.world?).to be_truthy
    end
  end
end
