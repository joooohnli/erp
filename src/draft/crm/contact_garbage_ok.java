
package draft.crm;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_db.*;
import include.auto_execute.ContactExpiry;
import validata.ValidataTag;

public class contact_garbage_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;
public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


	try{
//实例化
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
ContactExpiry contactExpiry= new ContactExpiry();
ValidataTag   vt= new ValidataTag();
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String contact_ID=request.getParameter("contact_ID") ;
String reason=request.getParameter("reason");
String reasonexact=request.getParameter("reasonexact") ;
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=request.getParameter("customer_name") ;
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_ID=request.getParameter("contact_person_ID");
String contact_time=request.getParameter("contact_time") ;
String contact_type=request.getParameter("contact_type") ;
String checker=request.getParameter("checker") ;
String register_ID=request.getParameter("register_ID") ;

String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");

if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_contact","contact_ID",contact_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_contact","contact_ID",contact_ID,"check_tag").equals("9")){
try{
	String sql = "update crm_contact set contact_ID='"+contact_ID+"',reason='"+reason+"',reasonexact='"+reasonexact+"',customer_ID='"+customer_ID+"',customer_name='"+customer_name+"',person_contacted='"+person_contacted+"',person_contacted_tel='"+person_contacted_tel+"',contact_person='"+contact_person+"',contact_person_ID='"+contact_person_ID+"',contact_time='"+contact_time+"',contact_type='"+contact_type+"',contact_content='"+contact_content+"',checker='"+checker+"',check_tag='2' where contact_ID='"+contact_ID+"'" ;
		crm_db.executeUpdate(sql);
}
catch (Exception ex){
ex.printStackTrace();

}
 response.sendRedirect("draft/crm/contact_ok.jsp?finished_tag=3");//用户时候登陆过
}else{
	response.sendRedirect("draft/crm/contact_ok.jsp?finished_tag=4");//用户时候登陆过
	}

	crm_db.commit();
	crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
	}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
