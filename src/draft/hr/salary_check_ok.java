package draft.hr;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import include.nseer_cookie.*;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.*;
import include.nseer_db.*;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataTag;

public class salary_check_ok extends HttpServlet{
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
counter count= new  counter(dbApplication);
ValidataNumber validata= new  ValidataNumber();
ValidataRecord vr= new  ValidataRecord();

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ValidataTag  vt= new  ValidataTag();
String checker=(String)session.getAttribute("realeditorc");
String salary_id=request.getParameter("salary_id");
String register=(String)session.getAttribute("realeditorc");

java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sql="select salary_sum from hr_salary where salary_id='"+salary_id+"' and (check_tag='5' or check_tag='9') and register_finish_tag='1'";
ResultSet rs=hr_db.executeQuery(sql);
if(rs.next()){
	Double salary_sum=rs.getDouble("salary_sum");
	String[] human_id=request.getParameterValues("human_ID");
	String[] bonus_sum=request.getParameterValues("bonus_sum");
	String[] sale_bonus_sum=request.getParameterValues("sale_bonus_sum");
	String[] deduct_sum=request.getParameterValues("deduct_sum");
	if(human_id!=null){
	Double[] subtotal=new Double[human_id.length];
	if(human_id!=null&&human_id.length>0){

		for(int i=0;i<human_id.length;i++){
			bonus_sum[i]=bonus_sum[i].replaceAll(",", "").replaceAll("，", "");
			if(!validata.validata(bonus_sum[i])){
				bonus_sum[i]="0";
			}
			sale_bonus_sum[i]=sale_bonus_sum[i].replaceAll(",", "").replaceAll("，", "");
			if(!validata.validata(sale_bonus_sum[i])){
				sale_bonus_sum[i]="0";
			}
			deduct_sum[i]=deduct_sum[i].replaceAll(",", "").replaceAll("，", "");
			if(!validata.validata(deduct_sum[i])){
				deduct_sum[i]="0";
			}
			subtotal[i]=Double.parseDouble(bonus_sum[i])+Double.parseDouble(sale_bonus_sum[i])-Double.parseDouble(deduct_sum[i]);
			sql="select standard_salary_sum,salary_sum from hr_salary_human_details where salary_id='"+salary_id+"' and human_id='"+human_id[i]+"'";
			ResultSet rs1=hr_db.executeQuery(sql);
			if(rs1.next()){
				Double salary_sum_temp=rs1.getDouble("standard_salary_sum")+subtotal[i];
				salary_sum+=salary_sum_temp-rs1.getDouble("salary_sum");
				sql="update hr_salary_human_details set bonus_sum='"+bonus_sum[i]+"',sale_bonus_sum='"+sale_bonus_sum[i]+"',deduct_sum='"+deduct_sum[i]+"',salary_sum='"+salary_sum_temp+"' where salary_id='"+salary_id+"' and human_id='"+human_id[i]+"'";
				hr_db.executeUpdate(sql);
			}
		}
		sql="update hr_salary set salary_sum='"+salary_sum+"',check_tag='0' where salary_id='"+salary_id+"'";
		hr_db.executeUpdate(sql);
	}
	List rsList = GetWorkflow.getList(hr_db, "hr_config_workflow", "03");//获得客户化设置中所设置的审核流程
	if(rsList.size()==0){
		String fund_id=NseerId.getId("fund/apply_pay_expenses",(String)dbSession.getAttribute("unit_db_name"));
		if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",salary_id)){
			String sql2="insert into fund_fund(fund_ID,reason,reasonexact,funder,file_chain_id,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register_time,register) values('"+fund_id+"','付款','"+salary_id+"','本单位','550201','管理费用-工资','"+salary_sum+"','人民币','元','"+time+"','"+register+"')";
			hr_db.executeUpdate(sql2);
		}
		sql="update hr_file set salary_tag='0'";
		hr_db.executeUpdate(sql);
		sql="update hr_salary set check_tag='1' where salary_id='"+salary_id+"'";
		hr_db.executeUpdate(sql);
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		String sql0 = "insert into hr_workflow(config_id,object_ID,type_id,describe1,describe2) values ('"+elem[0]+"','"+salary_id+"','03','"+elem[1]+"','"+elem[2]+"')" ;
		hr_db.executeUpdate(sql0);
		}
	}
	response.sendRedirect("draft/hr/salary_ok.jsp?finished_tag=4");
}else{
	response.sendRedirect("draft/hr/salary_ok.jsp?finished_tag=6");
}
}else{
	response.sendRedirect("draft/hr/salary_ok.jsp?finished_tag=5");
}
hr_db.commit();
hr_db.close();
}
}catch (Exception ex){
	ex.printStackTrace();
}
}
}
