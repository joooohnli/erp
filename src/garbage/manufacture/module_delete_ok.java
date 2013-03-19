package garbage.manufacture;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;

public class module_delete_ok extends HttpServlet{

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
if(garbage_db.conn((String)dbSession.getAttribute("unit_db_name"))&&garbage_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String tableName=request.getParameter("tableName");
String ids_str=request.getParameter("ids_str");
String[] value1=ids_str.split("⊙");
for(int i=0;i<value1.length;i++){
	String id=value1[i];
	String sql="select product_id from "+tableName+" where design_id='"+id+"' and (design_module_tag='4' or module_gar_tag='1') and gar_tag='0'";
	ResultSet rs=garbage_db.executeQuery(sql);
	if(rs.next()){
		sql="update "+tableName+" set design_module_tag='0',module_gar_tag='0' where design_ID='"+id+"'";
			garbage_db.executeUpdate(sql);
		sql="delete from manufacture_design_procedure_module_details where design_ID='"+id+"'";
			garbage_db.executeUpdate(sql);
		sql="delete from manufacture_workflow where object_id='"+id+"' and type_id='02'";
			garbage_db.executeUpdate(sql);
		sql="select design_id from design_module where product_id='"+rs.getString("product_id")+"'";
		rs=garbage_db.executeQuery(sql);
		if(rs.next()){
			String design_id=rs.getString("design_id");
			sql="select amount from design_module_details where design_id='"+design_id+"'";
			rs=garbage_db.executeQuery(sql);
			while(rs.next()){
				sql="update design_module_details set design_balance_amount='"+rs.getString("amount")+"' where design_id='"+design_id+"'";
				garbage_db1.executeUpdate(sql);
			}
		}
	}
}
out.println("1");
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