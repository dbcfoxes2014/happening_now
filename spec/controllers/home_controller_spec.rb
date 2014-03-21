# require 'spec_helper'

# describe HomeController do
#   context "when searching for photos" do
#     it "displays a photo on the search results page" do
#       image = double(:image)
#       Pic.stub(:pic => pic)

#       post :search

#       expect(assigns(:pic)).to eq(pic)
#     end
#   end
# end





# ef search
#     @media = []
#     @search_content = params[:search_data]

#     for item in Instagram.tag_recent_media(@search_content)
#       if params[:commit] == "Search Photos"
#         if item.type == "image"
#           @media << item
#         end
#       elsif params[:commit] == "Search Videos"
#         if item.videos
#           @media << item
#         end
#       elsif params[:commit] == "Search Both"
#         @media << item
#       end
#     end


# context "after completing sign up" do
#   it "makes the user available to the view" do
#     user = double(:user)
#     User.stub(:user => user)

#     get :root

#     expect(assigns(:user)).to eq(user)
#   end
# end
# end