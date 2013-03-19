package draft.hr;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import include.nseer_cookie.*;
import java.sql.ResultSet;
import java.util.*;
import java.io.*;
import include.nseer_db.*;
import validata.ValidataNumber;
import validata.ValidataTag;

public class salaryStandard_check_ok extends HttpServlet{
//创建方法
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
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ValidataNumber validata= new  ValidataNumber();
ValidataTag  vt= new  ValidataTag();
String standard_ID=request.getParameter("standard_ID");
String standard_name=request.getParameter("standard_name");
String major_type=request.getParameter("major_type") ;
String designer=request.getParameter("designer") ;
String[] item_name=request.getParameterValues("item_name");
String[] salary=request.getParameterValues("salary");
String[] details_number=request.getParameterValues("details_number");
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
int p=0;
for(int i=0;i<item_name.length;i++){
	if(!salary[i].equals("")){
		StringTokenizer tokenTO4 = new StringTokenizer(salary[i],",");        
		String salary1="";
		while(tokenTO4.hasMoreTokens()) {
			salary1+= tokenTO4.nextToken();
		}
			if(!validata.validata(salary1)){
			p++;
			}
	}
}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"hr_salary_standard","standard_ID",standard_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"hr_salary_standard","standard_ID",standard_ID,"check_tag").equals("9")){

if(p==0){
int n=0;
double salary_sum=0.0d;
for(int i=0;i<item_name.length;i++){
	if(!salary[i].equals("")){
		StringTokenizer tokenTO4 = new StringTokenizer(salary[i],",");        
		String salary1="";
		while(tokenTO4.hasMoreTokens()) {
			salary1+= tokenTO4.nextToken();
			if(salary1.indexOf("-")!=-1){
			n++;
			}
		}
	}
}
if(n==0){
try{
String sqll="update hr_salary_standard set check_tag='0' where standard_ID='"+standard_ID+"'";
		hr_db.executeUpdate(sqll);
	for(int i=0;i<item_name.length;i++){
	if(salary[i].equals("")) salary[i]="0";
		String salarying="";
		StringTokenizer tokenTO = new StringTokenizer(salary[i],",");        
		while(tokenTO.hasMoreTokens()) {
			salarying+=tokenTO.nextToken();
		}
		salary_sum+=Double.parseDouble(salarying);
		String sql4="update hr_salary_standard_details set standard_name='"+standard_name+"',salary='"+salarying+"' where standard_ID='"+standard_ID+"' and details_number='"+details_number[i]+"'";
		//out.println(sql4);
		hr_db.executeUpdate(sql4);
	}
	String sql2="update hr_salary_standard set standard_name='"+standard_name+"',major_type='"+major_type+"',designer='"+designer+"',register='"+register+"',register_time='"+register_time+"',salary_sum='"+salary_sum+"',check_tag='0' where standard_ID='"+standard_ID+"'";
	hr_db.executeUpdate(sql2);
	String sql3="update hr_file set salary_standard_name='"+standard_name+"',major_type='"+major_type+"',salary_sum='"+salary_sum+"' where salary_standard_ID='"+standard_ID+"'";
		hr_db.executeUpdate(sql3);

	List rsList = GetWorkflow.getList(hr_db, "hr_config_workflow", "02");
	String[] elem=new String[3];
	String sql="";
	if(rsList.size()==0){
		sql="update hr_salary_standard set check_tag='1' where standard_ID='"+standard_ID+"'";
		hr_db.executeUpdate(sql);
		sql="update hr_file set salary_standard_name='"+standard_name+"',major_type='"+major_type+"',salary_sum='"+salary_sum+"' where salary_standard_ID='"+standard_ID+"'";
		hr_db.executeUpdate(sql);
	}else{
        sql="delete from hr_workflow where object_ID='"+standard_ID+"' and type_id='02'";
		hr_db.executeUpdate(sql) ;
		sql="update hr_salary_standard set check_tag='0' where standard_ID='"+standard_ID+"'";
		hr_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into hr_workflow(config_id,object_ID,type_id,describe1,describe2) values ('"+elem[0]+"','"+standard_ID+"','02','"+elem[1]+"','"+elem[2]+"')" ;
		hr_db.executeUpdate(sql);
		}
	}

}
catch (Exception ex){
out.println("error"+ex);
}

response.sendRedirect("draft/hr/salaryStandard_ok.jsp?finished_tag=4");


}else{


response.sendRedirect("draft/hr/salaryStandard_ok.jsp?finished_tag=6");

}
}else{

response.sendRedirect("draft/hr/salaryStandard_ok.jsp?finished_tag=7");

}
}else{

response.sendRedirect("draft/hr/salaryStandard_ok.jsp?finished_tag=5");
}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}
