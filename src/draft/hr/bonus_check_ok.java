package draft.hr;

import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.counter;
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

import validata.ValidataNumber;


public class bonus_check_ok extends HttpServlet{//创建方法
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
ValidataNumber validata= new  ValidataNumber();
counter count= new  counter(dbApplication);

if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String major_first_kind=request.getParameter("human_major_first_kind");
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()){
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
String bonus_item=request.getParameter("bonus_item") ;
String bonus_worth2=request.getParameter("bonus_worth") ;
String chain_name=request.getParameter("chain_name") ;
if(bonus_worth2.equals("")) bonus_worth2="0";
String bonus_worth="";
	StringTokenizer tokenTO = new StringTokenizer(bonus_worth2,",");        
		while(tokenTO.hasMoreTokens()){
			bonus_worth+=tokenTO.nextToken();
		}
if(validata.validata(bonus_worth)){
String bonus_time=request.getParameter("bonus_time");
String bonus_degree=request.getParameter("bonus_degree") ;
String register=request.getParameter("register") ;
String register_ID=request.getParameter("register_ID") ;
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String vt_sql="select * from hr_bonus where human_ID='"+human_ID+"' and bonus_time='"+bonus_time+"' and (check_tag='5' or check_tag='9')";
ResultSet vt_rs = hr_db.executeQuery(vt_sql);
if(vt_rs.next()){
try{
	String sql2="update hr_bonus set bonus_worth='"+bonus_worth+"',bonus_item='"+bonus_item+"',bonus_degree='"+bonus_degree+"',register='"+register+"',register_ID='"+register_ID+"',register_time='"+register_time+"',remark='"+remark+"' where human_ID='"+human_ID+"' and bonus_time='"+bonus_time+"'";
	hr_db.executeUpdate(sql2);
	List rsList = GetWorkflow.getList(hr_db, "hr_config_workflow", "06");
	if(rsList.size()==0){
		String sql="update hr_bonus set check_tag='1' where human_ID='"+human_ID+"' and bonus_time='"+bonus_time+"'";
		hr_db.executeUpdate(sql);
		sql="select * from hr_file where human_ID='"+human_ID+"'";
	ResultSet rs=hr_db.executeQuery(sql);
	if(rs.next()){
		String sqll="insert into hr_file_dig(chain_id,chain_name,HUMAN_ID,HUMAN_NAME,HUMAN_ADDRESS,HUMAN_POSTCODE,HUMAN_TITLE_CLASS,HUMAN_MAJOR_FIRST_KIND_ID,HUMAN_MAJOR_FIRST_KIND_NAME,HUMAN_MAJOR_SECOND_KIND_ID,HUMAN_MAJOR_SECOND_KIND_NAME,HUMAN_BANK,HUMAN_ACCOUNT,HUMAN_TEL,HUMAN_HOME_TEL,HUMAN_CELLPHONE,HUMAN_EMAIL,HOBBY,SPECIALITY,SEX,RELIGION,PARTY,NATIONALITY,RACE,BIRTHDAY,BIRTHPLACE,AGE,EDUCATED_DEGREE,EDUCATED_YEARS,EDUCATED_MAJOR,SIN,IDCARD,MAJOR_TYPE,SALARY_STANDARD_ID,SALARY_STANDARD_NAME,SALARY_SUM,DEMAND_SALARY_SUM,PAID_SALARY_SUM,MAJOR_CHANGE_AMOUNT,BONUS_AMOUNT,TRAINING_AMOUNT,HISTORY_RECORDS,FAMILY_MEMBERSHIP,REMARK,PICTURE,ATTACHMENT_NAME,CHECK_TAG,FILE_CHANGE_AMOUNT,REGISTER,CHECKER,CHANGER,REGISTER_ID,CHECKER_ID,CHANGER_ID,REGISTER_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,DELETE_TIME,RECOVERY_TIME,EXCEL_TAG,CHANGE_TAG,MAJOR_CHANGE_TAG,TRAINING_CHECK_TAG,BONUS_CHECK_TAG,LICENSE_TAG) values('"+rs.getString("chain_id")+"','"+rs.getString("chain_name")+"','"+rs.getString("HUMAN_ID")+"','"+rs.getString("HUMAN_NAME")+"','"+rs.getString("HUMAN_ADDRESS")+"','"+rs.getString("HUMAN_POSTCODE")+"','"+rs.getString("HUMAN_TITLE_CLASS")+"','"+rs.getString("HUMAN_MAJOR_FIRST_KIND_ID")+"','"+rs.getString("HUMAN_MAJOR_FIRST_KIND_NAME")+"','"+rs.getString("HUMAN_MAJOR_SECOND_KIND_ID")+"','"+rs.getString("HUMAN_MAJOR_SECOND_KIND_NAME")+"','"+rs.getString("HUMAN_BANK")+"','"+rs.getString("HUMAN_ACCOUNT")+"','"+rs.getString("HUMAN_TEL")+"','"+rs.getString("HUMAN_HOME_TEL")+"','"+rs.getString("HUMAN_CELLPHONE")+"','"+rs.getString("HUMAN_EMAIL")+"','"+rs.getString("HOBBY")+"','"+rs.getString("SPECIALITY")+"','"+rs.getString("SEX")+"','"+rs.getString("RELIGION")+"','"+rs.getString("PARTY")+"','"+rs.getString("NATIONALITY")+"','"+rs.getString("RACE")+"','"+rs.getString("BIRTHDAY")+"','"+rs.getString("BIRTHPLACE")+"','"+rs.getString("AGE")+"','"+rs.getString("EDUCATED_DEGREE")+"','"+rs.getString("EDUCATED_YEARS")+"','"+rs.getString("EDUCATED_MAJOR")+"','"+rs.getString("SIN")+"','"+rs.getString("IDCARD")+"','"+rs.getString("MAJOR_TYPE")+"','"+rs.getString("SALARY_STANDARD_ID")+"','"+rs.getString("SALARY_STANDARD_NAME")+"','"+rs.getString("SALARY_SUM")+"','"+rs.getString("DEMAND_SALARY_SUM")+"','"+rs.getString("PAID_SALARY_SUM")+"','"+rs.getString("MAJOR_CHANGE_AMOUNT")+"','"+rs.getString("BONUS_AMOUNT")+"','"+rs.getString("TRAINING_AMOUNT")+"','"+rs.getString("HISTORY_RECORDS")+"','"+rs.getString("FAMILY_MEMBERSHIP")+"','"+rs.getString("REMARK")+"','"+rs.getString("PICTURE")+"','"+rs.getString("ATTACHMENT_NAME")+"','"+rs.getString("CHECK_TAG")+"','"+rs.getString("FILE_CHANGE_AMOUNT")+"','"+rs.getString("REGISTER")+"','"+rs.getString("CHECKER")+"','"+rs.getString("CHANGER")+"','"+rs.getString("REGISTER_ID")+"','"+rs.getString("CHECKER_ID")+"','"+rs.getString("CHANGER_ID")+"','"+rs.getString("REGISTER_TIME")+"','"+rs.getString("CHECK_TIME")+"','"+rs.getString("CHANGE_TIME")+"','"+rs.getString("LATELY_CHANGE_TIME")+"','"+rs.getString("DELETE_TIME")+"','"+rs.getString("RECOVERY_TIME")+"','"+rs.getString("EXCEL_TAG")+"','"+rs.getString("CHANGE_TAG")+"','"+rs.getString("MAJOR_CHANGE_TAG")+"','"+rs.getString("TRAINING_CHECK_TAG")+"','"+rs.getString("BONUS_CHECK_TAG")+"','"+rs.getString("LICENSE_TAG")+"')";
		hr_db.executeUpdate(sqll) ;
	}
	String sql3="select file_change_amount,bonus_amount from hr_file where human_ID='"+human_ID+"'";
	rs=hr_db.executeQuery(sql3);
	if(rs.next()){
		int file_change_amount1=rs.getInt("file_change_amount")+1;
		int bonus_amount1=rs.getInt("bonus_amount")+1;
	sql3="update hr_file set change_time='"+register_time+"',file_change_amount='"+file_change_amount1+"',bonus_amount='"+bonus_amount1+"',bonus_check_tag='0' where human_ID='"+human_ID+"'";
	hr_db.executeUpdate(sql3);
	}
	
	}else{
        String sql="delete from hr_workflow where object_ID='"+human_ID+"' and type_id='06' and bonus_time='"+bonus_time+"'";
		hr_db.executeUpdate(sql) ;
		sql="update hr_bonus set check_tag='0' where human_ID='"+human_ID+"' and bonus_time='"+bonus_time+"'";
		hr_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into hr_workflow(config_id,object_ID,type_id,describe1,describe2,bonus_time) values ('"+elem[0]+"','"+human_ID+"','06','"+elem[1]+"','"+elem[2]+"','"+bonus_time+"')" ;
		hr_db.executeUpdate(sql);
		}
	}
	

	response.sendRedirect("draft/hr/bonus_ok.jsp?finished_tag=4");


}
catch (Exception ex){
out.println("error"+ex);
}
}else{
response.sendRedirect("draft/hr/bonus_ok.jsp?finished_tag=5");
}
}else{
response.sendRedirect("draft/hr/bonus_ok.jsp?finished_tag=6");
}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}

