module V1
  class ResourcesController < ApplicationController
    before_action :set_resource, only: [:destroy, :show, :update]

    load_and_authorize_resource

    # CREATE
    # POST /v1/{plural_resource_name}
    def create
      if set_resource(class_of_resource.new(resource_params)) && get_resource.save
        @data = get_resource

        render :create, status: :created
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    end

    # READ
    # GET /v1/{plural_resource_name}/1
    def show
      if @data = get_resource
        set_includes if params[:include]

        render :show, status: :ok
      else
        render error(:not_found), status: :no_content
      end
    end

    # UPDATE
    # PATCH/PUT /v1/{plural_resource_name}/1
    def update
      # separate update_slug from the if condition
      # update_slug returns false if resource being updated
      # has no slug attribute & returns 422 on patch requests
      if get_resource.update(resource_params)
        update_slug if get_resource.has_attribute?(:slug)
        @data = get_resource

        render :update, status: :ok
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    end

    # DELETE
    # DELETE /v1/{plural_resource_name}/1
    def destroy
      get_resource.destroy
      head :no_content
    end

    # INDEX
    # GET /v1/{plural_resource_name}
    def index
      plural_resource_name = "@#{resource_name.pluralize}"
      @resources =
        class_of_resource.where(query_params)
        .order(created_at: :desc)

      unless sort_params.empty?
        @resources = @resources.reorder(
          "#{sort_params[:sort_criteria]}
          #{sort_params[:sort_method]}")
      end

      @resources =
        @resources.page(page_params[:page]) # pagination
        .per(page_params[:page_size]) unless page_params.empty?

      instance_variable_set(plural_resource_name, @resources)

      render :index
    end

    private
      # returns the resource from the created instance variable
      # @return [Object]
      def get_resource
        instance_variable_get("@#{resource_name}")
      end

      # returns the allowed parameters for searching.
      # override this method in each API controller
      # to permit additional parameters to search on
      # @return [Hash]
      def query_params
        {}
      end

      def sort_params
        params.permit(:sort_criteria,:sort_method)
      end

      # returns the allowed parameters for pagination
      # @return [Hash]
      def page_params
        params.permit(:page, :page_size)
      end

      # the resource class based on the controller
      # @return [Class]
      def class_of_resource
        @class_of_resource ||= resource_name.classify.constantize
      end

      # the singular name for the resource class
      # based on the controller
      # @return [String]
      def resource_name
        @resource_name ||= self.controller_name.singularize
      end

      # only allow a trusted parameter "white list" through.
      # if a single resource is loaded for #create or #update,
      # then the controller for the resource must implement
      # the method "#{resource_name}_params" to limit permitted
      # parameters for the individual model.
      def resource_params
        @resource_params ||= self.send("#{resource_name}_params")
      end

      # use callbacks to share common setup
      # or constraints between actions.
      def set_resource(resource = nil)
        # find a resource by its friendly_id
        if class_of_resource.column_names.include?("slug")
          resource ||= class_of_resource.friendly.find(params[:id])
        else
          resource ||= class_of_resource.find_by_id(params[:id])
        end

        instance_variable_set("@#{resource_name}", resource)
      end

      # this sets the includes for a show object.
      # the purpose of this is so that you don't need to
      # do multiple REST calls to the API for multiple objects.
      def set_includes
        @data = get_resource.attributes

        # wrap sideloading in a ActiveRecord.transaction
        # because you can pass 'destroy' to the includes
        # which could destroy the resource
        get_resource.transaction do
          params[:include].split(",").each do |includes|
            @data["#{includes}"] = get_resource.try(includes)

            # reverts the transaction if resource
            # was deleted or changed
            if get_resource.destroyed? || get_resource.changed?
              @data.delete("#{includes}")
              raise ActiveRecord::Rollback
            end
          end
        end
      end

      # updates the slug of an object since friendly_id
      # v5.1 doesn't auto update the slug of an obj anymore
      def update_slug
        get_resource.slug = nil
        get_resource.save!
      end

      def error type
        "/v1/resources/errors/#{type}"
      end

  end
end
