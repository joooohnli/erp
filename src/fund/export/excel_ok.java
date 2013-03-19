/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund.export;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.*;
import include.excel_export.XlsWriter;
import include.excel_export.excel;


public class excel_ok extends HttpServlet{
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


XlsWriter  xls=new XlsWriter();
excel query =new  excel();

xls.setDatabase((String)dbSession.getAttribute("unit_db_name"));
xls.setConfigFile("xml/fund/excel_export.xml");

String sql="";
String tablename="";
String realname=(String)session.getAttribute("realeditorc");
String table=(String)session.getAttribute("table");
String table1=(String)session.getAttribute("table1");
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String first_kind_name=(String)session.getAttribute("first_kind_name");
String second_kind_name=(String)session.getAttribute("second_kind_name");
String third_kind_name=(String)session.getAttribute("third_kind_name");
String customer_ID=(String)session.getAttribute("customer_ID");
String customer_name=(String)session.getAttribute("customer_name");
String purchaser_ID=(String)session.getAttribute("purchaser_ID");
String human_ID=(String)session.getAttribute("human_ID");
String human_name=(String)session.getAttribute("human_name");
String file_first_kind_name=(String)session.getAttribute("file_first_kind_name");
String file_second_kind_name=(String)session.getAttribute("file_second_kind_name");
if(table1.equals("销售应收款")){
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="fund_fund";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="funder_ID";
String condition="(fund_execute_tag='1' or  fund_pre_tag='0') and file_first_kind_name='应收账款'";
String queue="order by register_time";
sql=query.query(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,customer_ID,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}else if(table1.equals("采购应付款")){
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="fund_fund";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="sales_purchaser_ID";
String condition="(fund_execute_tag='1' or  fund_pre_tag='0') and file_first_kind_name='应付账款'";
String queue="order by register_time";
sql=query.query(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,purchaser_ID,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}else{
String dbase=(String)dbSession.getAttribute("unit_db_name");
tablename="fund_fund";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="funder_ID";
String condition="(fund_execute_tag='1' or  fund_pre_tag='0')";
String queue="order by register_time";
if(!file_second_kind_name.equals("工资")){
sql=query.query(dbase,tablename,timea,timeb,first_kind_name,second_kind_name,third_kind_name,human_ID,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}else{
sql=query.query(dbase,tablename,timea,timeb,"","","","",fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
}
int aa=sql.indexOf("order");
String sql1=sql.substring(aa-1,sql.length());
String sql2=sql.substring(0,aa-1);
	if(file_first_kind_name.equals("")&&file_second_kind_name.equals("")){
		sql2=sql2+" and file_first_kind_name like '%费用%'";
	}else if(!file_first_kind_name.equals("")&&!file_second_kind_name.equals("")){
		sql2=sql2+" and file_first_kind_name='"+file_first_kind_name+"' and file_second_kind_name='"+file_second_kind_name+"'";
	}else if(!file_first_kind_name.equals("")&&file_second_kind_name.equals("")){
		sql2=sql2+" and file_first_kind_name='"+file_first_kind_name+"'";
	}else{
		sql2=sql2+" and file_second_kind_name='"+file_second_kind_name+"'";
	}
	sql=sql2+sql1;
}
int a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
xls.setCondition(sql);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
xls.write(path+"excel_files/fund_data.xls");


response.sendRedirect("fund/export/excel_ok_a.jsp");

}catch(Exception ex){}
}
}

