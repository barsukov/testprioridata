# encoding: utf-8
require 'spec_helper'

describe SearchesController do
  let(:bad_company) { build :bad_company }
  let(:good_company) { build :good_company }


  describe "POST create" do
    context "send request without real sending" do
      before(:each) do
        #Inject the pusher for call not real API for test
        #the same procudure we need when we do not need to call remote API in test.
        controller.pusher = FakePusher.new
      end
      it "create message with empty params"  do
        post :create, {query: bad_company.name }
        #post :create, {pub0: empty_message.pub0, page: empty_message.page,uid: empty_message.uid }
        response.should be_success
        expect(response.body).to be_blank
      end

    end
    context "send request with real sending" do
      before(:each) do
        WebMock.allow_net_connect!
        controller.pusher = Pusher.new
      end
      it "create message with invalid params"  do
        post :create, {query: bad_company.name }

        response.should be_success
        expect(response.status).to eq 200
      end

      it "create message with valid params"  do
        post :create, {query: good_company.name }

        response.should be_success
        expect(response.status).to eq 200
      end
    end
  end
end
