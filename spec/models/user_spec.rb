require 'rails_helper'

describe User do
  before(:each) do
    @user = build(:user)
  end

  it '#full_name' do
    expect(@user.full_name).to eq('Test User')
  end
end