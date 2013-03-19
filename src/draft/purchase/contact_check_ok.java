package draft.purchase;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;

import validata.ValidataTag;

public class contact_check_ok extends HttpServlet{

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

ValidataTag vt=new ValidataTag();

String contact_ID=request.getParameter("contact_ID") ;
String config_ID=request.getParameter("config_ID") ;
String reason=request.getParameter("reason") ;
String reasonexact=request.getParameter("reasonexact") ;
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_ID=request.getParameter("contact_person_ID") ;
String contact_time=request.getParameter("contact_time") ;
String contact_type=request.getParameter("contact_type") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_contact","contact_ID",contact_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_contact","contact_ID",contact_ID,"check_tag").equals("9")){
	String sql = "update purchase_contact set contact_ID='"+contact_ID+"',reason='"+reason+"',reasonexact='"+reasonexact+"',provider_ID='"+provider_ID+"',provider_name='"+provider_name+"',person_contacted='"+person_contacted+"',person_contacted_tel='"+person_contacted_tel+"',contact_person='"+contact_person+"',contact_person_ID='"+contact_person_ID+"',contact_time='"+contact_time+"',contact_type='"+contact_type+"',contact_content='"+contact_content+"',checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"' where contact_ID="+contact_ID+"" ;
	purchase_db.executeUpdate(sql) ;

    String sql9 = "update purchase_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+contact_ID+"' and config_ID='"+config_ID+"'" ;
	purchase_db.executeUpdate(sql9);
	sql9="select id from purchase_workflow where object_ID='"+contact_ID+"' and check_tag='0'";
	ResultSet rset=purchase_db.executeQuery(sql9);
	if(!rset.next()){
		sql9="update purchase_contact set reason='"+reason+"',check_tag='1' where contact_ID='"+contact_ID+"'";
		purchase_db.executeUpdate(sql9);
	int contact_amount=0;
        String sql3="select * from purchase_file where provider_ID='"+provider_ID+"'";
        ResultSet rs3=purchase_db.executeQuery(sql3);
	    if(rs3.next()){
		contact_amount=rs3.getInt("contact_amount")+1;
	}
	String sql4="update purchase_file set contact_amount='"+contact_amount+"',lately_contact_time='"+check_time+"',remind_contact_tag='0' where provider_ID='"+provider_ID+"'";
	purchase_db.executeUpdate(sql4) ;
   }
List rsList = GetWorkflow.getList(purchase_db, "purchase_config_workflow", "04");
	if(rsList.size()==0){
		sql="update purchase_contact set check_tag='1' where contact_ID='"+contact_ID+"'";
		purchase_db.executeUpdate(sql) ;
		}else{
		sql="update purchase_contact set check_tag='0' where contact_ID='"+contact_ID+"'";
		purchase_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into purchase_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+contact_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		purchase_db.executeUpdate(sql);
		}
	}
response.sendRedirect("draft/purchase/contact_ok.jsp?finished_tag=4");
	}else{
	response.sendRedirect("draft/purchase/contact_ok.jsp?finished_tag=5");
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