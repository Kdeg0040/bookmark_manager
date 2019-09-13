feature 'adding and viewing comments' do
  feature 'a user can add and view a comment' do
    scenario 'a comment is added to a bookmark' do
      bookmark = Bookmarks.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

      visit '/bookmarks'
      click_button('add comment', match: :first)

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"\

      fill_in('comment', with: 'This is a test comment on this bookmark')
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(page).to have_content 'This is a test comment on this bookmark'
    end
  end
end
