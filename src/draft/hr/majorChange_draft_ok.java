package draft.hr;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 

import java.sql.ResultSet;
import java.util.*;
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.Divide1;
import include.nseer_db.*;
import include.nseer_cookie.counter;

public class majorChange_draft_ok extends HttpServlet{//创建方法
ServletContext application;
HttpSession session;


public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db1 = new nseer_db_backup1(dbApplication);
counter count=new  counter(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String human_ID=request.getParameter("human_ID");
String config_id=request.getParameter("config_id");
String major_time=request.getParameter("major_time");
System.out.println(major_time);
String vt_sql="select * from hr_major_change where human_ID='"+human_ID+"' and major_time='"+major_time+"' and (check_tag='5' or check_tag='9')";
ResultSet vt_rs = hr_db.executeQuery(vt_sql);
if(vt_rs.next()){
String kind_chain=request.getParameter("old_kind_chain");
String chain_id=Divide1.getId(kind_chain);
String chain_name=Divide1.getName(kind_chain);
String new_kind_chain=request.getParameter("kind_chain");
String new_chain_id=Divide1.getId(new_kind_chain);
String new_chain_name=Divide1.getName(new_kind_chain);
String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String salary_standard_ID="";
String salary_standard_name="";
String salary_sum="";
String new_first_kind_ID="";
String new_first_kind_name="";
String new_second_kind_ID="";
String new_second_kind_name="";
String new_third_kind_ID="";
String new_third_kind_name="";
String new_major_first_kind_ID="";
String new_major_first_kind_name="";
String new_major_second_kind_ID="";
String new_major_second_kind_name="";
String new_salary_standard_ID="";
String new_salary_standard_name="";
String new_salary_sum="";
int file_change_amount1=0;
int major_change_amount1=0;
String major_first_kind=request.getParameter("human_major_first_kind");
if(major_first_kind.indexOf("//")==-1&&major_first_kind.indexOf("  /")==-1){
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
}
String major_second_kind=request.getParameter("human_major_second_kind");
if(major_second_kind.indexOf("//")==-1&&major_second_kind.indexOf("  /")==-1){
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
}
String major_type=request.getParameter("major_type") ;
String salary_standard=request.getParameter("salary_standard");   
salary_standard_ID = salary_standard.split("/")[0];
salary_standard_name = salary_standard.split("/")[1];
salary_sum = salary_standard.split("/")[2];

String new_major_first_kind=request.getParameter("select4");
if(new_major_first_kind.indexOf("//")==-1&&new_major_first_kind.indexOf("/  /")==-1){
StringTokenizer tokenTO14 = new StringTokenizer(new_major_first_kind,"/");        
	while(tokenTO14.hasMoreTokens()) {
        new_major_first_kind_ID = tokenTO14.nextToken();
		new_major_first_kind_name = tokenTO14.nextToken();
		}
}
String new_major_second_kind=request.getParameter("select5");
if(new_major_second_kind.indexOf("//")==-1&&new_major_second_kind.indexOf("/  /")==-1){
StringTokenizer tokenTO15 = new StringTokenizer(new_major_second_kind,"/");        
	while(tokenTO15.hasMoreTokens()) {
        new_major_second_kind_ID = tokenTO15.nextToken();
		new_major_second_kind_name = tokenTO15.nextToken();
		}
}
String human_name=request.getParameter("human_name") ;
String new_major_type=request.getParameter("new_major_type") ;
String new_salary_standard=request.getParameter("new_salary_standard");
StringTokenizer tokenTO16 = new StringTokenizer(new_salary_standard,"/");        
	while(tokenTO16.hasMoreTokens()) {
        new_salary_standard_ID = tokenTO16.nextToken();
		new_salary_standard_name = tokenTO16.nextToken();
		new_salary_sum = tokenTO16.nextToken();
		}
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("remark1").getBytes("UTF-8"),"UTF-8");
String remark1=exchange.toHtml(bodyc);
try{
	String sql = "update hr_major_change set new_chain_id='"+new_chain_id+"',new_chain_name='"+new_chain_name+"',new_human_major_first_kind_ID='"+new_major_first_kind_ID+"',new_human_major_first_kind_name='"+new_major_first_kind_name+"',new_human_major_second_kind_ID='"+new_major_second_kind_ID+"',new_human_major_second_kind_name='"+new_major_second_kind_name+"',human_name='"+human_name+"',major_type='"+major_type+"',salary_standard_ID='"+salary_standard_ID+"',salary_standard_name='"+salary_standard_name+"',salary_sum='"+salary_sum+"',new_major_type='"+new_major_type+"',new_salary_standard_ID='"+new_salary_standard_ID+"',new_salary_standard_name='"+new_salary_standard_name+"',new_salary_sum='"+new_salary_sum+"',register='"+register+"',register_time='"+register_time+"',remark1='"+remark1+"' where human_ID='"+human_ID+"' and major_time='"+major_time+"'";
	hr_db.executeUpdate(sql);
	response.sendRedirect("draft/hr/majorChange_ok.jsp?finished_tag=0");
}
catch (Exception ex){ex.printStackTrace();
}

}else{

response.sendRedirect("draft/hr/majorChange_ok.jsp?finished_tag=1");
}
 hr_db.commit();
  hr_db1.commit();
   crm_db.commit();
    crm_db1.commit();
	hr_db.close();
	hr_db1.close();
	crm_db.close();
	crm_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}