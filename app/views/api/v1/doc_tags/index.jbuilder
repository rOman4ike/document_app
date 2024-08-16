json.doc_tags @doc_tags.sort_by(&:title)

json.partial! 'api/v1/shared/pagination_info',
  resources: @doc_tags,
  pagy: @pagy
