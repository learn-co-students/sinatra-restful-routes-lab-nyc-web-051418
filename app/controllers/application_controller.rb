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

  post '/recipes' do
    @recipe = Recipe.create(params)    
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipes = Recipe.find_by(id: params[:id])
    erb :show
  end

  delete '/recipes/:id/delete' do
    @recipes = Recipe.find_by(id: params[:id])    
    @recipes.delete
    erb :delete
  end

  get '/recipes/:id/edit' do
    @recipes = Recipe.find_by(id: params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipes = Recipe.find_by(id: params[:id])    
    @recipes.update(params)
    redirect to "/recipes/#{@recipe.id}"
  end





end