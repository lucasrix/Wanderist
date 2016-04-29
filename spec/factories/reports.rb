FactoryGirl.define do
  factory :report do
    user
    kind { Report::REPORT_KIND.sample }
    association :reportable
  end
end
