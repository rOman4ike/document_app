function objectToArray(object) {
  return Object.keys(object).map((key) => [key, object[key]]);
}

function checkAction(checkedAction, userAction) {
  userAction = userAction.toLowerCase()
  return userAction == 'manage' || userAction == checkedAction
}

function checkModel(checkedModel, userModel) {
  userModel = userModel.toLowerCase()
  return userModel == 'all' || userModel == checkedModel
}

function checkCondition(userConditions, record) {
  if (userConditions == undefined) return true
  const userConditionsArray = objectToArray(userConditions)
  return userConditionsArray.some(([key, value]) => {
    return record && record[key] && record[key] == value
  })
}

function isCan(checkedAction, checkedModel, abilities, record) {
  return abilities.some((ability) => {
    return ability.models.some(checkModel.bind(null, checkedModel)) &&
      ability.actions.some(checkAction.bind(null, checkedAction)) &&
      checkCondition(ability.conditions, record)
  })
}

export default {
  abilities: [],
  install(Vue, options) {
    const _this = this
    this.abilities = options
    Vue.prototype.$can = function(checkedAction, checkedModel, value) {
      return isCan(checkedAction, checkedModel, _this.abilities, value)
    }
    Vue.directive('can', {
      inserted(element, binding, vnode) {
        const action = Object.keys(binding.modifiers)[0]
        const model = Object.keys(binding.modifiers)[1]
        const record = binding.value
        if (!isCan(action, model, _this.abilities, record)) {
          element.remove()
        }
      }
    })
  },
  navigationGuard(redirectPath) {
    return function(to, from, next) {
      var subject = to.path.replace(/^\//, '').split('/')[0] || 'index';
      var action = to.path.replace(/^\//, '').split('/')[1] || 'index';
      console.log(subject, action);
      if (true) {
        next()
      } else {
        next(redirectPath)
      }
    }
  }
}