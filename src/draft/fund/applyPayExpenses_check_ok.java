package draft.fund;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.counter;
import validata.ValidataRecordNumber;
import validata.ValidataTag;
import validata.ValidataNumber;
import include.nseer_cookie.*;
public class applyPayExpenses_check_ok extends HttpServlet{
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

if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db1.conn((String)dbSession.getAttribute("unit_db_name"))){

counter  count= new  counter(dbApplication);
ValidataRecordNumber vrn= new  ValidataRecordNumber();
ValidataTag  vt= new ValidataTag();
ValidataNumber validata=new  ValidataNumber();
try{
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

String apply_pay_ID=request.getParameter("apply_pay_ID") ;
String register_time=request.getParameter("register_time") ;
String register=request.getParameter("register") ;
String register_ID=request.getParameter("register_ID") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String amount=request.getParameter("amount") ;
String[] file_kind=request.getParameterValues("file_kind") ;
String[] cost_price_subtotal=request.getParameterValues("cost_price_subtotal") ;
int p=0;
String file_kinda=",";
	for(int j=1;j<file_kind.length;j++){
		file_kinda+=file_kind[j]+",";
	if(cost_price_subtotal[j].equals("")) cost_price_subtotal[j]="0";
	StringTokenizer tokenTO4 = new StringTokenizer(cost_price_subtotal[j],",");        
String cost_price_subtotal1="";
    while(tokenTO4.hasMoreTokens()) {
        cost_price_subtotal1+= tokenTO4.nextToken();
		}
	if(!validata.validata(cost_price_subtotal1)){
	p++;
	}
}
int n=0;
for(int i=1;i<=Integer.parseInt(amount);i++){
	String file_kind2=request.getParameter("file_kind"+i);
	String cost_price_subtotal2=request.getParameter("cost_price_subtotal"+i);
	if(file_kinda.indexOf(file_kind2)!=-1) n++;
	if(!validata.validata(cost_price_subtotal2)) p++;
}
if(Integer.parseInt(amount)==0&&file_kind.length==1){
	response.sendRedirect("draft/fund/applyPayExpenses_ok_a.jsp?apply_pay_ID="+apply_pay_ID);
}else{
if(n==0){
if(p==0){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"fund_apply_pay","apply_pay_ID",apply_pay_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"fund_apply_pay","apply_pay_ID",apply_pay_ID,"check_tag").equals("9")){
List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	String sql="select id,describe1,describe2 from fund_config_workflow where type_id='01'";
	ResultSet rset=fund_db.executeQuery(sql);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}

String currency_name="";
String personal_unit="";
String chain_ID="";
String chain_name="";
String funder="";
String funder_ID="";
String sql11="select * from fund_apply_pay where apply_pay_ID='"+apply_pay_ID+"'";
ResultSet rs11=fund_db.executeQuery(sql11) ;
while(rs11.next()){
	chain_ID=rs11.getString("chain_ID");
	chain_name=rs11.getString("chain_name");
	funder=rs11.getString("human_name");
	funder_ID=rs11.getString("human_ID");
	currency_name=rs11.getString("currency_name");
	personal_unit=rs11.getString("personal_unit");
}
int expenses_amount=0;
String sql6="select count(*) from fund_apply_pay_details where apply_pay_ID='"+apply_pay_ID+"'";
ResultSet rs6=fund_db.executeQuery(sql6) ;
if(rs6.next()){
expenses_amount=rs6.getInt("count(*)");
}
double demand_cost_price_sum=0.0d;
for(int i=1;i<=expenses_amount;i++){
	String tem_cost_price_subtotal="cost_price_subtotal"+i;
	String cost_price_subtotal2=request.getParameter(tem_cost_price_subtotal);
	demand_cost_price_sum+=Double.parseDouble(cost_price_subtotal2);
	sql6="update fund_apply_pay_details set cost_price_subtotal='"+cost_price_subtotal2+"' where apply_pay_ID='"+apply_pay_ID+"' and details_number='"+i+"'";
	fund_db.executeUpdate(sql6) ;
}
for(int i=1;i<file_kind.length;i++){
StringTokenizer tokenTO1 = new StringTokenizer(file_kind[i],"/");        
String file_chain_ID="";
String file_chain_name="";
    while(tokenTO1.hasMoreTokens()) {
        file_chain_ID = tokenTO1.nextToken();
		file_chain_name = tokenTO1.nextToken();
		}
StringTokenizer tokenTO4 = new StringTokenizer(cost_price_subtotal[i],",");        
String cost_price_subtotal1="";
    while(tokenTO4.hasMoreTokens()) {
        cost_price_subtotal1+= tokenTO4.nextToken();
		}
	demand_cost_price_sum+=Double.parseDouble(cost_price_subtotal1);
	expenses_amount++;
	String sql1 = "insert into fund_apply_pay_details(apply_pay_ID,details_number,file_chain_ID,file_chain_name,cost_price_subtotal) values ('"+apply_pay_ID+"','"+expenses_amount+"','"+file_chain_ID+"','"+file_chain_name+"','"+cost_price_subtotal1+"')" ;
	fund_db.executeUpdate(sql1) ;
}
if(rsList.size()==0){
	sql = "update fund_apply_pay set demand_cost_price_sum='"+demand_cost_price_sum+"',check_tag='1',register_time='"+register_time+"',register='"+register+"',remark='"+remark+"' where apply_pay_ID='"+apply_pay_ID+"'" ;
	fund_db.executeUpdate(sql) ;

}else{

	sql = "update fund_apply_pay set demand_cost_price_sum='"+demand_cost_price_sum+"',check_tag='0',register_time='"+register_time+"',register='"+register+"',remark='"+remark+"' where apply_pay_ID='"+apply_pay_ID+"'" ;
	fund_db.executeUpdate(sql) ;
Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into fund_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+apply_pay_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		fund_db.executeUpdate(sql) ;
		}
}
if(rsList.size()==0){
String sql1="select * from fund_apply_pay_details where apply_pay_ID='"+apply_pay_ID+"' order by details_number";
ResultSet rs1=fund_db.executeQuery(sql1) ;
while(rs1.next()){	
if(vrn.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",apply_pay_ID)<expenses_amount){
String fund_ID=NseerId.getId("fund/pay",(String)dbSession.getAttribute("unit_db_name"));   
	String sql2="insert into fund_fund(fund_ID,reason,reasonexact,chain_ID,chain_name,funder,funder_ID,file_chain_ID,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register_time,register) values('"+fund_ID+"','付款','"+apply_pay_ID+"','"+chain_ID+"','"+chain_name+"','"+funder+"','"+funder_ID+"','"+rs1.getString("file_chain_ID")+"','"+rs1.getString("file_chain_name")+"','"+rs1.getString("cost_price_subtotal")+"','"+currency_name+"','"+personal_unit+"','"+register_time+"','"+register+"')";	
	fund_db1.executeUpdate(sql2) ;
}
}
}
response.sendRedirect("draft/fund/applyPayExpenses_ok.jsp?finished_tag=4");
}else{
response.sendRedirect("draft/fund/applyPayExpenses_ok.jsp?finished_tag=5");
}
}else{
response.sendRedirect("draft/fund/applyPayExpenses_ok.jsp?finished_tag=6");
}
}else{
response.sendRedirect("draft/fund/applyPayExpenses_ok.jsp?finished_tag=7");
}
}
}
catch (Exception ex){
	ex.printStackTrace();
}
fund_db.commit();
fund_db1.commit();
fund_db.close();
	fund_db1.close();
	}else{
	response.sendRedirect("error_conn.htm");
}
}
catch(Exception ex){
	ex.printStackTrace();
}
}
}
