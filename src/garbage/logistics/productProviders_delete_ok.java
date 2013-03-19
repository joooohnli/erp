

package garbage.logistics;
 
 
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

public class productProviders_delete_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String product_id="";
String tableName=request.getParameter("tableName");
String ids_str=request.getParameter("ids_str");
String[] value1=ids_str.split("⊙");
for(int i=0;i<value1.length;i++){	
	String id=value1[i];
	String sql = "select id,product_id from "+tableName+" where id='"+id+"' and (check_tag='2' or gar_tag='1')";
	ResultSet rs = logistics_db.executeQuery(sql);
	if(rs.next()){
		product_id=rs.getString("product_id");
		
	String sqll="delete from "+tableName+" where id='"+id+"'";
	logistics_db.executeUpdate(sqll);

	}
	sql="update design_file set recommend_logistics_tag='0' where product_id='"+product_id+"'";
		logistics_db.executeUpdate(sql);
}
out.println("1");
logistics_db.commit();
logistics_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
		ex.printStackTrace();
	}
}
}