require './app.rb'

feature 'viewing bookmarks' do
  scenario 'visiting the index page' do
    visit '/'
    expect(page).to have_content('Bookmark Manager')
  end

  scenario 'bookmarks are visible' do
    Bookmarks.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    Bookmarks.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
    Bookmarks.create(url: 'http://www.google.com', title: 'Google')

    visit '/bookmarks'

    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Destroy All Software',  href: 'http://www.destroyallsoftware.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end
end
