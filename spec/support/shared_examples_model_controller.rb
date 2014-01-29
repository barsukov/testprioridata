shared_examples "a model controller" do
  it "send request for one model" do
    get :show, id: model.id
    response.should be_success
    expect(response.body).to be_blank
  end
end