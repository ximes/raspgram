FactoryGirl.define do
	factory :message do
		factory :valid_message do
			content "Lorem ipsum"
			from "12345678"
		end
		initialize_with { new(attributes) }
    end
end