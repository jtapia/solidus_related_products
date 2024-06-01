# frozen_string_literal: true

module Spree
  module Admin
    class RelationTypesController < ResourceController
      # def create
      #   invoke_callbacks(:create, :before)
      #   @object.attributes = permitted_resource_params

      #   if @object.save
      #     invoke_callbacks(:create, :after)
      #     flash[:success] = flash_message_for(@object, :successfully_created)
      #     respond_with(@object) do |format|
      #       format.html { redirect_to location_after_save }
      #       format.js   { render layout: false }
      #     end
      #   else
      #     invoke_callbacks(:create, :fails)
      #     respond_with(@object) do |format|
      #       format.html do
      #         flash.now[:error] = @object.errors.full_messages.join(", ")
      #         render_after_create_error
      #       end
      #       format.js { render layout: false }
      #     end
      #   end
      # end

      private

      def location_after_save
        spree.admin_relation_types_path
      end
    end
  end
end
