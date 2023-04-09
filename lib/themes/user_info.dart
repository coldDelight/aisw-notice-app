class UserInfo {
  static String user_id = "";
  static String name = "";
  static String department = "";
  static String grade = "";
  static String accept = "";
  static String psuh_accept = "";

  // "iat": "",
  // "exp": "",
  // "iss": ""

  UserInfo(data) {
    user_id = data['STUDENT_ID'];
    name = data['NM'];
    department = data['DEPT_NM'];
    grade = data['SCHYR'];
    // accept= data['accept'];
  }
  void setEmpty() {
    user_id = "";
    name = "";
    department = "";
    grade = "";
    accept = "";
    psuh_accept = "";
  }



  void setPushAccept(String accept) {
    psuh_accept = accept;
  }
}