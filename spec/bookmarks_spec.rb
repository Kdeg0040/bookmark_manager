require './lib/bookmarks.rb'
require 'pg'

describe Bookmarks do
  it '.all' do
    conn = PG.connect(dbname: 'bookmark_manager_test')
    conn.exec("INSERT INTO bookmarks (url,title) VALUES ('http://www.makersacademy.com','Makers Academy');")
    conn.exec("INSERT INTO bookmarks (url,title) VALUES('http://www.destroyallsoftware.com','Destroy All Software');")
    conn.exec("INSERT INTO bookmarks (url,title) VALUES('http://www.google.com','Google');")
    bookmarks = Bookmarks.all
    expect(bookmarks.length).to eq 3
    expect(bookmarks.first).to be_a Bookmarks
    expect(bookmarks.first.title).to eq 'Makers Academy'
    expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    # expect(bookmarks.first.id).to eq bookmarks.id
  end

  it '.create' do
    Bookmarks.create(title: 'Test Page', url: 'www.testpage.com')
    bookmarks = Bookmarks.all
    expect(bookmarks.first.title).to include('Test Page')
    expect(bookmarks.first.url).to include("www.testpage.com")
  end
end
