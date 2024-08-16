json.permissions @permissions do |permission|
  json.merge! permission.attributes
  json.text_role permission.text_role
  json.fullname permission.user_fullname
end