require 'rails_helper'
require_relative "#{HELPER_PATH}/validate_helper"

RSpec.describe Article, type: :model do
  describe '.validate' do
    include ValidateHelper

    let(:validate_object) { FactoryGirl.build(:article) }

    it 'success' do
      expect(validate_object).to be_present
    end

    context 'present' do
      [
        ['title',         ErrorCode::ERR_ARTICLE_TITLE_CANNOT_BE_BLANK],
        ['source_type',  ErrorCode::ERR_ARTICLE_SOURCE_TYPE_CANNOT_BE_BLANK],
        ['category_id',  ErrorCode::ERR_ARTICLE_CATEGORY_ID_CANNOT_BE_BLANK],
        ['tags',          ErrorCode::ERR_ARTICLE_TAGS_CANNOT_BE_BLANK]
      ].each do |value|
        it value do
          valid_column_present validate_object, *value
        end
      end
    end

    context 'length' do
      [
        ['title',       64,   ErrorCode::ERR_ARTICLE_TITLE_THE_MAXIMUM_LENGTH_OF_64  ],
        ['source',      64,   ErrorCode::ERR_ARTICLE_SOURCE_THE_MAXIMUM_LENGTH_OF_64  ],
        ['source_url', 128,  ErrorCode::ERR_ARTICLE_SOURCE_URL_THE_MAXIMUM_LENGTH_OF_128  ],
        ['tags',        64,   ErrorCode::ERR_ARTICLE_TAGS_THE_MAXIMUM_LENGTH_OF_64  ],
        ['summary',     255,  ErrorCode::ERR_ARTICLE_SUMMARY_THE_MAXIMUM_LENGTH_OF_255  ],
        ['attachment', 128,   ErrorCode::ERR_ARTICLE_ATTACHMENT_THE_MAXIMUM_LENGTH_OF_128  ]
      ].each do |value|
        it value do
          valid_column_length validate_object, *value
        end
      end

      context 'range' do
        [
          ['source_type', SourceType.const_values, ErrorCode::ERR_ARTICLE_SOURCE_TYPE_INVALID ],
          ['status',      ArticleStatus.const_values, ErrorCode::ERR_ARTICLE_STATUS_INVALID ]
        ].each do |value|
          it value do
            valid_column_range validate_object, *value
          end
        end
      end

    end
  end
end
