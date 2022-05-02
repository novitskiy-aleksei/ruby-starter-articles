require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'Article creation' do
    it 'can create valid article' do
      article = Article.create!(:title => 'ABCDEF', body: 'DEFGHIJKLM')
      expect(article.title).to eq('ABCDEF')
    end

    it 'cannot create article with short title' do
      expect { Article.create!(:title => 'ABC', body: 'DEFGHIJKLM') }
        .to raise_error(ActiveRecord::RecordInvalid)
              .with_message('Validation failed: Title is too short (minimum is 5 characters)')
    end

    it 'cannot create article with non-unique title' do
      Article.create!(:title => 'ABCDEF', body: 'DEFGHIJKLM')
      expect { Article.create!(:title => 'ABCDEF', body: 'DEFGHIJKLM') }
        .to raise_error(ActiveRecord::RecordInvalid)
              .with_message('Validation failed: Title has already been taken')
    end
  end
end
