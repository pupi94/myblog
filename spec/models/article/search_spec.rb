require 'rails_helper'
require 'spec_helper'

RSpec.describe Category, type: :model do
  describe '.search' do
    let(:params) {
      ActionController::Parameters.new()
    }

    before(:each) do
      create_list(:articles , 10, :title => 'test title')
      create_list(:articles , 10, :status => ArticleStatus::EDITING, :category_id => 2)
      create_list(:articles , 10, :status => ArticleStatus::SOLD_OUT)

      create_list(:articles , 5, :enabled => false)
    end

    it 'success' do
      rtn = Article.search(params)
      expect_success_result rtn
      expect(rtn['articles'].size).to eq DEFAULT_PAGE_SIZE
      expect(rtn['total_count']).to eq 30
    end

    it 'search by title' do
      params['title'] = 'test'
      rtn = Article.search(params)
      expect_success_result rtn
      expect(rtn['articles'].size).to eq 10
      expect(rtn['total_count']).to eq 10
    end

    it 'search by category' do
      params['category'] = 2
      rtn = Article.search(params)
      expect_success_result rtn
      expect(rtn['articles'].size).to eq 10
      expect(rtn['total_count']).to eq 10
    end

    it 'search by status' do
      params['status'] = ArticleStatus::SOLD_OUT
      rtn = Article.search(params)
      expect_success_result rtn
      expect(rtn['articles'].size).to eq 10
      expect(rtn['total_count']).to eq 10
    end
  end
end
