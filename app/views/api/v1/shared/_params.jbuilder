json.abilities current_ability.to_list

json.user do
  json.id current_user&.id
  json.fullname current_user&.email
end
