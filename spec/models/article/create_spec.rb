require 'rails_helper'
require 'spec_helper'

RSpec.describe Category, type: :model do
  describe '.create' do
    let(:category){
      create(:category)
    }

    let(:params) {
      ActionController::Parameters.new(
        {
         'title' => "测试标题",
         'summary' => "测试摘要文本",
         'content' => "测试内容xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
         'category_id' => category.id,
         'source_type' => SourceType::ORIGINA,
         'tags' => "1,2",
         'source' => "测试",
         'source_url' => "https://www.google.com",
         'attachment' => "xxxxxxxxx.jpg",
         'author_id' => 1,
         'author_name' => 'hpp'
       }
      )
    }

    it 'success' do
      rtn = Article.create(params)
      expect_success_result rtn
      article = Article.find_by_title(params['title'])
      expect(article).to_not be_nil
    end
  end
end
