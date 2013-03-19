package draft.hr;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;

import java.sql.ResultSet;
import java.util.*;
import java.io.*;
import include.nseer_cookie.*;
import include.nseer_db.*;
import include.operateDB.CdefineUpdate;
import include.get_sql.getInsertSql;
import validata.ValidataTag;

public class file_check_ok extends HttpServlet{//创建方法
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
getInsertSql getInsertSql= new getInsertSql();
ValidataTag  vt= new  ValidataTag();
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String kind_chain=request.getParameter("kind_chain");
String chain_id=Divide1.getId(kind_chain);
String chain_name=Divide1.getName(kind_chain);

String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String major_second_kind=request.getParameter("select5");
String major_first_kind=request.getParameter("select4");
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/");        
	while(tokenTO4.hasMoreTokens()) {
        major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/");        
	while(tokenTO5.hasMoreTokens()) {
        major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
String oldKind_chain=request.getParameter("oldKind_chain");
String oldChain_id=Divide1.getId(oldKind_chain);

String human_ID=request.getParameter("human_ID") ;
String human_name=request.getParameter("human_name") ;
String human_address=request.getParameter("human_address") ;
String human_title_class=request.getParameter("human_title_class") ;
String human_bank=request.getParameter("human_bank") ;
String human_account=request.getParameter("human_account") ;
String human_tel=request.getParameter("human_tel") ;
String human_home_tel=request.getParameter("human_home_tel") ;
String human_postcode=request.getParameter("human_postcode") ;
String register=request.getParameter("register") ;
String human_cellphone=request.getParameter("human_cellphone") ;
String idcard=request.getParameter("idcard") ;
String SIN=request.getParameter("SIN") ;
String religion=request.getParameter("religion") ;
String party=request.getParameter("party") ;
String race=request.getParameter("race") ;
String nationality=request.getParameter("nationality") ;
String age=request.getParameter("age") ;
String sex=request.getParameter("sex") ;
String speciality=request.getParameter("speciality") ;
String hobby=request.getParameter("hobby") ;
String birthday=request.getParameter("birthday");
if(birthday.equals("")) birthday = "1800-01-01";
String birthplace=request.getParameter("birthplace") ;
String human_email=request.getParameter("human_email") ;
String educated_degree=request.getParameter("educated_degree") ;
String educated_years=request.getParameter("educated_years") ;
String educated_major=request.getParameter("educated_major") ;
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("history_records").getBytes("UTF-8"),"UTF-8");
String history_records=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("family_membership").getBytes("UTF-8"),"UTF-8");
String family_membership=exchange.toHtml(bodyb);
String salary_standard_ID="";
String salary_standard_name="";
String salary_sum="";
String salary_standard=request.getParameter("salary_standard");
StringTokenizer tokenTO6 = new StringTokenizer(salary_standard,"/");        
	while(tokenTO6.hasMoreTokens()) {
        salary_standard_ID = tokenTO6.nextToken();
		salary_standard_name = tokenTO6.nextToken();
		salary_sum = tokenTO6.nextToken();
		}
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"hr_file");
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"hr_file","human_ID",human_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"hr_file","human_ID",human_ID,"check_tag").equals("9")){
try{
	String sql8 = "update hr_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',human_major_first_kind_ID='"+major_first_kind_ID+"',human_major_first_kind_name='"+major_first_kind_name+"',human_major_second_kind_ID='"+major_second_kind_ID+"',human_major_second_kind_name='"+major_second_kind_name+"',human_name='"+human_name+"',human_address='"+human_address+"',human_title_class='"+human_title_class+"',human_bank='"+human_bank+"',human_account='"+human_account+"',human_tel='"+human_tel+"',human_home_tel='"+human_home_tel+"',human_postcode='"+human_postcode+"',register='"+register+"',educated_degree='"+educated_degree+"',educated_years='"+educated_years+"',educated_major='"+educated_major+"',register_time='"+register_time+"',salary_standard_ID='"+salary_standard_ID+"',salary_standard_name='"+salary_standard_name+"',salary_sum='"+salary_sum+"',family_membership='"+family_membership+"',history_records='"+history_records+"',remark='"+remark+"',human_cellphone='"+human_cellphone+"',idcard='"+idcard+"',SIN='"+SIN+"',religion='"+religion+"',race='"+race+"',nationality='"+nationality+"',party='"+party+"',age='"+age+"',birthday='"+birthday+"',birthplace='"+birthplace+"',sex='"+sex+"',speciality='"+speciality+"',hobby='"+hobby+"',human_email='"+human_email+"',check_tag='0' where human_ID='"+human_ID+"'" ;
	hr_db.executeUpdate(sql8) ;
	/*****************************************************/
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql8=CdefineUpdate.update("hr_file","human_ID",human_ID,request);
	hr_db.executeUpdate(sql8) ;
	/*****************************************************/

		if(!chain_id.equals("oldChain_id")){
			sql8="select id from hr_file where chain_id='"+oldChain_id+"'";
			ResultSet rs=hr_db.executeQuery(sql8);
			if(!rs.next()){
				sql8="update hr_config_file_kind set delete_tag='0' where file_id='"+oldChain_id+"'";
				hr_db.executeUpdate(sql8);
			}
			sql8="update hr_config_file_kind set delete_tag='1' where file_id='"+chain_id+"'";
			hr_db.executeUpdate(sql8);//delete_tag为1说明机构被使用	
		}
	String sql9 = "update security_users set human_name='"+human_name+"' where human_ID='"+human_ID+"'" ;
	hr_db.executeUpdate(sql9) ;
    String sql10 = "update security_license set human_name='"+human_name+"' where human_ID='"+human_ID+"'" ;
	hr_db.executeUpdate(sql10) ;

	List rsList = GetWorkflow.getList(hr_db, "hr_config_workflow", "01");
	String[] elem=new String[3];
	String sql="";
	if(rsList.size()==0){
		sql="update hr_file set check_tag='1' where human_ID='"+human_ID+"'";
		hr_db.executeUpdate(sql);
	}else{
        sql="delete from hr_workflow where object_ID='"+human_ID+"' and type_id='01'";
		hr_db.executeUpdate(sql) ;
		sql="update hr_file set check_tag='0' where human_ID='"+human_ID+"'";
		hr_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into hr_workflow(config_id,object_ID,type_id,describe1,describe2) values ('"+elem[0]+"','"+human_ID+"','01','"+elem[1]+"','"+elem[2]+"')" ;
		hr_db.executeUpdate(sql);
		}
	}
response.sendRedirect("draft/hr/file_choose_picture.jsp?human_ID="+human_ID+"&&tag=2");
}
catch (Exception ex){
ex.printStackTrace();
}
}else{
response.sendRedirect("draft/hr/file_ok.jsp?finished_tag=5");
}
 hr_db.commit();
 hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}
