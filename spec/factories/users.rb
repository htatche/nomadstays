FactoryGirl.define do

  factory :user do
    username    'testuser'
    email       'test@example.com'
    encrypted_password 'password'
    first_name  'Test'
    last_name   'User'
    confirmed_at '2015-04-01 01:01:01'
  end

end
