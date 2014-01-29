class BaseModel
  include ActiveModel::Dirty
  include ActiveModel::Serialization
  include ActiveModel::Validations
  include ActiveModel::Callbacks
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_accessor :name,:id,:img_mini_url,:img_max_url,:overview ,:permalink ,:crunch_base_url
  def initialize(attributes={})
    if attributes
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
  end
  class << self
  #factory method for build models
    def create_by_crunch_based(params={})
      self.new(id: params["id"] ,name: params["name"],
               img_mini_url: params["img_min_url"],
               permalink: params["permalink"])
    end

  alias_method :old_create_by_crunch_based, :create_by_crunch_based
  end



  def persisted?
    false
  end

end