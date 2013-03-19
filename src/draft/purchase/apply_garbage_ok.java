package draft.purchase;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;

public class apply_garbage_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
counter count=new counter(dbApplication);
try{

nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String apply_ID=request.getParameter("apply_ID");
String config_ID=request.getParameter("config_ID");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);

	String sql8 = "select * from purchase_apply where apply_ID='"+apply_ID+"' and (check_tag='5' or check_tag='9')" ;
	ResultSet rs8 = purchase_db.executeQuery(sql8) ;
	if(rs8.next()){
	String sql = "update purchase_apply set designer='"+designer+"',register='"+register+"',register_time='"+register_time+"',remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='2' where apply_ID='"+apply_ID+"'" ;
	purchase_db.executeUpdate(sql) ;
response.sendRedirect("draft/purchase/apply_ok.jsp?finished_tag=2");
	}else{
response.sendRedirect("draft/purchase/apply_ok.jsp?finished_tag=3");
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