require './app'

feature 'adding bookmarks' do
  scenario 'user can add a bookmark' do
    visit '/bookmarks'
    fill_in('url', with: 'http://www.testbookmark.com')
    fill_in('title', with: 'Test Bookmark')
    click_button('Submit')

    expect(page).to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
  end
end
