package draft.manufacture;
 
 
import include.nseer_cookie.counter;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class designModule_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);

try{
if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String design_ID=request.getParameter("design_ID") ;
String product_ID=request.getParameter("product_ID");
String module_design_ID="";
	String sql0="select * from design_module where product_ID='"+product_ID+"' and check_tag='1'";
	ResultSet rs0=design_db.executeQuery(sql0);
	if(rs0.next()){
		module_design_ID=rs0.getString("design_ID");
	}
	String sql1="select * from design_module_details where design_ID='"+module_design_ID+"' and design_balance_amount!='0'";
	ResultSet rs2=design_db.executeQuery(sql1);
	if(rs2.next()){
	response.sendRedirect("draft/manufacture/designModule_ok_a.jsp?design_ID="+design_ID+"");
}else{
	String sql2="";
		sql2="update manufacture_design_procedure set design_module_change_tag='1' where design_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql2);
	response.sendRedirect("draft/manufacture/designModule_ok_b.jsp?design_ID="+design_ID+"");
}
  design_db.commit();
  manufacture_db.commit();
  design_db.close();
	manufacture_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 