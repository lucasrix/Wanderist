class Response
  include ActiveModel::Serialization

  attr_reader :status, :data, :error

  def initialize(data = nil)
    @error_messages = []
    @details = {}
    prepare(data) if data
  end

  def attributes
    {
      'status' => status,
      'data' => @data,
      'error' => error
    }
  end

  def prepare(data)
    set_data_serializer(data)
    set_errors(data)
  end

  def error
    result = {}
    result['error_messages'] = @error_messages unless @error_messages.empty?
    result['details'] = @details unless @details.empty?
    result
  end

  def status
    if success?
      'success'
    else
      'error'
    end
  end

  def add_error_message(msg)
    @error_messages << msg
  end

  def success?
    @error_messages.empty? and @details.empty?
  end

  private
  def get_element_serializer(collection)
    if collection.exists?
      ActiveModel::Serializer.serializer_for(collection.first)
    else
      "#{collection.model.name}Serializer".constantize
    end
  end

  def set_data_serializer(data)
    serializer = ActiveModel::Serializer.serializer_for(data)
    raise "Serializer not found for #{data.class.name}" unless serializer
    @data = serializer.new(data)
    if data.is_a?(ActiveRecord::Relation)
      element_serializer = get_element_serializer(data)
      @data.root = element_serializer.root_name.pluralize
    end
  end

  def set_errors(data)
    if data.is_a?(ActiveRecord::Base)
      unless data.valid?
        @error_messages << data.errors.full_messages
        @details.merge! data.errors.to_hash
      end
    end
  end

end