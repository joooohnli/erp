package security.license;
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

import javax.servlet.*;
import java.io.* ;
import include.right.*;
import include.tree_index.Nseer;
import include.nseer_db.*;
import include.nseer_cookie.*;

public class register_module_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session=request.getSession();
try{
nseer_db_backup1 db = new nseer_db_backup1(dbApplication);
Nseer n=new Nseer();
InsMod im=new InsMod();
String human_name=request.getParameter("human_name");
String human_ID=request.getParameter("human_ID");
String choose_value_group=request.getParameter("choose_value_group");
String dbase=request.getParameter("dbase");
String module=request.getParameter("module");
	session.setAttribute("module",module);
String[] file_id=request.getParameterValues("file_id");
if(file_id==null){	
  	response.sendRedirect("security/license/register_module_ok_a.jsp?human_ID="+human_ID+"&&human_name="+toUtf8String.utf8String(exchange.toURL(human_name))+"&&choose_value_group="+toUtf8String.utf8String(exchange.toURL(choose_value_group)));
	}else{
if(db.conn((String)dbSession.getAttribute("unit_db_name"))){
db.executeUpdate("delete from "+dbase+"_view where module_name!='all' and human_ID='"+human_ID+"'");
for(int i=0;i<file_id.length;i++){
	im.insert(dbase,human_ID,human_name,file_id[i],db);
	im.insertw(dbase,module,human_ID,db);
}
db.commit();
db.close();
choose_value_group=choose_value_group+dbase+",";
response.sendRedirect("security/license/register_module_ok_b.jsp?human_ID="+human_ID+"&&human_name="+toUtf8String.utf8String(exchange.toURL(human_name))+"&&choose_value_group="+toUtf8String.utf8String(exchange.toURL(choose_value_group)));
}else{
response.sendRedirect("error_conn.htm");
}
	}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}