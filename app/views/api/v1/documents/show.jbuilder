json.document do
  json.(@document, *Document.column_names)
  json.doc_tags @document.doc_tags.map(&:convert_to_json)
  json.document_activity_areas @document.activity_areas
  json.kind I18n.t("document.kind.#{@document.kind}")
  json.state I18n.t("document.state.#{@document.state}")
end

document_file = @document.current_document_file
json.document_file do
  json.file_file_name document_file.file_file_name
  json.url document_file.file.url
end

if @document.initial_order.present?
  json.initial_order do
    json.(@document.initial_order, *InitialOrder.column_names)
    json.url @document.initial_order.file.url
  end
end

change_order = @document.change_orders.last
if change_order.present?
  json.change_order do
    json.call(change_order, :id, :change_date, :number)
    json.url change_order.file.url
  end
end

if can? :manage, Document
  json.versions @document.document_changes
end

if can? :show_history, DocumentFile
  document_files = @document.document_files.sort
  json.document_files do
    document_files.each_cons(2).map do |next_documemt_file, previous_documemt_file|
      next if next_documemt_file.state == 'deleted'
      json.child! do
        json.(next_documemt_file, *DocumentFile.column_names)
        json.url next_documemt_file.file.url
        json.replaced_file_file_name previous_documemt_file.file_file_name
      end
    end
  end
end

if can? :manage, ChangeOrder
  change_orders = @document.change_orders.sort
  json.change_orders do
    change_orders.each_cons(2).map do |next_change_order, previous_change_order|
      next if next_change_order.state == 'deleted'
      json.child! do
        json.(next_change_order, *ChangeOrder.column_names)
        json.url next_change_order.file.url
        json.replaced_number previous_change_order.number
      end
    end
  end
end
