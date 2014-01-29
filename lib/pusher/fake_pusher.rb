class FakePusher < BasePusher
  %w(company product).each do |model|
    define_method "send_#{model}_request_to_crunch_base" do |params = {}|

    end
  end
end