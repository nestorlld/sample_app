require 'spec_helper'

describe "Static pages" do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" } #creates basetitle variable to use below
  
  describe "Home page" do
    before {visit root_path}
    subject {page}

    it {should have_selector('h1', :text => 'Nestor') }
    it {should have_title("#{base_title}") }
    it {should_not have_title("#{full_title('Home')}") }
   
        describe "for signed-in users" do
          let(:user) { FactoryGirl.create(:user) }
          before do
          FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
          FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
          sign_in user
          visit root_path
          end

          it "should render the user's feed" do
            user.feed.each do |item|
            page.should have_selector("li##{item.id}", text: item.content)
            end
          end
          
          describe "follower/following counts" do
            let(:other_user) { FactoryGirl.create(:user) }
            before do
            other_user.follow!(user)
            visit root_path
            end

          it { should have_link("0 following", href: following_user_path(user)) }
          it { should have_link("1 followers", href: followers_user_path(user)) }
          end
          
        end
   end

  describe "Help page" do
    before {visit help_path}
    subject {page}
    
    it {should have_selector('h1', :text => 'Help') }
    it {should have_title("#{full_title('Help')}") }
   end

  describe "About page" do
    before {visit about_path}
    subject {page}
    
    it {should have_selector('h1', :text => 'About') }
    it {should have_title("#{full_title('About Us')}") }
  end
  
  describe "Contact" do
    before {visit contact_path}
    subject {page}

    it {should have_selector('h1', :text => 'Contact') }
    it {should have_title("#{full_title('Contact')}") }
  end
  
end