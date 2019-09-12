require 'pg'

class Bookmarks
  attr_reader :id, :title, :url

  def initialize( id:, title:, url: )
    @id = id
    @title = title
    @url = url
  end

  def self.all
      conn = connect_database

      result = conn.exec('select * from bookmarks')
      result.map do |bookmark|
        Bookmarks.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
      end
  end

  def self.create(title: , url:)
    conn = connect_database

    result = conn.exec("INSERT INTO bookmarks (url,title) VALUES ('#{url}','#{title}') RETURNING id, url, title")
    Bookmarks.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:)
    conn = connect_database
    conn.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, url:, title:)
    conn = connect_database
    res = conn.exec("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = '#{id}' RETURNING id, url, title;")
    Bookmarks.new(id: res[0]['id'], title: res[0]['title'], url: res[0]['url'])
  end

  private

  def self.connect_database
    if ENV['ENVIRONMENT'] == 'test'
        conn = PG.connect(dbname: 'bookmark_manager_test')
    else
        conn = PG.connect(dbname: 'bookmark_manager')
    end
  end
end
