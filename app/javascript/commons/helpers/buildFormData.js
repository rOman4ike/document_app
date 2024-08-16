// Object.fromEntries(params.entries())
const isObject = (value) => {
  return Object(value) === value && !Array.isArray(value)
}

export function mergeFormData(...args) {
  const finalFormData = new FormData()
  for (let i = 0; i < args.length; i++) {
    for (let pair of args[i].entries()) {
      finalFormData.append(pair[0], pair[1]);
    }
  }
  return finalFormData
}

export function buildFormData(formData, data, parentKey, recursion = false) {
  if (!Object.keys(data).length && !recursion) {
    formData.append(parentKey + '[null]', true)
  }
  if (data && isObject(data) && !(data instanceof File) && !(data instanceof Date)) {
    Object.keys(data).forEach(key => {
      buildFormData(formData, data[key], parentKey ? `${parentKey}[${key}]` : key, true);
    });
  } else {
    const value = data == null ? '' : data;
    formData.append(parentKey, value);
  }
  return formData
}