class DiscoverResponse < Response

  include ActiveModel::Serialization

  def prepare(data)
    set_data_serializer(data)
  end

  def data
    {discovered: @data}
  end

  private

  def set_data_serializer(data)
    @opts.merge!(root: false)
    @data = data.map do |object|
      serializer = ActiveModel::Serializer.serializer_for(object)
      serializer.new(object, @opts)
    end
  end
end
