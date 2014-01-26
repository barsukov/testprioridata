class BaseModel
  include ActiveModel::Dirty
  include ActiveModel::Serialization
  include ActiveModel::Validations
  include ActiveModel::Callbacks
  include ActiveModel::Conversion
  extend ActiveModel::Naming

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