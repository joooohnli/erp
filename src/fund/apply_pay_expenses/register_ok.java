/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund.apply_pay_expenses;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;

import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataRecordNumber;

public class register_ok extends HttpServlet{
//创建方法

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

	 String time="";
	 java.util.Date now = new java.util.Date();
	 SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	 time=formatter.format(now);
	
		
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

counter count=new  counter(dbApplication);
ValidataNumber validata=new  ValidataNumber();
ValidataRecord vr=new  ValidataRecord();
ValidataRecordNumber vrn= new  ValidataRecordNumber();
nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);

if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String kind_chain=request.getParameter("kind_chain");
String human=request.getParameter("human");
String[] file_kind=request.getParameterValues("file_kind") ;
String[] cost_price_subtotal=request.getParameterValues("cost_price_subtotal") ;
int p=0;
	for(int j=1;j<file_kind.length;j++){
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
if(p==0){	
String human_ID="";
String human_name="";
String chain_ID=kind_chain.split(" ")[0];
String chain_name=kind_chain.split(" ")[1];
if(human!=null&&!human.equals("")){
	human_ID=human.split("/")[0];
	human_name=human.split("/")[1];
}
int a=file_kind.length;
	double demand_cost_price_sum=0.0d;
	for(int j=1;j<file_kind.length;j++){
	//if(validata.validata(s))
	if(cost_price_subtotal[j].equals("")) cost_price_subtotal[j]="0";
	StringTokenizer tokenTO4 = new StringTokenizer(cost_price_subtotal[j],",");        
String cost_price_subtotal1="";
    while(tokenTO4.hasMoreTokens()) {
        cost_price_subtotal1+= tokenTO4.nextToken();
		}
	demand_cost_price_sum+=Double.parseDouble(cost_price_subtotal1);
}
if(demand_cost_price_sum>0){

String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String currency=request.getParameter("currency") ;
StringTokenizer tokenTO5 = new StringTokenizer(currency,"/");        
String currency_name="";
String personal_unit="";
    while(tokenTO5.hasMoreTokens()) {
        currency_name= tokenTO5.nextToken();
		personal_unit= tokenTO5.nextToken();
		}
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
try{	
	

	String apply_pay_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
	
	String sql33 = "delete from fund_apply_pay where apply_pay_ID='"+apply_pay_ID+"'" ;
	fund_db.executeUpdate(sql33);
	String sql44 = "delete from fund_apply_pay_details where apply_pay_ID='"+apply_pay_ID+"'" ;
	fund_db.executeUpdate(sql44);

List rsList = GetWorkflow.getList(fund_db, "fund_config_workflow", "01");
demand_cost_price_sum=0.0d;
for(int i=1;i<a;i++){
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
	String sql1 = "insert into fund_apply_pay_details(apply_pay_ID,details_number,file_chain_ID,file_chain_name,cost_price_subtotal) values ('"+apply_pay_ID+"','"+i+"','"+file_chain_ID+"','"+file_chain_name+"','"+cost_price_subtotal1+"')" ;
	fund_db.executeUpdate(sql1) ;
//**************************************	
	if(rsList.size()==0){
	if(vrn.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",apply_pay_ID)<a){
		
		String fund_ID=NseerId.getId("fund/pay",(String)dbSession.getAttribute("unit_db_name"));
	
	String sql2="insert into fund_fund(fund_ID,reason,reasonexact,chain_ID,chain_name,funder,funder_ID,file_chain_ID,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register_time,register) values('"+fund_ID+"','付款','"+apply_pay_ID+"','"+chain_ID+"','"+chain_name+"','"+human_name+"','"+human_ID+"','"+file_chain_ID+"','"+file_chain_name+"','"+cost_price_subtotal1+"','"+currency_name+"','"+personal_unit+"','"+register_time+"','"+register+"')";
	fund_db.executeUpdate(sql2) ;
}
	}
  sql1="update fund_config_file_kind set delete_tag='1' where file_ID='"+file_chain_ID+"'";
	fund_db.executeUpdate(sql1);//delete_tag为1说明分类被使用
}



if(rsList.size()==0){
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"fund_apply_pay","register_time",register_time)){
	String sql = "insert into fund_apply_pay(apply_pay_ID,chain_ID,chain_name,human_ID,human_name,register_time,demand_cost_price_sum,currency_name,personal_unit,remark,register,check_tag,excel_tag,reason) values ('"+apply_pay_ID+"','"+chain_ID+"','"+chain_name+"','"+human_ID+"','"+human_name+"','"+register_time+"','"+demand_cost_price_sum+"','"+currency_name+"','"+personal_unit+"','"+remark+"','"+register+"','1','2','费用')" ;
	fund_db.executeUpdate(sql) ;
}
}else{

if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"fund_apply_pay","register_time",register_time)){
	String sql = "insert into fund_apply_pay(apply_pay_ID,chain_ID,chain_name,human_ID,human_name,register_time,demand_cost_price_sum,currency_name,personal_unit,remark,register,check_tag,excel_tag,reason) values ('"+apply_pay_ID+"','"+chain_ID+"','"+chain_name+"','"+human_ID+"','"+human_name+"','"+register_time+"','"+demand_cost_price_sum+"','"+currency_name+"','"+personal_unit+"','"+remark+"','"+register+"','0','2','费用')" ;
	fund_db.executeUpdate(sql) ;
}
Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		String sql = "insert into fund_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+apply_pay_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		fund_db.executeUpdate(sql) ;
		}
}
response.sendRedirect("fund/apply_pay_expenses/register_ok.jsp?finished_tag=0");
}
catch (Exception ex){
	ex.printStackTrace();
}
}else{
response.sendRedirect("fund/apply_pay_expenses/register_ok.jsp?finished_tag=1");
}
}else{	
response.sendRedirect("fund/apply_pay_expenses/register_ok.jsp?finished_tag=2");
}
fund_db.commit();
hr_db.commit();
fund_db.close();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
}
}
}