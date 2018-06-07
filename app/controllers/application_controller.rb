class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #[R]Loads new form
  get '/recipes/new' do
    erb :new
  end

  #[C]reates new form
  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  #[R]loads show page
  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :show
  end

  #[R] edit form
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :edit
  end

  #[U]pdates a recipe
  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}" #DOES NOT WORK???
    # redirect '/recipes'
  end

  #[D]elete action
  post '/recipes/:id/delete' do
  # delete '/recipes/:id/delete' do  // DOES NOT WORK???
  @recipe = Recipe.destroy(params[:id])
  redirect '/recipes'
  end
end
