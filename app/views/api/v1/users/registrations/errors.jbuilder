records = [@user].compact
json.partial! 'api/v1/shared/errors', records: records