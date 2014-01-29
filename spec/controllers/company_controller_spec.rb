# encoding: utf-8
require 'spec_helper'
describe CompaniesController do

    before(:each) do
      #Inject the pusher for call not real API for test
      #the same procudure we need when we do not need to call remote API in test.
      controller.pusher = FakePusher.new
    end

    it_behaves_like "a model controller" do
      let(:model) { build :good_company }
    end
end
