require 'sinatra/base'
require './lib/bookmarks.rb'

class BookmarkManager < Sinatra::Base
  get '/' do
    'BookmarkManager'
  end

  get '/bookmarks' do
    @bookmarks = Bookmarks.all
    erb(:bookmarks)
  end

  post '/bookmarks' do
    Bookmarks.create(title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
