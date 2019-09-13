require 'pg'
require 'uri'

class Bookmarks
  attr_reader :id, :title, :url

  def initialize( id:, title:, url: )
    @id = id
    @title = title
    @url = url
  end

  def self.all
      conn = connect_database

      res = DatabaseConnection.query('select * from bookmarks')
      res.map do |bookmark|
        Bookmarks.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
      end
  end

  def self.create(title: , url:)
    conn = connect_database

    return false unless is_url?(url)
    res = DatabaseConnection.query("INSERT INTO bookmarks (url,title) VALUES ('#{url}','#{title}') RETURNING id, url, title")
    Bookmarks.new(id: res[0]['id'], title: res[0]['title'], url: res[0]['url'])
  end

  def self.delete(id:)
    conn = connect_database
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, url:, title:)
    conn = connect_database
    res = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = '#{id}' RETURNING id, url, title;")
    Bookmarks.new(id: res[0]['id'], title: res[0]['title'], url: res[0]['url'])
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def self.connect_database
    if ENV['ENVIRONMENT'] == 'test'
        conn = DatabaseConnection.setup('bookmark_manager_test')
    else
        conn = DatabaseConnection.setup('bookmark_manager')
    end
  end
end
