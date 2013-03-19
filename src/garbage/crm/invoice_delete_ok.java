

package garbage.crm;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;

public class invoice_delete_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String tableName=request.getParameter("tableName");
String ids_str=request.getParameter("ids_str");
String[] value1=ids_str.split("⊙");
for(int i=0;i<value1.length;i++){
	String id=value1[i];
	String sql="select invoice_gar_tag,order_id from "+tableName+" where id='"+id+"' and (invoice_check_tag='2' or invoice_gar_tag='1') and gar_tag='0'";
	ResultSet rs=qcs_db.executeQuery(sql);
	if(rs.next()){
		if(rs.getString("invoice_gar_tag").equals("1")){
			sql="delete from crm_ordering where reasonexact='"+rs.getString("order_id")+"'";
			qcs_db.executeUpdate(sql);
			sql="update crm_order set invoice_gar_tag='2' where id='"+id+"'";
			qcs_db.executeUpdate(sql);
		}else{
			sql="delete from crm_ordering where reasonexact='"+rs.getString("order_id")+"' and check_tag='0'";
			qcs_db.executeUpdate(sql);
			sql="update "+tableName+" set invoice_check_tag='1' where id='"+id+"'";
			qcs_db.executeUpdate(sql);
		}
}
out.println("1");
qcs_db.commit();
qcs_db.close();
}
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
		ex.printStackTrace();
	}
}
}