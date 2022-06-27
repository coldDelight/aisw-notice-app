import http from "./http";

export async function login(user_id, pwd) {
  // return http.post("/admin/login", { user_id, password }, );
  return http.post("/admin/loginOracle", { user_id, pwd }, );
}

export async function test() {
  return http.get("/event/all_event");
}