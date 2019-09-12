feature 'updating a bookmark' do
  scenario 'user can update a bookmark' do
    bookmarks = Bookmarks.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')

    click_button('edit', match: :first)

    expect(current_path).to eq "/bookmarks/#{bookmarks.id}/edit"
    fill_in('url', with: 'http://www.testpage.com')
    fill_in('title', with: 'Test Page')
    click_button('Update Bookmark')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Test Page', href: 'http://www.testpage.com')
  end
end
