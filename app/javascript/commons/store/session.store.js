import Vue from "vue";
import axios from "axios";

// const BASE_URL = "http://localhost:5100/";

export const sessionStore = {
  state: {
    auth_token: null,
    session: {},
    user: {
      id: null,
      username: null,
      email: null
    }
  },
  mutations: {
    SET_SESSION_PROPERTY(state, { key, value }) {
      Vue.set(state.session, key, value)
    },
    SET_SESSION(state, session) {
      Vue.set(state, 'session', session)
    },
    SET_USER_INFO(state, data) {
      state.user = data.data.user;
      state.auth_token = data.headers.authorization;
      axios.defaults.headers.common["Authorization"] = data.headers.authorization;
      localStorage.setItem("auth_token", data.headers.authorization);
    },
    SET_USER_INFO_FROM_TOKEN(state, data) {
      state.user = data.data.user;
      state.auth_token = localStorage.getItem("auth_token");
    },
    RESET_USER_INFO(state) {
      state.user = {
        id: null,
        username: null,
        email: null,
      };
      state.auth_token = null;
      localStorage.removeItem("auth_token");
      axios.defaults.headers.common["Authorization"] = null;
    },
  },
  actions: {
    registerUser({ commit }, payload) {
      return new Promise((resolve, reject) => {
        axios
          .post(`users`, payload)
          .then((response) => {
            commit("SET_USER_INFO", response);
            resolve(response);
          })
          .catch(error => {
            if (error.response.data?.errors) {
              commit('error/SET_ERRORS', error.response.data.errors, { root: true })
              reject(error)
            }
          })
      });
    },
    loginUser({ commit }, payload) {
      new Promise((resolve, reject) => {
        axios
          .post(`users/sign_in`, payload)
          .then((response) => {
            commit("SET_USER_INFO", response);
            resolve(response);
          })
          .catch(error => {
            if (error.response.data?.errors) {
              commit('error/SET_ERRORS', error.response.data.errors, { root: true })
              reject(error)
            }
          })
      });
    },
    logoutUser({ commit, state }) {
      const config = {
        headers: {
          authorization: state.auth_token,
        },
      };
      new Promise((resolve, reject) => {
        axios
          .delete(`users/sign_out`, config)
          .then(() => {
            commit("RESET_USER_INFO");
            resolve();
          })
          .catch((error) => {
            reject(error);
          });
      });
    },
    loginUserWithToken({ commit }, payload) {
      const config = {
        headers: {
          Authorization: payload.auth_token,
        },
      };
      new Promise((resolve, reject) => {
        axios
          .get(`api/v1/member-data`, config)
          .then((response) => {
            commit("SET_USER_INFO_FROM_TOKEN", response);
            resolve(response);
          })
          .catch((error) => {
            reject(error);
          });
      });
    },
  },
  getters: {
    getAuthToken(state) {
      return state.auth_token;
    },
    getUserEmail(state) {
      return state.user?.email;
    },
    getUserID(state) {
      return state.user?.id;
    },
    isLoggedIn(state) {
      const loggedOut = state.auth_token == null || state.auth_token == JSON.stringify(null);
      return !loggedOut;
    }
  }
}
