class ItemsCreator
  def self.bulk_create(model_name, items, additonal_params = nil)
    model = model_name.to_s.classify.constantize
    model.bulk_insert(set_size: 100) do |worker|
      items.each do |attrs|
        next unless valid?(model, attrs)
        attrs.merge!(additonal_params) if additonal_params
        worker.add(attrs)
      end
    end
  end

  def self.valid?(model, data)
    model.new(data).valid?
  end
end
