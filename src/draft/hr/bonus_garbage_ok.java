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


public class bonus_garbage_ok extends HttpServlet{//创建方法
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

String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
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
String sql8 = "select * from hr_bonus where human_ID='"+human_ID+"' and (check_tag='5' or check_tag='9')" ;
	ResultSet rs8 = hr_db.executeQuery(sql8) ;
	if(rs8.next()){
if(validata.validata(bonus_worth)){

try{
	String sql2="update hr_bonus set bonus_worth='"+bonus_worth+"',checker='"+checker+"',check_time='"+check_time+"',remark='"+remark+"' where human_ID='"+human_ID+"'";
		hr_db.executeUpdate(sql2);

		String sql="update hr_bonus set check_tag='2' where human_ID='"+human_ID+"'";
	hr_db.executeUpdate(sql);
		sql="select * from hr_file where human_ID='"+human_ID+"'";
	ResultSet rs=hr_db.executeQuery(sql);
	if(rs.next()){
		String sqll="insert into hr_file_dig(chain_id,chain_name,HUMAN_ID,HUMAN_NAME,HUMAN_ADDRESS,HUMAN_POSTCODE,HUMAN_TITLE_CLASS,HUMAN_MAJOR_FIRST_KIND_ID,HUMAN_MAJOR_FIRST_KIND_NAME,HUMAN_MAJOR_SECOND_KIND_ID,HUMAN_MAJOR_SECOND_KIND_NAME,HUMAN_BANK,HUMAN_ACCOUNT,HUMAN_TEL,HUMAN_HOME_TEL,HUMAN_CELLPHONE,HUMAN_EMAIL,HOBBY,SPECIALITY,SEX,RELIGION,PARTY,NATIONALITY,RACE,BIRTHDAY,BIRTHPLACE,AGE,EDUCATED_DEGREE,EDUCATED_YEARS,EDUCATED_MAJOR,SIN,IDCARD,MAJOR_TYPE,SALARY_STANDARD_ID,SALARY_STANDARD_NAME,SALARY_SUM,DEMAND_SALARY_SUM,PAID_SALARY_SUM,MAJOR_CHANGE_AMOUNT,BONUS_AMOUNT,TRAINING_AMOUNT,HISTORY_RECORDS,FAMILY_MEMBERSHIP,REMARK,PICTURE,ATTACHMENT_NAME,CHECK_TAG,FILE_CHANGE_AMOUNT,REGISTER,CHECKER,CHANGER,REGISTER_ID,CHECKER_ID,CHANGER_ID,REGISTER_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,DELETE_TIME,RECOVERY_TIME,EXCEL_TAG,CHANGE_TAG,MAJOR_CHANGE_TAG,TRAINING_CHECK_TAG,BONUS_CHECK_TAG,LICENSE_TAG) values('"+rs.getString("chain_id")+"','"+rs.getString("chain_name")+"','"+rs.getString("HUMAN_ID")+"','"+rs.getString("HUMAN_NAME")+"','"+rs.getString("HUMAN_ADDRESS")+"','"+rs.getString("HUMAN_POSTCODE")+"','"+rs.getString("HUMAN_TITLE_CLASS")+"','"+rs.getString("HUMAN_MAJOR_FIRST_KIND_ID")+"','"+rs.getString("HUMAN_MAJOR_FIRST_KIND_NAME")+"','"+rs.getString("HUMAN_MAJOR_SECOND_KIND_ID")+"','"+rs.getString("HUMAN_MAJOR_SECOND_KIND_NAME")+"','"+rs.getString("HUMAN_BANK")+"','"+rs.getString("HUMAN_ACCOUNT")+"','"+rs.getString("HUMAN_TEL")+"','"+rs.getString("HUMAN_HOME_TEL")+"','"+rs.getString("HUMAN_CELLPHONE")+"','"+rs.getString("HUMAN_EMAIL")+"','"+rs.getString("HOBBY")+"','"+rs.getString("SPECIALITY")+"','"+rs.getString("SEX")+"','"+rs.getString("RELIGION")+"','"+rs.getString("PARTY")+"','"+rs.getString("NATIONALITY")+"','"+rs.getString("RACE")+"','"+rs.getString("BIRTHDAY")+"','"+rs.getString("BIRTHPLACE")+"','"+rs.getString("AGE")+"','"+rs.getString("EDUCATED_DEGREE")+"','"+rs.getString("EDUCATED_YEARS")+"','"+rs.getString("EDUCATED_MAJOR")+"','"+rs.getString("SIN")+"','"+rs.getString("IDCARD")+"','"+rs.getString("MAJOR_TYPE")+"','"+rs.getString("SALARY_STANDARD_ID")+"','"+rs.getString("SALARY_STANDARD_NAME")+"','"+rs.getString("SALARY_SUM")+"','"+rs.getString("DEMAND_SALARY_SUM")+"','"+rs.getString("PAID_SALARY_SUM")+"','"+rs.getString("MAJOR_CHANGE_AMOUNT")+"','"+rs.getString("BONUS_AMOUNT")+"','"+rs.getString("TRAINING_AMOUNT")+"','"+rs.getString("HISTORY_RECORDS")+"','"+rs.getString("FAMILY_MEMBERSHIP")+"','"+rs.getString("REMARK")+"','"+rs.getString("PICTURE")+"','"+rs.getString("ATTACHMENT_NAME")+"','"+rs.getString("CHECK_TAG")+"','"+rs.getString("FILE_CHANGE_AMOUNT")+"','"+rs.getString("REGISTER")+"','"+rs.getString("CHECKER")+"','"+rs.getString("CHANGER")+"','"+rs.getString("REGISTER_ID")+"','"+rs.getString("CHECKER_ID")+"','"+rs.getString("CHANGER_ID")+"','"+rs.getString("REGISTER_TIME")+"','"+rs.getString("CHECK_TIME")+"','"+rs.getString("CHANGE_TIME")+"','"+rs.getString("LATELY_CHANGE_TIME")+"','"+rs.getString("DELETE_TIME")+"','"+rs.getString("RECOVERY_TIME")+"','"+rs.getString("EXCEL_TAG")+"','"+rs.getString("CHANGE_TAG")+"','"+rs.getString("MAJOR_CHANGE_TAG")+"','"+rs.getString("TRAINING_CHECK_TAG")+"','"+rs.getString("BONUS_CHECK_TAG")+"','"+rs.getString("LICENSE_TAG")+"')";
		hr_db.executeUpdate(sqll) ;
	}
		
	String sql3="update hr_file set lately_change_time='"+lately_change_time+"',change_time='"+check_time+"',file_change_amount='"+file_change_amount1+"',bonus_amount='"+bonus_amount1+"',bonus_check_tag='0' where human_ID='"+human_ID+"'";
		hr_db.executeUpdate(sql3);

}
catch (Exception ex){
out.println("error"+ex);
}
response.sendRedirect("draft/hr/bonus_ok.jsp?finished_tag=2");
}else{
response.sendRedirect("draft/hr/bonus_ok.jsp?finished_tag=6");
}
}else{
response.sendRedirect("draft/hr/bonus_ok.jsp?finished_tag=3");
}

hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}

