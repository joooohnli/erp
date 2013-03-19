package draft.intrmanufacture;


import include.auto_execute.ContactExpiry;
import include.nseer_cookie.GetWorkflow;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

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
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
ContactExpiry contactExpiry= new ContactExpiry();
ValidataTag   vt= new ValidataTag();
if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String contact_ID=request.getParameter("contact_ID") ;
String reason=request.getParameter("reason");
String reasonexact=request.getParameter("reasonexact") ;
String provider_ID=request.getParameter("provider_ID") ;
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_ID=request.getParameter("contact_person_ID") ;
String contact_time=request.getParameter("contact_time") ;
String contact_type=request.getParameter("contact_type") ;
String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_contact","contact_ID",contact_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_contact","contact_ID",contact_ID,"check_tag").equals("9")){
try{
	String sql = "update intrmanufacture_contact set contact_ID='"+contact_ID+"',reason='"+reason+"',reasonexact='"+reasonexact+"',provider_ID='"+provider_ID+"',person_contacted='"+person_contacted+"',person_contacted_tel='"+person_contacted_tel+"',contact_person='"+contact_person+"',contact_person_ID='"+contact_person_ID+"',contact_time='"+contact_time+"',contact_type='"+contact_type+"',contact_content='"+contact_content+"' where contact_ID='"+contact_ID+"'";
	intrmanufacture_db.executeUpdate(sql) ;

	List rsList = GetWorkflow.getList(intrmanufacture_db, "intrmanufacture_config_workflow", "04");
	if(rsList.size()==0){
		sql="update intrmanufacture_contact set check_tag='1' where contact_ID='"+contact_ID+"'";
		intrmanufacture_db.executeUpdate(sql) ;
	int contact_amount=0;
	String sql3="select contact_amount from intrmanufacture_file where provider_ID='"+provider_ID+"'";
	ResultSet rs3=intrmanufacture_db.executeQuery(sql3);
	if(rs3.next()){
		contact_amount=rs3.getInt("contact_amount")+1;
	}
	
	String sql4="update intrmanufacture_file set contact_amount='"+contact_amount+"',lately_contact_time='"+contact_time+"',remind_contact_tag='0' where provider_ID='"+provider_ID+"'";
	intrmanufacture_db.executeUpdate(sql4) ;

	}else{
		sql="update intrmanufacture_contact set check_tag='0' where contact_ID='"+contact_ID+"'";
		intrmanufacture_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into intrmanufacture_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+contact_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		intrmanufacture_db.executeUpdate(sql) ;
		}
	}
}
catch (Exception ex){
ex.printStackTrace();

}
 response.sendRedirect("draft/intrmanufacture/contact_ok.jsp?finished_tag=4");
}else{
	response.sendRedirect("draft/intrmanufacture/contact_ok.jsp?finished_tag=5");
	}
	intrmanufacture_db.commit();
	intrmanufacture_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
	}catch(Exception ex){
	ex.printStackTrace();
	}
}
}