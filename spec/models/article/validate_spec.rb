require 'rails_helper'
require_relative "#{HELPER_PATH}/validate_helper"

RSpec.describe Article, type: :model do
  describe '.validate' do
    include ValidateHelper

    let(:article) { create(:articles) }

    it 'success' do
      expect(article).to be_present
    end

    context 'present' do
      [
        ['title',       'article.error.title_blank'],
        ['source_type', 'article.error.source_type_blank'],
        ['category_id', 'article.error.category_id_blank'],
        ['tags',        'article.error.tags_blank'],
        ['author_id',   'article.error.author_id_blank'],
        ['author_name', 'article.error.author_name_blank']
      ].each do |value|
        it value do
          valid_column_present article, *value
        end
      end
    end

    context 'length' do
      [
        ['title',       64,   'article.error.title_length_over_64'  ],
        ['source',      64,   'article.error.source_length_over_64'  ],
        ['source_url', 128,   'article.error.source_url_length_over_128'  ],
        ['tags',        64,   'article.error.tags_length_over_64'  ],
        ['summary',     255,  'article.error.summary_length_over_255'  ]
      ].each do |value|
        it value do
          valid_column_length article, *value
        end
      end

      context 'range' do
        [
          ['source_type', SourceType.const_values, 'article.error.source_type_invalid' ],
          ['status',      ArticleStatus.const_values, 'article.error.status_invalid' ]
        ].each do |value|
          it value do
            valid_column_range article, *value
          end
        end
      end

      it 'tags format' do
        result = check_validate_object(article, 'tags' => 'java基础,Ruby On Rails')
        validate_errors_info result, article, 'tags'

        result = check_validate_object(article, 'tags' => 'java基础,Ruby On Rails:')
        validate_errors_info result, article, 'tags', 'article.error.tags_invalid'
      end
    end
  end
end
