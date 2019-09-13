require './app'

feature 'adding bookmarks' do
  scenario 'user can add a bookmark' do
    visit '/bookmarks'
    fill_in('url', with: 'http://www.testbookmark.com')
    fill_in('title', with: 'Test Bookmark')
    click_button('Submit')

    expect(page).to have_link('Test Bookmark', href: 'http://www.testbookmark.com')
  end

  scenario 'bookmark must be a valid URL' do
    visit '/bookmarks'
    fill_in('url', with: 'not a real bookmark')
    click_button('Submit')

    expect(page).not_to have_content 'not a real bookmark'
    expect(page).to have_content 'Please submit a valid URL'
  end
end
