# frozen_string_literal: true

module Spree
  module Admin
    class RelationsController < BaseController
      before_action :load_data, only: [:create, :destroy]

      respond_to :js, :html

      def create
        @relation = ::Spree::Relation.new(relation_params)
        @relation.relatable = @product
        @relation.related_to = @relation.relation_type.applies_to
                                        .constantize.find(relation_params[:related_to_id])
        @relation.save

        respond_with(@relation)
      end

      def update
        @relation = ::Spree::Relation.find(params[:id])
        if @relation.update(relation_params)
          flash[:success] = flash_message_for(@relation, :successfully_updated)
          redirect_to(related_admin_product_url(@relation.relatable))
        end
      end

      def update_positions
        params[:positions].each do |id, index|
          model_class.where(id: id).update_all(position: index)
        end

        respond_to do |format|
          format.js { render plain: 'Ok' }
        end
      end

      def destroy
        @relation = ::Spree::Relation.find(params[:id])
        if @relation.destroy
          flash[:success] = flash_message_for(@relation, :successfully_removed)

          respond_with(@relation) do |format|
            format.html { redirect_back(fallback_location: admin_product_path(@product)) }
            format.js   { render partial: "spree/admin/shared/destroy" }
          end

        else

          respond_with(@relation) do |format|
            format.html { redirect_back(fallback_location: admin_product_path(@product)) }
          end
        end
      end

      private

      def relation_params
        params.require(:relation).permit(*permitted_attributes)
      end

      def permitted_attributes
        [
          :related_to,
          :relation_type,
          :relatable,
          :related_to_type,
          :related_to_id,
          :discount_amount,
          :description,
          :relation_type_id,
          :position
        ]
      end

      def load_data
        @product = ::Spree::Product.friendly.find(params[:product_id])
      end

      def model_class
        ::Spree::Relation
      end
    end
  end
end
