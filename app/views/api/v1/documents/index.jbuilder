json.documents do
  json.array! @documents do |document|
    json.(document, *Document.column_names)
    json.document_file do
      json.url document.document_files.last.file.url
    end
    json.doc_tags document.doc_tags.map(&:convert_to_json)
    json.activity_areas document.activity_areas
    json.initial_order document.initial_order if document.initial_order.present?
    json.change_order document.change_orders.last if document.change_orders.present?
  end
end

json.activity_areas ActivityArea.available_activity_areas
json.available_document_kind_values Document.available_kinds_with_locales
json.available_document_state_values Document.available_states_with_locales
json.doc_tags DocTag.available_doc_tags

json.partial! 'api/v1/shared/pagination_info',
  resources: @documents,
  pagy: @pagy