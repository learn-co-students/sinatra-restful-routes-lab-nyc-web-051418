require './config/environment'


class ApplicationController < Sinatra::Base

  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params['id'])
    erb :show
  end

  post '/recipes' do
    Recipe.create(name: params['name'], ingredients: params['ingredients'], cook_time: params['cook_time'])
    redirect '/recipes'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params['id'])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params['id'])
    @recipe.update(name: params['name'], ingredients: params['ingredients'], cook_time: params['cook_time'])
    erb :show
  end

  delete '/recipes/:id/delete' do
    Recipe.find_by(id: params['id']).destroy
    erb :delete
  end

end
