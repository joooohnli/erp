package draft.fund;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;

import include.nseer_cookie.GetWorkflow;
import include.nseer_db.*;
import java.text.*;
import validata.ValidataNumber;

public class pay_check_ok extends HttpServlet{
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

nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataNumber  validata= new ValidataNumber();

java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String fund_ID=request.getParameter("fund_ID");
String pay_time=request.getParameter("pay_time");
String file_chain_name=request.getParameter("file_chain_name");
String funder=request.getParameter("funder");
String apply_ID_group=request.getParameter("apply_ID_group");
String checker=request.getParameter("register") ;
String checker_ID=request.getParameter("register_ID") ;
String check_time=request.getParameter("register_time") ;
String currency_name=request.getParameter("currency_name") ;
String personal_unit=request.getParameter("personal_unit") ;
String[] id=request.getParameterValues("id") ;
String[] fund_chain_ID=request.getParameterValues("fund_chain_ID");
String[] fund_chain_name=request.getParameterValues("fund_chain_name");
String[] account_bank=request.getParameterValues("account_bank");
String[] account_ID=request.getParameterValues("account_ID");
String[] cost_price_subtotal=request.getParameterValues("cost_price_subtotal") ;
String[] executed_cost_price_subtotal=request.getParameterValues("executed_cost_price_subtotal") ;
String[] execute_method=request.getParameterValues("execute_method");
String[] bill_ID=request.getParameterValues("bill_ID");
String[] subtotal=request.getParameterValues("subtotal");
String[] details_number=request.getParameterValues("details_number");
int p=0;
for(int i=0;i<account_ID.length;i++){
	if(!subtotal[i].equals("")){
		String subtotal1="";
		StringTokenizer tokenTO = new StringTokenizer(subtotal[i],",");        
		while(tokenTO.hasMoreTokens()) {
			subtotal1+=tokenTO.nextToken();
		}
		if(!validata.validata(subtotal1)){
			p++;
		}
		if(bill_ID[i].indexOf("'")!=-1||bill_ID[i].indexOf("\"")!=-1||bill_ID[i].indexOf(",")!=-1){
		p++;
		}
	}
}
if(p==0){
int n=0;
	String account_ID_control=account_ID[0];
	String account_ID_control1=fund_chain_ID[0];
	double fund_control=0.0d;
for(int i=0;i<account_ID.length;i++){
	if(!subtotal[i].equals("")){
		StringTokenizer tokenTO4 = new StringTokenizer(subtotal[i],",");        
		String subtotal1="";
		while(tokenTO4.hasMoreTokens()) {
			subtotal1+= tokenTO4.nextToken();
		}
if(Math.abs(Double.parseDouble(subtotal1)+Double.parseDouble(executed_cost_price_subtotal[i]))>Math.abs(Double.parseDouble(cost_price_subtotal[i]))){
		n++;
		}
	if(account_ID[i].equals(account_ID_control)&&fund_chain_ID[i].equals(account_ID_control1)){
		fund_control+=Double.parseDouble(subtotal1);
		if(Math.abs(fund_control+Double.parseDouble(executed_cost_price_subtotal[i]))>Math.abs(Double.parseDouble(cost_price_subtotal[i]))){
		n++;
		}
		}else{
		account_ID_control=account_ID[i];
		account_ID_control1=fund_chain_ID[i];
		fund_control=Double.parseDouble(subtotal1);
		}
	}
}
if(n==0){
String sql8="select id from fund_fund where fund_ID='"+fund_ID+"' and (check_tag='9' or check_tag='5') and reason='付款' and pay_time='"+pay_time+"'";
	ResultSet rs8=fund_db.executeQuery(sql8);
	if(rs8.next()){
boolean flag=false;
List rsList = GetWorkflow.getList(fund_db, "fund_config_workflow", "03");
	if(rsList.size()==0) flag=true;
try{
	if(flag){
for(int i=0;i<account_ID.length;i++){
		String sql4="update fund_executing set check_tag='1' where id='"+id[i]+"' and check_tag='0'";
		fund_db.executeUpdate(sql4);
	}
	}
double cost_price_sum=0.0d;
for(int i=0;i<account_ID.length;i++){
	if(subtotal[i].equals("")) subtotal[i]="0";
		String subtotaling="";
		StringTokenizer tokenTO = new StringTokenizer(subtotal[i],",");        
		while(tokenTO.hasMoreTokens()) {
			subtotaling+=tokenTO.nextToken();
		}
if(Double.parseDouble(subtotaling)!=0){
	cost_price_sum+=Double.parseDouble(subtotaling);
		String sql4="update fund_executing set subtotal='"+subtotaling+"',register='"+checker+"',register_ID='"+checker_ID+"',register_time='"+check_time+"',execute_method='"+execute_method[i]+"',bill_ID='"+bill_ID[i]+"' where id='"+id[i]+"'";
		fund_db.executeUpdate(sql4);
		if(flag){
		String sql11="select * from fund_details where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
		ResultSet rs11=fund_db.executeQuery(sql11);
		if(rs11.next()){
			double subtotal5=rs11.getDouble("executed_cost_price_subtotal")+Double.parseDouble(subtotaling);
			if(rs11.getDouble("cost_price_subtotal")==subtotal5){
				String sql="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_details_tag='2',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql);
			}else{
				String sql12="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql12);
			}
		}
		}
	}else if(Double.parseDouble(subtotaling)==0){
		String sql44="delete from fund_executing where id='"+id[i]+"'";
		fund_db.executeUpdate(sql44);
		if(flag){
		String sql11="select * from fund_details where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
		ResultSet rs11=fund_db.executeQuery(sql11);
		if(rs11.next()){
			double subtotal5=rs11.getDouble("executed_cost_price_subtotal")+Double.parseDouble(subtotaling);
			if(rs11.getDouble("cost_price_subtotal")==subtotal5){
				String sql="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_details_tag='2',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql);
			}else{
				String sql12="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql12);
			}
		}
		}
	}
}
if(flag){
String sql18="select * from fund_fund where fund_ID='"+fund_ID+"'"; 
	ResultSet rs18=fund_db.executeQuery(sql18);
	if(rs18.next()){
		double subtotal7=rs18.getDouble("executed_cost_price_sum")+cost_price_sum;
		String sql19="update fund_fund set executed_cost_price_sum='"+subtotal7+"',register='"+checker+"',register_ID='"+checker_ID+"',register_time='"+check_time+"' where fund_ID='"+fund_ID+"'";
		fund_db.executeUpdate(sql19);
	}
	
	if(file_chain_name.indexOf("工资")!=-1){
		StringTokenizer tokenTO2 = new StringTokenizer(apply_ID_group,", ");        
		while(tokenTO2.hasMoreTokens()) {
			hr_db.executeUpdate("update hr_salary set pay_tag='2' where salary_ID='"+tokenTO2.nextToken()+"'");
		}
	}
	
	String sql16="select * from fund_details where fund_ID='"+fund_ID+"' and execute_details_tag!='2'";
	ResultSet rs16=fund_db.executeQuery(sql16);
	if(!rs16.next()){
		String sql17="update fund_fund set finish_time='"+time+"',execute_tag='2',fund_tag='1' where fund_ID='"+fund_ID+"'";
		fund_db.executeUpdate(sql17);
		if(file_chain_name.indexOf("工资")!=-1){
		StringTokenizer tokenTO1 = new StringTokenizer(apply_ID_group,", ");        
		while(tokenTO1.hasMoreTokens()) {
			hr_db.executeUpdate("update hr_salary set pay_tag='3' where salary_ID='"+tokenTO1.nextToken()+"'");
		}
	}else if(file_chain_name.indexOf("费用")!=-1){
		StringTokenizer tokenTO1 = new StringTokenizer(apply_ID_group,", ");        
		while(tokenTO1.hasMoreTokens()) {
			String apply_pay_ID=tokenTO1.nextToken();
			ResultSet rs21=fund_db1.executeQuery("select * from fund_fund where reasonexact='"+apply_pay_ID+"' and fund_pre_tag='0'");
			ResultSet rs20=fund_db.executeQuery("select * from fund_fund where apply_ID_group like '%"+apply_pay_ID+"%' and fund_execute_tag='1' and fund_tag!='1'");
			if(!rs20.next()&&!rs21.next()){
			fund_db.executeUpdate("update fund_apply_pay set apply_tag='1',pay_tag='2' where apply_pay_ID='"+apply_pay_ID+"'");
			}
		}
	}
response.sendRedirect("draft/fund/pay_ok.jsp?finished_tag=8");
}
	}else{
		String sql="update fund_fund set check_tag='1' where fund_ID='"+fund_ID+"'";
		fund_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into fund_workflow(config_id,object_ID,describe1,describe2,pay_time) values ('"+elem[0]+"','"+fund_ID+"','"+elem[1]+"','"+elem[2]+"','"+pay_time+"')" ;
		fund_db.executeUpdate(sql) ;
		}
		response.sendRedirect("draft/fund/pay_ok.jsp?finished_tag=4");
	}
}
catch (Exception ex){
ex.printStackTrace();
}
}else{	
response.sendRedirect("draft/fund/pay_ok.jsp?finished_tag=5");
}
}else{
response.sendRedirect("draft/fund/pay_ok.jsp?finished_tag=6");
}}else{	
response.sendRedirect("draft/fund/pay_ok.jsp?finished_tag=7");
}
fund_db.commit();
fund_db1.commit();
hr_db.commit();
hr_db.close();
fund_db.close();
fund_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
ex.printStackTrace();
}
}
}
