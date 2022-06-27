import http from "./http";

export async function store(title, content) {
  return http.post("notice", {
    title,
    content,
  });
}


export async function testAPI() {
  return http.get("event/all_event", {
  });
}


export async function noticeDetailAPI() {
  return http.get("event/all_event", {
  });
}

export async function deleteNotice(notice_id) {
  console.log(notice_id)

  return http.delete("notice/delete", {
    data:{
      notice_id
      }
  });
}

