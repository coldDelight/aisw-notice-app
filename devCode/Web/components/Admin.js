// components
// import AdminNavbar from "components/Navbars/AdminNavbar.js";
import cookies from "next-cookies";
import Footer from "./Footers/Fotter";
import Sidebar from "./Sidebar";
// import HeaderStats from "components/Headers/HeaderStats.js";
// import FooterAdmin from "components/Footers/FooterAdmin.js";

export default function Admin({ children }) {
  const onSubmitAll = (event) => {
    event.preventDefault();
  };
  return (
    <>
      <div onSubmit={onSubmitAll}>
        <Sidebar />
      </div>
      <div className="relative md:ml-64 bg-slate-200">
        {/* <AdminNavbar /> */}
        {/* Header */}
        {/* <HeaderStats /> */}
        <div className="px-4 md:px-10 mx-auto w-full -m-24">
          <div className="min-h-screen">{children}</div>
          <Footer />
          {/* <FooterAdmin /> */}
        </div>
      </div>
    </>
  );
}

Admin.getInitialProps = async (ctx) => {
  const { admin } = cookies(ctx);
  if (!admin || admin === "") {
    if (ctx.req && ctx.res) {
      ctx.res.writeHead(302, { Location: "/" });
      ctx.res.end();
    } else {
      Router.push("/");
    }
  }
  return { admin };
};
