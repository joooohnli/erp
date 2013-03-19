

package garbage.purchase;
 
 
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
	String sql="select invoice_gar_tag,purchase_id from "+tableName+" where id='"+id+"' and (invoice_check_tag='2' or invoice_gar_tag='1') and gar_tag='0'";
	ResultSet rs=qcs_db.executeQuery(sql);
	if(rs.next()){
		if(rs.getString("invoice_gar_tag").equals("1")){//强制完成
			sql="delete from purchase_purchasing where purchase_id='"+rs.getString("purchase_id")+"'";
				qcs_db.executeUpdate(sql);
			sql="update "+tableName+" set invoice_gar_tag='3' where id='"+id+"'";//两边的记录不显示
				qcs_db.executeUpdate(sql);
		}else{//处理从垃圾箱过来的记录
			sql="delete from purchase_purchasing where purchase_id='"+rs.getString("purchase_id")+"' and check_tag='0'";
				qcs_db.executeUpdate(sql);
			sql="update "+tableName+" set invoice_check_tag='0' where id='"+id+"'";//重新进行发票信息的登记
				qcs_db.executeUpdate(sql);
		}
	}
}
out.println("1");
qcs_db.commit();
qcs_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
		ex.printStackTrace();
	}
}
}