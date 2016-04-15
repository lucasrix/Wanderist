require 'rails_helper'

shared_examples_for 'followable' do
  it { should respond_to? :followings }
  it { should respond_to? :followings_count }
  it { should respond_to? :followed? }
  it { should have_many :followings }
end
