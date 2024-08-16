initial_order = @document.initial_order
document_file = @document.document_files.last

json.document do
  json.(@document, *Document.column_names.excluding(['created_at', 'updated_at']))
  json.document_doc_tags @document.doc_tags_for_select
  json.document_activity_areas @document.activity_areas_for_select
end

if initial_order.present?
  json.initial_order do
    json.call(initial_order, :id, :initial_date, :number)
    json.url initial_order.file.url
  end
end

json.document_file do
  json.url document_file.file.url
end

json.activity_areas ActivityArea.available_activity_areas
json.available_document_kind_values Document.available_kinds_with_locales
json.available_document_state_values Document.available_states_with_locales
json.doc_tags DocTag.available_doc_tags