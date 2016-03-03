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
#  view_count :integer          default(0)
#

require "rails_helper"

RSpec.describe ArticlesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/articles").to route_to("articles#index")
    end

    it "routes to #new" do
      expect(:get => "/articles/new").to route_to("articles#new")
    end

    it "routes to #show" do
      expect(:get => "/articles/1").to route_to("articles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/articles/1/edit").to route_to("articles#edit", :id => "1")
    end

    it "routes to #search" do
      expect(:post => "/articles/search").to route_to("articles#search")
    end

    it "routes to #create" do
      expect(:post => "/articles").to route_to("articles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/articles/1").to route_to("articles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/articles/1").to route_to("articles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/articles/1").to route_to("articles#destroy", :id => "1")
    end
  end
end
