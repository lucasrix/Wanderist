FactoryGirl.define do
  factory :settings_suit do
    user
    notifications true
    autoupdate true
    use_location true
    public false
  end
end
