require './config/environment'
class ApplicationController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/") }
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


#CREATE
  get '/recipes/new' do
    erb :new
  end


#INDEX/READ
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end



#READ
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

#UPDATE
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

#UPDATE
  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

#CREATE
  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end


#DELETE
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

end
