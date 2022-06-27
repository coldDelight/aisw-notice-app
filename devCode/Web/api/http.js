import axios from "axios";

const instance = axios.create({
   baseURL: "https://swnotice.hsu.ac.kr/api",
  // baseURL: "http://210.119.104.203:3000",

  withCredentials:true
  
});

export default instance;
