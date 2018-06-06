require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @new_recipe = Recipe.create(params)
    redirect "/recipes/#{@new_recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(params)
    binding.pry
    redirect "/recipes/#{@recipe.id}"
  end

  post '/recipes' do
    Recipe.create(params)
    redirect '/recipes'
  end

  delete '/recipes/:id/delete' do
    Recipe.find(params[:id]).destroy
    redirect '/recipes'
  end

end
