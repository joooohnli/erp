package draft.manufacture;
 
 
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class apply_toGar_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 draft_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 draft_db1 = new nseer_db_backup1(dbApplication);

PrintWriter out=response.getWriter();
try{
if(draft_db.conn((String)dbSession.getAttribute("unit_db_name"))&&draft_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String tableName=request.getParameter("tableName");
String ids_str=request.getParameter("ids_str");
String[] value1=ids_str.split("⊙");
for(int i=0;i<value1.length;i++){
	String id=value1[i];
	String sql1="select apply_ID from "+tableName+" where apply_ID='"+id+"'";
	ResultSet rs=draft_db.executeQuery(sql1);
	while(rs.next()){
		sql1="update "+tableName+" set check_tag='2' where apply_ID='"+id+"'";
		draft_db1.executeUpdate(sql1);
	}
}
out.println("1");
draft_db.commit();
draft_db1.commit();
draft_db.close();
draft_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
		ex.printStackTrace();
	}
}
}