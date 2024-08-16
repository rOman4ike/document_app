# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all

    return unless user
  end

  def to_list
    rules.map do |rule|
      object = {
        actions: rule.actions,
        models: rule.subjects.map{ |s| s.is_a?(Symbol) ? s : s.name }
      }
      object[:conditions] = rule.conditions unless rule.conditions.blank?
      object[:attributes] = rule.attributes unless rule.attributes.blank?
      object[:inverted] = true unless rule.base_behavior
      object
    end
  end
end
