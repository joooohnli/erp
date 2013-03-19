package draft.hr;

import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class training_draft_ok extends HttpServlet{
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

String training_time=request.getParameter("training_time");
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
String human_ID=request.getParameter("human_ID");
String human_name=request.getParameter("human_name");
String training_item=request.getParameter("training_item") ;
String training_hour=request.getParameter("training_hour") ;
String training_result_degree=request.getParameter("training_result_degree") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String chain_name=request.getParameter("chain_name");
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String sql8 = "select * from hr_training where human_ID='"+human_ID+"' and (check_tag='5' or check_tag='9')" ;
	ResultSet rs8 = hr_db.executeQuery(sql8);
	if(rs8.next()){
try{
	String sql="update hr_training set training_result_degree='"+training_result_degree+"',training_item='"+training_item+"',training_hour='"+training_hour+"',register='"+register+"',register_time='"+register_time+"',remark='"+remark+"' where human_ID='"+human_ID+"' and training_time='"+training_time+"'";
	hr_db.executeUpdate(sql) ;
	String sql1="update hr_file set training_check_tag='1' where human_ID='"+human_ID+"'";
	hr_db.executeUpdate(sql1) ;

response.sendRedirect("draft/hr/training_ok.jsp?finished_tag=0");
}catch (Exception ex){
out.println("error"+ex);
}
	}else{
response.sendRedirect("draft/hr/training_ok.jsp?finished_tag=1");
}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}