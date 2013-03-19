package garbage.manufacture;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;

public class querySendToGar_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 garbage_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
if(garbage_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String tableName=request.getParameter("tableName");
String ids_str=request.getParameter("ids_str");
String[] value1=ids_str.split("⊙");
for(int i=0;i<value1.length;i++){
	String id=value1[i];
	String sql="update "+tableName+" set module_gar_tag='1' where design_ID='"+id+"'";
		garbage_db.executeUpdate(sql);
}
out.println("1");
garbage_db.commit();
garbage_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
		ex.printStackTrace();
	}
}
}