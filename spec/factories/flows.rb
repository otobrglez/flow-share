FactoryGirl.define do
  sequence(:step_name) { |n| "Step #{n}" }

  factory :step, class: Step, aliases: [:first_step] do
    name { generate(:step_name) }
    flow
  end

  factory :flow, class: Flow do
    name "The Perfect Flow"
    creator

    factory :flow_with_steps do
      ignore { steps_count 5 }

      after(:create) do |flow, evaluator|
        create_list(:step, evaluator.steps_count, flow: flow)
      end
    end

  end

end
