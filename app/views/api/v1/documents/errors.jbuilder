records = [@document, @document.document_files.first, @document.initial_order, @document.change_order].compact
json.partial! 'api/v1/shared/errors', records: records