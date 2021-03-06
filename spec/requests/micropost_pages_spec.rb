require 'rails_helper'

RSpec.describe "MicropostPages", type: :request do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end

    describe "micropost destruction" do
      before { FactoryGirl.create(:micropost, user: user) }

      describe "as correct user" do
        before { visit root_path }

        it "should delete a micropost" do
          expect { click_link "delete" }.to change(Micropost, :count).by(-1)
        end
      end
    end

    describe "pagination micropost" do
      before do 
        50.times { FactoryGirl.create(:micropost, user: user) } 
        visit root_path
      end
      after { User.delete_all }


      it { should have_selector('div.pagination') }

      it "should list each microposts" do
        user.microposts.paginate(page: 1).each do |post|
          expect(page).to have_selector('span', text: "Lorem ipsum")
        end
      end
    end

    describe "test count symbol micropost)" do
      it { should have_selector('span', text: 140) }
    end
  end

  describe "no view delete micropost links other" do
    let(:user2) { FactoryGirl.create(:user) }
    it { should_not have_link('delete') }

    it do 
      user_path user2
      should_not have_link('delete') 
    end
  end 
end

