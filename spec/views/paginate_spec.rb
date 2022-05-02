require 'rails_helper'

RSpec.describe 'pagination views' do
  it 'display paging links' do
    render '/paginate', {
      article: { title: 'ABC', body: 'DEF' },
      options: { current_page: 1, total_pages: 5 },
      controller: '/'
    }

    expect(rendered).to match /slicer/
    # render :plain => 'This is directly rendered'
    # expect(rendered).to match /directly rendered/
  end
end
