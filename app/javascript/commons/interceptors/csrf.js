import axios from "axios";

export function setCSRFToken() {
  axios.interceptors.request.use(function(config) {
    const token = document.querySelector("meta[name='csrf-token']")?.getAttribute('content')
    config.headers.set('X-CSRF-TOKEN', token)
    return config
  })
}