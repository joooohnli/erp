package draft.crm;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import java.util.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import include.auto_execute.ContactExpiry;
import validata.ValidataTag;

public class contact_check_ok extends HttpServlet{
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
String contact_ID=request.getParameter("contact_ID") ;
String reason=request.getParameter("reason");
String reasonexact=request.getParameter("reasonexact") ;
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=request.getParameter("customer_name") ;
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_ID=request.getParameter("contact_person_ID") ;
String contact_time=request.getParameter("contact_time") ;
String contact_type=request.getParameter("contact_type") ;
String checker=request.getParameter("checker") ;

String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_contact","contact_ID",contact_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_contact","contact_ID",contact_ID,"check_tag").equals("9")){
try{
	String sql = "update crm_contact set contact_ID='"+contact_ID+"',reason='"+reason+"',reasonexact='"+reasonexact+"',customer_ID='"+customer_ID+"',customer_name='"+customer_name+"',person_contacted='"+person_contacted+"',person_contacted_tel='"+person_contacted_tel+"',contact_person='"+contact_person+"',contact_person_ID='"+contact_person_ID+"',contact_time='"+contact_time+"',contact_type='"+contact_type+"',contact_content='"+contact_content+"',checker='"+checker+"' where contact_ID='"+contact_ID+"'" ;
	crm_db.executeUpdate(sql);
	List rsList = GetWorkflow.getList(crm_db, "crm_config_workflow", "03");
	String[] elem=new String[3];
	if(rsList.size()==0){
		sql="update crm_contact set check_tag='1' where contact_ID='"+contact_ID+"'";
		crm_db.executeUpdate(sql) ;
		int contact_amount=0;
String sql3="select contact_amount from crm_file where customer_ID='"+customer_ID+"'";
ResultSet rs3=crm_db.executeQuery(sql3);
	if(rs3.next()){
		contact_amount=rs3.getInt("contact_amount")+1;
	}
	
	String sql4="update crm_file set contact_amount='"+contact_amount+"',lately_contact_time='"+contact_time+"',remind_contact_tag='0' where customer_ID='"+customer_ID+"'";
	crm_db.executeUpdate(sql4) ;
	
	contactExpiry.flow(dbApplication);
	}else{
		sql="update crm_contact set check_tag='0' where contact_ID='"+contact_ID+"'";
		crm_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into crm_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+contact_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		crm_db.executeUpdate(sql) ;
		}
	}
}
catch (Exception ex){
ex.printStackTrace();

}
 response.sendRedirect("draft/crm/contact_ok.jsp?finished_tag=1");//用户时候登陆过
}else{
	
	response.sendRedirect("draft/crm/contact_ok.jsp?finished_tag=5");//用户时候登陆过
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
