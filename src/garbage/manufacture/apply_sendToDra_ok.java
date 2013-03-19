package garbage.manufacture;
 
 
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

public class apply_sendToDra_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 garbage_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 garbage_db1 = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
if(garbage_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String tableName=request.getParameter("tableName");
String ids_str=request.getParameter("ids_str");
String gar_tag=request.getParameter("gar_tag");
String field=request.getParameter("field");
String ret_value="1";
String[] value1=ids_str.split("⊙");
if(garbage_db.conn((String)dbSession.getAttribute("unit_db_name"))&&garbage_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
	for(int i=0;i<value1.length;i++){
		String id=value1[i];
		String sqll="select "+field+" from "+tableName+" where apply_ID='"+id+"' and "+gar_tag;
		ResultSet rs=garbage_db.executeQuery(sqll);
		if(rs.next()){
			ret_value+="⊙"+rs.getString(field);
		}else{
			sqll="select apply_ID from "+tableName+" where apply_ID='"+id+"'";
			 rs=garbage_db.executeQuery(sqll);
				while(rs.next()){
			sqll="update "+tableName+" set check_tag='5',gar_tag='0' where apply_ID='"+id+"'";
			garbage_db1.executeUpdate(sqll);
				}
		}
	}
}else{
	for(int i=0;i<value1.length;i++){
		String id=value1[i];
		String sql1="select apply_ID from "+tableName+" where apply_ID='"+id+"'";
		ResultSet rs=garbage_db.executeQuery(sql1);
		while(rs.next()){
			sql1="update "+tableName+" set check_tag='5',gar_tag='0' where apply_ID='"+id+"'";
			garbage_db1.executeUpdate(sql1);
		}
	}
}
out.println(ret_value);
garbage_db.commit();
garbage_db1.commit();
garbage_db.close();
garbage_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
		ex.printStackTrace();
	}
}
}