# frozen_string_literal: true

RSpec.describe Spree::Admin::ProductsController, type: :controller do
  stub_authorization!

  let(:user) { create(:user) }
  let!(:product) { create(:product) }

  before { stub_authentication! }

  context 'related' do
    it 'is not routable' do
      get :related, params: { id: product.id }
      expect(response.status).to be(200)
    end

    it 'responds to model_class as Spree::Relation' do
      expect(controller.send(:model_class)).to eq Spree::Product
    end
  end
end
