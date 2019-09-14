require 'database_helpers'
require 'comment'
require 'bookmarks'

describe Comment do
  it '.create' do
    bookmark = Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers Academy")
    comment = Comment.create(text: 'This is a test comment', bookmark_id: bookmark.id)

    persisted_data = persisted_data(table: 'comments', id: comment.id)

    expect(comment).to be_a Comment
    expect(comment.id).to eq persisted_data['id']
    expect(comment.text).to eq 'This is a test comment'
    expect(comment.bookmark_id).to eq bookmark.id
  end

  it '.where' do
    bookmark = Bookmarks.create(url: "http://www.makersacademy.com", title: "Makers Academy")
    Comment.create(text: 'This is a test comment', bookmark_id: bookmark.id)
    Comment.create(text: 'This is a second test comment', bookmark_id: bookmark.id)

    comments = Comment.where(bookmark_id: bookmark.id)
    comment = comments.first
    persisted_data = persisted_data(table: 'comments', id: comment.id)

    expect(comments.length).to eq 2
    expect(comment.id).to eq persisted_data['id']
    expect(comment.text).to eq 'This is a test comment'
    expect(comment.bookmark_id).to eq bookmark.id
  end
end
