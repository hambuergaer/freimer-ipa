require 'spec_helper'
describe 'ipa' do

  context 'with defaults for all parameters' do
    it { should contain_class('ipa') }
  end
end
