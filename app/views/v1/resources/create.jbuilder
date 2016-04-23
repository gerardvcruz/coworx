unless @data.nil?
  @resource_data = @data.attributes

  unless @includes.blank?
    @includes.each do |key, value|
      @resource_data["#{key}"] = value
    end
  end

  if @data.class.try("attachment_definitions")
    @data.class.attachment_definitions.each do |k, v|
      if url = @data.try("#{k}").url
        @resource_data["#{k.to_s}_url"] = url
      end
    end
  end

  json.set! @resource_name, @resource_data
end

json.status 'success'
