package draft.logistics;
 
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataTag;

public class contact_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);

if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataTag vt=new ValidataTag();

String contact_ID=request.getParameter("contact_ID") ;
String reason=request.getParameter("reason") ;
String reasonexact=request.getParameter("reasonexact") ;
String provider_ID=request.getParameter("provider_ID") ;
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_ID=request.getParameter("contact_person_ID") ;
String contact_time=request.getParameter("contact_time") ;
String contact_type=request.getParameter("contact_type") ;
String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");

if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"logistics_contact","contact_ID",contact_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"logistics_contact","contact_ID",contact_ID,"check_tag").equals("9")){
	String sql = "update logistics_contact set contact_ID='"+contact_ID+"',reason='"+reason+"',reasonexact='"+reasonexact+"',provider_ID='"+provider_ID+"',person_contacted='"+person_contacted+"',person_contacted_tel='"+person_contacted_tel+"',contact_person='"+contact_person+"',contact_person_ID='"+contact_person_ID+"',contact_time='"+contact_time+"',contact_type='"+contact_type+"',contact_content='"+contact_content+"' where contact_ID='"+contact_ID+"'" ;
	logistics_db.executeUpdate(sql) ;

		int contact_amount=0;
	String sql3="select contact_amount from logistics_file where provider_ID='"+provider_ID+"'";
	ResultSet rs3=logistics_db.executeQuery(sql3);
	if(rs3.next()){
		contact_amount=rs3.getInt("contact_amount")+1;
	}	
	String sql4="update logistics_file set contact_amount='"+contact_amount+"',lately_contact_time='"+contact_time+"',remind_contact_tag='0' where provider_ID='"+provider_ID+"'";
	logistics_db.executeUpdate(sql4) ;
	
	response.sendRedirect("draft/logistics/contact_ok.jsp?finished_tag=0");
	}else{
	response.sendRedirect("draft/logistics/contact_ok.jsp?finished_tag=1");
	}
logistics_db.commit();
logistics_db.close();
	}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 