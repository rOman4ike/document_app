const isObject = (value) => {
  return Object(value) === value && !Array.isArray(value)
}

export function mapFields(base, property, mutation, fields) {
  const object = {};
  const path = base ? `${base}/${mutation}` : mutation
  if (isObject(fields)) {
    for (const field in fields) {
      object[field] = {
        get() {
          return this.$store.state[base][property][fields[field]];
        },
        set(value) {
          this.$store.commit(path, { key: [fields[field]], value: value });
        }
      }
    }
  } else {
    for (let x = 0; x < fields.length; x++) {
      const field = [fields[x]];
      object[field] = {
        get() {
          return this.$store.state[base][field];
        },
        set(value) {
          this.$store.commit(path, { key: [field], value: value });
        }
      };
    }
  }
  return object;
}