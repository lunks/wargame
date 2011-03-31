require 'spec/spec_helper'

describe 'homepage' do
 
  context 'not authenticated user' do
    it 'should see the homepage' do
      visit '/'
      page.should have_content('Hello')
    end
    it 'should show me a login page to access a restricted area' do
      visit '/home/restricted'
      page.should have_content('Sign in')
    end

  end
  context 'authenticated user' do
   
  end

end
