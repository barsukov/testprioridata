class Company < BaseModel
  attr_accessor :people,:description
  def self.create_by_crunch_based(params={})
    product = self.old_create_by_crunch_based params
    product.description = params["description"]
    product
  end
end