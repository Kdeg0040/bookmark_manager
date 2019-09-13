require './lib/bookmarks.rb'
require 'pg'

describe Bookmarks do
  it '.all' do
    conn = PG.connect(dbname: 'bookmark_manager_test')

    bookmark = Bookmarks.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    Bookmarks.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
    Bookmarks.create(url: 'http://www.google.com', title: 'Google')

    bookmarks = Bookmarks.all
    expect(bookmarks.length).to eq 3
    expect(bookmarks.first).to be_a Bookmarks
    expect(bookmarks.first.id).to eq bookmark.id
    expect(bookmarks.first.title).to eq 'Makers Academy'
    expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
  end

  it '.create' do
    Bookmarks.create(title: 'Test Page', url: 'http://www.testpage.com')
    bookmarks = Bookmarks.all
    expect(bookmarks.first.title).to include('Test Page')
    expect(bookmarks.first.url).to include("http://www.testpage.com")
  end

  it '.delete' do
    bookmark = Bookmarks.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
    Bookmarks.delete(id: bookmark.id)
    expect(Bookmarks.all.length).to eq 0
  end

  it '.comments' do
    bookmark = Bookmarks.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
    DatabaseConnection.query("INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test comment', #{bookmark.id})")

    comment = bookmark.comments.first

    expect(comment['text']).to eq 'Test comment'
  end
end
