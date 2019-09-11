require 'pg'
class Bookmarks
  attr_reader :id, :title, :url

  def self.all
      #bookmarks_array = []
      if ENV['ENVIRONMENT'] == 'test'
          conn = PG.connect(dbname: 'bookmark_manager_test')
      else
          conn = PG.connect(dbname: 'bookmark_manager')
      end
      result = conn.exec('select * from bookmarks')
      result.map do |bookmark|
        Bookmarks.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
      end

      #bookmarks_array
  end

  def self.create(title: , url:)
    if ENV['ENVIRONMENT'] == 'test'
        conn = PG.connect(dbname: 'bookmark_manager_test')
    else
        conn = PG.connect(dbname: 'bookmark_manager')
    end
    conn.exec("INSERT INTO bookmarks (url,title) VALUES ('#{url}','#{title}') RETURNING id, url, title")
  end

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end
end
