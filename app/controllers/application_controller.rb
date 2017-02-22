require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  # setting up where to look for views and publick folder
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end


  get '/posts' do
    @posts= Post.all
    erb :index
  end

  post '/posts' do
    @new_post=Post.create(name: params[:post][:name], content: params[:post][:content])

    redirect to '/posts'
  end



  get '/posts/:id' do
    @post=Post.find_by(id: params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    # binding.pry
    @post=Post.find_by_id(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post= Post.find_by_id(params[:id])
    @post.name= params[:post][:name]
    @post.content=params[:post][:content]
    @post.save
    redirect to "/posts/#{@post.id}"
  end

  delete '/posts/:id/delete' do
    @post=Post.find_by_id(params[:id])
    @post.destroy
    erb :deleted
  end




end
