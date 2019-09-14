class Comment
  attr_reader :id, :text, :bookmark_id

  def initialize(id:, text:, bookmark_id:)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end

  def self.create(bookmark_id:, text:)
    res = DatabaseConnection.query("INSERT INTO comments (bookmark_id, text) VALUES ('#{bookmark_id}', '#{text}') RETURNING id, text, bookmark_id;")
    Comment.new(
      id: res[0]['id'],
      text: res[0]['text'],
      bookmark_id: res[0]['bookmark_id']
    )
  end

  def self.where(bookmark_id:)
    res = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{bookmark_id};")
    res.map do |comment|
      Comment.new(
        id: comment['id'],
        text: comment['text'],
        bookmark_id: comment['bookmark_id']
      )
    end
  end
end
