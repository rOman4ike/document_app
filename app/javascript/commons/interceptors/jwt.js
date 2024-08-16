/**
 * Load JWT from Local Storage on Refresh.
*/

export function loadJWT() {
  let localAuthToken = localStorage.auth_token;
  let cookieExists = localAuthToken !== "undefined" && localAuthToken !== null;
  if (cookieExists) {
    const auth_token = localStorage.getItem("auth_token");
    const authTokenExists = auth_token !== "undefined" && auth_token !== null;
    if (authTokenExists) {
      store.dispatch("session/loginUserWithToken", { auth_token });
    }
  }
}
