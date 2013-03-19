package draft.fund;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.* ;

import include.nseer_cookie.GetWorkflow;
import include.nseer_db.*;
import java.text.*;
import validata.ValidataNumber;
import include.auto_execute.GatherSumLimit;
import include.auto_execute.GatherExpiry;
import purchase.Fieldvalue;

public class gather_draft_ok extends HttpServlet{
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
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataNumber validata= new  ValidataNumber();
GatherSumLimit gatherSum= new  GatherSumLimit();
GatherExpiry gatherExpiry= new  GatherExpiry();
Fieldvalue fieldValue= new  Fieldvalue();

java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String fund_ID=request.getParameter("fund_ID");
String gather_time=request.getParameter("gather_time");
String register=request.getParameter("checker") ;
String register_ID=request.getParameter("checker_ID") ;
String register_time=request.getParameter("check_time") ;
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
		String subtotal1="";
		StringTokenizer tokenTO = new StringTokenizer(subtotal[i],",");        
		while(tokenTO.hasMoreTokens()) {
			subtotal1+=tokenTO.nextToken();
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
String sql8="select id from fund_fund where fund_ID='"+fund_ID+"' and (check_tag='9' or check_tag='5') and reason='收款' and gather_time='"+gather_time+"'";
	ResultSet rs8=fund_db.executeQuery(sql8);
	if(rs8.next()){
		try{
			double cost_price_sum=0.0d;
			for(int i=0;i<account_ID.length;i++){
			if(!subtotal[i].equals("")){
				String subtotaling="";
				StringTokenizer tokenTO = new StringTokenizer(subtotal[i],",");        
				while(tokenTO.hasMoreTokens()) {
					subtotaling+=tokenTO.nextToken();
				}
				String sql="update fund_details set execute_details_tag='1',execute_check_tag='1' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql);	
				String sql4="update fund_executing set fund_chain_ID='"+fund_chain_ID[i]+"',details_number='"+details_number[i]+"',fund_chain_name='"+fund_chain_name[i]+"',account_bank='"+account_bank[i]+"',account_ID='"+account_ID[i]+"',subtotal='"+subtotaling+"',cost_price_subtotal='"+cost_price_subtotal[i]+"',register='"+register+"',register_time='"+register_time+"',executed_cost_price_subtotal='"+executed_cost_price_subtotal[i]+"',execute_method='"+execute_method[i]+"',bill_ID='"+bill_ID[i]+"',currency_name='"+currency_name+"',personal_unit='"+personal_unit+"' where fund_ID='"+fund_ID+"' and gather_time='"+gather_time+"'";
				fund_db.executeUpdate(sql4);
				
			}
			}
			response.sendRedirect("draft/fund/gather_ok.jsp?finished_tag=0");
		}
		catch (Exception ex){
		ex.printStackTrace();
		}
}else{	
response.sendRedirect("draft/fund/gather_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("draft/fund/gather_ok.jsp?finished_tag=6");
}
}else{	
response.sendRedirect("draft/fund/gather_ok.jsp?finished_tag=7");
}
fund_db.commit();
hr_db.commit();
crm_db.commit();
    fund_db.close();
	crm_db.close();
	hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
ex.printStackTrace();
}
}
}

