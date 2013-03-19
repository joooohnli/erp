package draft.hr;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_cookie.exchange ;
import include.nseer_db.*;
import include.get_sql.getInsertSql;
import validata.ValidataNumber;


public class bonus_draft_ok extends HttpServlet{//创建方法
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

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
getInsertSql getInsertSql= new  getInsertSql();
ValidataNumber  validata= new  ValidataNumber();
String human_ID=request.getParameter("human_ID");
String config_id=request.getParameter("config_id");
String bonus_time=request.getParameter("bonus_time");

String human_name=request.getParameter("human_name");
String bonus_item=request.getParameter("bonus_item") ;
String bonus_degree=request.getParameter("bonus_degree") ;
String register=request.getParameter("register") ;
String register_ID=request.getParameter("register_ID") ;
String register_time=request.getParameter("register_time") ;
String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String major_first_kind=request.getParameter("human_major_first_kind");
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
String major_second_kind=request.getParameter("human_major_second_kind");
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String bonus_worth2=request.getParameter("bonus_worth") ;
if(bonus_worth2.equals("")) bonus_worth2="0";
String bonus_worth="";
	StringTokenizer tokenTO = new StringTokenizer(bonus_worth2,",");        
		while(tokenTO.hasMoreTokens()) {
			bonus_worth+=tokenTO.nextToken();
		}
String bonus_amount=request.getParameter("bonus_amount") ;
int bonus_amount1=Integer.parseInt(bonus_amount)+1;
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"hr_file");
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
int file_change_amount1=Integer.parseInt(file_change_amount)+1;
String sql8 = "select * from hr_bonus where human_ID='"+human_ID+"' and bonus_time='"+bonus_time+"' and (check_tag='5' or check_tag='9')" ;
	ResultSet rs8 = hr_db.executeQuery(sql8) ;
	if(rs8.next()){
if(validata.validata(bonus_worth)){

try{
	String sql2="update hr_bonus set bonus_worth='"+bonus_worth+"',bonus_item='"+bonus_item+"',bonus_degree='"+bonus_degree+"',register='"+register+"',register_ID='"+register_ID+"',register_time='"+register_time+"',remark='"+remark+"' where human_ID='"+human_ID+"' and bonus_time='"+bonus_time+"'";
		hr_db.executeUpdate(sql2);
}
catch (Exception ex){
out.println("error"+ex);
}
response.sendRedirect("draft/hr/bonus_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("draft/hr/bonus_ok.jsp?finished_tag=6");
}
}else{
response.sendRedirect("draft/hr/bonus_ok.jsp?finished_tag=1");
}

hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}

