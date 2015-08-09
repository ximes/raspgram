FactoryGirl.define do
	factory :response do
		factory :valid_response do
			command "command"
		end
		factory :empty_response do
			command nil
		end
	    initialize_with do
	      new(command)
	    end
    end
end