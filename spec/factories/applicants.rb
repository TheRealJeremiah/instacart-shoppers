FactoryGirl.define do
  factory :applicant do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.email { Faker::Internet.email }
    f.phone { Faker::PhoneNumber.cell_phone }
    f.phone_type { 'iPhone 6/6 Plus' }
    f.workflow_state { 'applied' }
    f.region { 'San Francisco Bay Area' }
  end

  factory :invalid_applicant, parent: :contact do |f|
    f.email nil
  end
end
