# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  before(:each) do
    @user = create(:user)
    @article = build(:article, user: @user)
    @params = ActionController::Parameters.new
    @params[:article] = {
        title: 'androidDeveloper',
        body: 'ruby on rails',
    }
  end

  ### INDEX ###
  describe "#index" do
    it "should return no articles" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:articles).length).to eq(0)
      expect(assigns(:title)).to eq('There is no article')
    end

    it "should return 3 articles" do
      3.times do
        create(:article, user: @user)
      end
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:articles).length).to eq(3)
      expect(assigns(:title)).to eq('All Articles')
    end

    it "should support markdown" do
      create(:article, user: @user)
      get(:show, id: "1")
      expect(assigns(:markdown).render("**no**")).to eq("<p><strong>no</strong></p>\n")
    end
  end

  ### SEARCH ###
  describe "#index" do
    it "should return no articles" do
      post :search, {title: ''}
      expect(response).to have_http_status(:success)
      expect(assigns(:articles).length).to eq(0)
      expect(assigns(:title)).to eq('There is no article')
    end

    it "should return 3 articles" do
      3.times do
        create(:article, user: @user)
      end
      post :search, {title: 'Android'}
      expect(response).to have_http_status(:success)
      expect(assigns(:articles).length).to eq(3)
      expect(assigns(:title)).to eq('Search result')
    end

    it "should support markdown" do
      post :search, {title: 'Android'}
      expect(assigns(:markdown).render("**no**")).to eq("<p><strong>no</strong></p>\n")
    end
  end

  ### CREATE ###
  describe "#create" do
    context "user not log in" do
      it "should redirect to login page" do
        post :create, product: @product
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before(:each) do
        sign_in @user
      end

      it "should redirect to new" do
        @params[:article][:title] = 'title'
        post :create, @params
        expect(response).to render_template(:new)
      end

      it "should redirect to the new article" do
        expect {
          post :create, @params
        }.to change(Article, :count).by(1)
        expect(response).to redirect_to(Article.first)
      end
    end
  end

  ### NEW ###
  describe "#new" do
    context "user not sign in" do
      it "should redirect to login page" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before(:each) do
        sign_in @user
      end

      it "should return success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

  ### SHOW ###
  describe "#index" do
    before(:each) do
      @article.save
    end

    it "should return success as guest" do
      get(:show, id: "1")
      expect(response).to have_http_status(:success)
    end

    it "should support markdown" do
      get(:show, id: "1")
      expect(assigns(:markdown).render("**no**")).to eq("<p><strong>no</strong></p>\n")
    end
  end

  ### EDIT ###
  describe "#edit" do
    before(:each) do
      @article.save
    end

    context "user not sign in" do
      it "should redirect to login page" do
        get(:edit, id: "1")
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before(:each) do
        sign_in @user
      end

      it "should return success" do
        get(:edit, id: "1")
        expect(response).to have_http_status(:success)
      end
    end
  end

  ### UPDATE ###
  describe "#update" do
    before(:each) do
      @article.save
    end

    context "user not sign in" do
      it "should redirect to login page" do
        post :create, product: @article
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before(:each) do
        sign_in @user
      end

      it "update success" do
        @params[:article][:title] = 'hello world'
        put :update, id: @article.id, article: @params[:article]
        expect(response).to redirect_to article_path(@article)
        expect(Article.first.title).to eq('hello world')
      end

      it "update fail should render edit" do
        @params[:article][:title] = ''
        put :update, id: @article.id, article: @params[:article]
        expect(response).to render_template(:edit)
      end
    end
  end

  ### DELETE ###
  describe "#delete" do
    before(:each) do
      @article.save
    end

    context "user not sign in" do
      it "should redirect to login page" do
        delete :destroy, id: @article
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before(:each) do
        sign_in @user
      end

      it "delete success" do
        delete :destroy, id: @article
        expect(response).to redirect_to articles_path
      end
    end
  end
end
