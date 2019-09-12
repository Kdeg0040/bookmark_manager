require 'sinatra/base'
require './lib/bookmarks.rb'
require './lib/database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb(:homepage)
  end

  get '/bookmarks' do
    @bookmarks = Bookmarks.all
    erb(:bookmarks)
  end

  post '/bookmarks/new' do
    Bookmarks.create(title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmarks.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark_id = params[:id]
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmarks.update(id: params[:id], title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
