class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do 
    redirect '/recipes'
  end 

  get '/recipes/new' do 
    erb :new 
  end
  
  get '/recipes' do 
    @recipe = Recipes.all 
    erb :index 
  end 
  
  post '/recipes' do 
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    @recipe.save 
    redirect "/recipes#{@recipe.id}"
  end 
  
  get '/recipes/:id' do 
    @recipe = Recipes.find_by(params[:id])
    erb :show 
  end 
  
  get '/recipes/:id/edit' do 
    @recipe = Recipes.find_by(params[:id])
    erb :edit 
  end 
  
  patch '/recipes/:id' do
    @recipe = Recipes.find_by(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save 
    redirect to "/recipes/#{@recipe.id}"
  end 

end 
