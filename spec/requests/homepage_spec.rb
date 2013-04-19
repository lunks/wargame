require 'spec_helper'

describe 'homepage' do

  context 'not authenticated user' do
    it 'should see the homepage' do
      visit '/'
      #meh page.should have_content('Hello!')
    end
    it 'should show me a login page to access a restricted area' do
      visit '/home/restricted'
      page.should have_content('Sign in')
    end

  end
  context 'authenticated user' do
    let(:squad) {Factory.attributes_for(:squad)}
    before(:each) {login_user!}

    it 'should show me the restricted area' do
      visit '/home/restricted'
      page.should have_content('Restricted')
    end

    it 'should show me new squad form if dont have a squad yet' do
      page.should have_content('Novo Esquadrão')
    end

    it 'should create a squad' do
      #fill_in('Nome', :with => squad[:name])
     # select(squad[:color], :from => 'Cor')
      #select(squad[:faction], :from => 'Facção')
     # click_button('Create Squad')
    #  User.first.squad.should_not be_nil
    end




  end

end
