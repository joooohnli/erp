package draft.purchase;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataNumber;
import include.nseer_cookie.counter;

public class invoice_garbage_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ValidataNumber validata=new ValidataNumber();
counter count=new counter(dbApplication);
String purchase_ID=request.getParameter("purchase_ID");
String sql8="select * from purchase_purchasing where purchase_ID='"+purchase_ID+"' and check_tag='0' and kind='发票' order by id";
ResultSet rs8=purchase_db.executeQuery(sql8);
if(rs8.next()){
	String sql4="update purchase_purchase set invoice_check_tag='2' where purchase_ID='"+purchase_ID+"'";
	purchase_db.executeUpdate(sql4);
	response.sendRedirect("draft/purchase/invoice_ok.jsp?finished_tag=2");
 }else{
	response.sendRedirect("draft/purchase/invoice_ok.jsp?finished_tag=3");
	}
	purchase_db.commit();	
	purchase_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}