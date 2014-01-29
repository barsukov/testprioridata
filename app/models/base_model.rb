class BaseModel
  include ActiveModel::Dirty
  include ActiveModel::Serialization
  include ActiveModel::Validations
  include ActiveModel::Callbacks
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name,:id,:img_mini_url,:img_max_url,:overview ,:permalink
  def initialize(attributes={})
    if attributes
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
  end

  def persisted?
    false
  end

end