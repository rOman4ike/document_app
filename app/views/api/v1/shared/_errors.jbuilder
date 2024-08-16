json.errors do
  records.each do |record|
    json.set! record.class.name.underscore do
      record.errors.attribute_names.each do |attribute_name|
        key = attribute_name.to_s.split('.')[0]
        json.set! key, record.errors.messages_for(attribute_name)
      end
    end
  end
end