/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.price_change;
 
 
import include.get_sql.getInsertSql;
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
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

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();

nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacture_db1 = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
getInsertSql getInsertSql=new getInsertSql();
counter count=new counter(dbApplication);
try{
	if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String product_ID=request.getParameter("product_ID") ;
String list_price2=request.getParameter("list_price") ;
StringTokenizer tokenTO4 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO4.hasMoreTokens()) {
                String list_price1 = tokenTO4.nextToken();
		list_price +=list_price1;
		}
String cost_price2=request.getParameter("cost_price") ;
StringTokenizer tokenTO5 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO5.hasMoreTokens()) {
                String cost_price1 = tokenTO5.nextToken();
		cost_price +=cost_price1;
		}
int n=0;
		if(!validata.validata(list_price)||Double.parseDouble(list_price)<0){
			n++;
		}
		if(!validata.validata(cost_price)||Double.parseDouble(cost_price)<0){
			n++;
		}
if(n==0){


String responsible_person_ID="";
String responsible_person_name="";
String first_kind=request.getParameter("select1");

String product_name=request.getParameter("product_name") ;
String factory_name=request.getParameter("factory_name") ;
String type=request.getParameter("type") ;
String product_class=request.getParameter("product_class") ;
String product_nick=request.getParameter("product_nick") ;
String twin_name=request.getParameter("twin_name") ;
String twin_ID=request.getParameter("twin_ID") ;
String personal_unit=request.getParameter("personal_unit") ;
String personal_value=request.getParameter("personal_value") ;
String warranty=request.getParameter("warranty") ;
String lifecycle=request.getParameter("lifecycle") ;
String amount_unit=request.getParameter("amount_unit") ;
String register=request.getParameter("register") ;
String bodya = new String(request.getParameter("product_describe").getBytes("UTF-8"),"UTF-8");
String product_describe=exchange.toHtml(bodya);
String changer_ID=request.getParameter("changer_ID") ;
String changer=request.getParameter("changer") ;
String change_time=request.getParameter("change_time") ;
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
int change_amount=Integer.parseInt(file_change_amount)+1;
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"design_file");
try{  
	String sqloo= "select * from design_file where product_ID='"+product_ID+"'";
	 ResultSet rsoo = design_db.executeQuery(sqloo);
	 if(rsoo.next()){
	String sqll="insert into design_file_dig(chain_id,chain_name,PRODUCT_ID,PRODUCT_NAME,PRODUCT_NICK,PRODUCT_CLASS,TYPE,AMOUNT_UNIT,PRODUCT_DESCRIBE,FACTORY_NAME,FACTORY_ID,PROVIDER_GROUP,PHOTO1,PHOTO2,WARRANTY,LIST_PRICE,COST_PRICE,REAL_COST_PRICE,LIFECYCLE,PERSONAL_UNIT,PERSONAL_VALUE,TWIN_NAME,TWIN_ID,REMARK,CHECK_TAG,ACHIEVEMENT_SUM,ATTACHMENT_NAME,RETURN_SUM,RETURN_AMOUNT,FILE_CHANGE_AMOUNT,USED_PRODUCT_NAME,RESPONSIBLE_PERSON_NAME,RESPONSIBLE_PERSON_ID,REGISTER,CHECKER,CHANGER,REGISTER_ID,CHECKER_ID,CHANGER_ID,REGISTER_TIME,CHECK_TIME,CHANGE_TIME,LATELY_CHANGE_TIME,LATELY_TRADE_TIME,DELETE_TIME,RECOVERY_TIME,MODIFY_TAG,EXCEL_TAG,EXCEL_TAG2,EXCEL_TAG3,EXCEL_TAG4,DESIGN_MODULE_TAG,DESIGN_PROCEDURE_TAG,DESIGN_CELL_TAG,RECOMMEND_PROVIDER_TAG,PRICE_CHANGE_TAG,PRICE_ALARM_TAG,promotion,opinion,promotion2,opinion2,promotion3,opinion3,promotion4,opinion4) values('"+rsoo.getString("chain_id")+"','"+rsoo.getString("chain_name")+"','"+rsoo.getString("PRODUCT_ID")+"','"+rsoo.getString("PRODUCT_NAME")+"','"+rsoo.getString("PRODUCT_NICK")+"','"+rsoo.getString("PRODUCT_CLASS")+"','"+rsoo.getString("TYPE")+"','"+rsoo.getString("AMOUNT_UNIT")+"','"+rsoo.getString("PRODUCT_DESCRIBE")+"','"+rsoo.getString("FACTORY_NAME")+"','"+rsoo.getString("FACTORY_ID")+"','"+rsoo.getString("PROVIDER_GROUP")+"','"+rsoo.getString("PHOTO1")+"','"+rsoo.getString("PHOTO2")+"','"+rsoo.getString("WARRANTY")+"','"+rsoo.getString("LIST_PRICE")+"','"+rsoo.getString("COST_PRICE")+"','"+rsoo.getString("REAL_COST_PRICE")+"','"+rsoo.getString("LIFECYCLE")+"','"+rsoo.getString("PERSONAL_UNIT")+"','"+rsoo.getString("PERSONAL_VALUE")+"','"+rsoo.getString("TWIN_NAME")+"','"+rsoo.getString("TWIN_ID")+"','"+rsoo.getString("REMARK")+"','"+rsoo.getString("CHECK_TAG")+"','"+rsoo.getString("ACHIEVEMENT_SUM")+"','"+rsoo.getString("ATTACHMENT_NAME")+"','"+rsoo.getString("RETURN_SUM")+"','"+rsoo.getString("RETURN_AMOUNT")+"','"+rsoo.getString("FILE_CHANGE_AMOUNT")+"','"+rsoo.getString("USED_PRODUCT_NAME")+"','"+rsoo.getString("RESPONSIBLE_PERSON_NAME")+"','"+rsoo.getString("RESPONSIBLE_PERSON_ID")+"','"+rsoo.getString("REGISTER")+"','"+rsoo.getString("CHECKER")+"','"+rsoo.getString("CHANGER")+"','"+rsoo.getString("REGISTER_ID")+"','"+rsoo.getString("CHECKER_ID")+"','"+rsoo.getString("CHANGER_ID")+"','"+rsoo.getString("REGISTER_TIME")+"','"+rsoo.getString("CHECK_TIME")+"','"+rsoo.getString("CHANGE_TIME")+"','"+rsoo.getString("LATELY_CHANGE_TIME")+"','"+rsoo.getString("LATELY_TRADE_TIME")+"','"+rsoo.getString("DELETE_TIME")+"','"+rsoo.getString("RECOVERY_TIME")+"','"+rsoo.getString("MODIFY_TAG")+"','"+rsoo.getString("EXCEL_TAG")+"','"+rsoo.getString("EXCEL_TAG2")+"','"+rsoo.getString("EXCEL_TAG3")+"','"+rsoo.getString("EXCEL_TAG4")+"','"+rsoo.getString("DESIGN_MODULE_TAG")+"','"+rsoo.getString("DESIGN_PROCEDURE_TAG")+"','"+rsoo.getString("DESIGN_CELL_TAG")+"','"+rsoo.getString("RECOMMEND_PROVIDER_TAG")+"','"+rsoo.getString("PRICE_CHANGE_TAG")+"','"+rsoo.getString("PRICE_ALARM_TAG")+"','"+rsoo.getString("promotion")+"','"+rsoo.getString("opinion")+"','"+rsoo.getString("promotion2")+"','"+rsoo.getString("opinion2")+"','"+rsoo.getString("promotion3")+"','"+rsoo.getString("opinion3")+"','"+rsoo.getString("promotion4")+"','"+rsoo.getString("opinion4")+"')";
		design_db.executeUpdate(sqll);
	 }

	 List rsList = GetWorkflow.getList(design_db, "design_config_workflow", "02");
   if(rsList.size()==0){

   String sql = "update design_file set product_name='"+product_name+"',factory_name='"+factory_name+"',product_class='"+product_class+"',type='"+type+"',twin_name='"+twin_name+"',twin_ID='"+twin_ID+"',personal_unit='"+personal_unit+"',personal_value='"+personal_value+"',warranty='"+warranty+"',lifecycle='"+lifecycle+"',product_nick='"+product_nick+"',list_price='"+list_price+"',cost_price='"+cost_price+"',product_describe='"+product_describe+"',responsible_person_name='"+responsible_person_name+"',responsible_person_ID='"+responsible_person_ID+"',amount_unit='"+amount_unit+"',changer_ID='"+changer_ID+"',changer='"+changer+"',change_time='"+change_time+"',lately_change_time='"+lately_change_time+"',file_change_amount='"+change_amount+"',price_change_tag='0',check_tag='1' where product_ID='"+product_ID+"'" ;
	design_db.executeUpdate(sql) ;

String sql4="select * from design_module_details where product_ID='"+product_ID+"'";
	ResultSet rs4=design_db.executeQuery(sql4);
	while(rs4.next()){
		double subtotal1=Double.parseDouble(cost_price)*rs4.getDouble("amount");
		double subtotal3=subtotal1-rs4.getDouble("subtotal");
		String sql6="select * from design_module where design_ID='"+rs4.getString("design_ID")+"'";
		ResultSet rs6=design_db1.executeQuery(sql6);
		if(rs6.next()){
			double subtotal5=rs6.getDouble("cost_price_sum")+subtotal3;
			String sql8="update design_module set cost_price_sum='"+subtotal5+"' where design_ID='"+rs4.getString("design_ID")+"'";
			design_db1.executeUpdate(sql8);
		}
	String sql1="update design_module_details set cost_price='"+cost_price+"',subtotal='"+subtotal1+"' where product_ID='"+product_ID+"'";
	design_db1.executeUpdate(sql1);
	}
	String sql5="select * from manufacture_design_procedure_module_details where product_ID='"+product_ID+"'";
	ResultSet rs5=manufacture_db.executeQuery(sql5);
	if(rs5.next()){
		double subtotal2=Double.parseDouble(cost_price)*rs5.getDouble("amount");
		double subtotal4=subtotal2-rs5.getDouble("subtotal");
		String sql7="select * from manufacture_design_procedure_details where design_ID='"+rs5.getString("design_ID")+"' and procedure_name='"+rs5.getString("procedure_name")+"'";
		ResultSet rs7=manufacture_db1.executeQuery(sql7);
		if(rs7.next()){
			double subtotal6=rs7.getDouble("module_subtotal")+subtotal4;
			String sql9="update manufacture_design_procedure_details set module_subtotal='"+subtotal6+"' where design_ID='"+rs5.getString("design_ID")+"' and procedure_name='"+rs5.getString("procedure_name")+"'";
			manufacture_db1.executeUpdate(sql9);
		}
		String sql11="select * from manufacture_design_procedure where design_ID='"+rs5.getString("design_ID")+"'";
		ResultSet rs11=manufacture_db1.executeQuery(sql11);
		if(rs11.next()){
			double subtotal8=rs11.getDouble("module_cost_price_sum")+subtotal4;
			String sql13="update manufacture_design_procedure set module_cost_price_sum='"+subtotal8+"' where design_ID='"+rs5.getString("design_ID")+"'";
			manufacture_db1.executeUpdate(sql13);
		}
			String sql3="update manufacture_design_procedure_module_details set cost_price='"+cost_price+"',subtotal='"+subtotal2+"' where product_ID='"+product_ID+"'";
			manufacture_db1.executeUpdate(sql3) ;
	}


	}else{
	String sql = "update design_file set product_name='"+product_name+"',factory_name='"+factory_name+"',product_class='"+product_class+"',type='"+type+"',twin_name='"+twin_name+"',twin_ID='"+twin_ID+"',personal_unit='"+personal_unit+"',personal_value='"+personal_value+"',warranty='"+warranty+"',lifecycle='"+lifecycle+"',product_nick='"+product_nick+"',list_price='"+list_price+"',cost_price='"+cost_price+"',product_describe='"+product_describe+"',responsible_person_name='"+responsible_person_name+"',responsible_person_ID='"+responsible_person_ID+"',amount_unit='"+amount_unit+"',changer_ID='"+changer_ID+"',changer='"+changer+"',change_time='"+change_time+"',lately_change_time='"+lately_change_time+"',file_change_amount='"+change_amount+"',price_change_tag='1' where product_ID='"+product_ID+"'" ;
		design_db.executeUpdate(sql) ;
	
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
			String[] elem=(String[])ite.next();
		sql = "insert into design_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+product_ID+"','"+elem[1]+"','"+elem[2]+"','02')" ;
	
		design_db.executeUpdate(sql);
		}
	}
	
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("design/price_change/register_ok_a.jsp");
}else{
	
response.sendRedirect("design/price_change/register_ok_c.jsp?product_ID="+product_ID+"");
}
design_db.commit();
design_db1.commit();
manufacture_db.commit();
manufacture_db1.commit();
design_db.close();
design_db1.close();
manufacture_db.close();
manufacture_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}