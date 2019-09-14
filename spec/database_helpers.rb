require 'pg'

def persisted_data(table:, id:)
  conn = PG.connect(dbname: 'bookmark_manager_test')
  res = DatabaseConnection.query("SELECT * FROM #{table} WHERE id = #{id};")
  res.first
end
