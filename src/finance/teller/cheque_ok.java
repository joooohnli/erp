/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.teller;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import java.util.* ;
import include.nseer_db.*;

public class cheque_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);

try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String file_id=request.getParameter("file_id");
String cols_value=request.getParameter("cols_value");
String finance_cheque_id=request.getParameter("finance_cheque_id");
int i=0;
String temp_value="";
StringTokenizer tk1=new StringTokenizer(cols_value,"□");
while(tk1.hasMoreTokens()){

StringTokenizer tk=new StringTokenizer(tk1.nextToken(),"◇");
String[] value=new String[tk.countTokens()];//
	while(tk.hasMoreTokens()){
      temp_value=tk.nextToken();
	  if(i==0||i==10||i==11){
		  value[i]=temp_value.equals("⊙")?"1800-01-01":temp_value;
	  }
	  else{
		value[i]=temp_value.equals("⊙")?"":temp_value;
	  }
	  i++;
}
i=0;
String sql2="select id from finance_cheque where id='"+value[15]+"'";
ResultSet rs2=finance_db.executeQuery(sql2);
String sql="";
if(rs2.next()){
	sql="update finance_cheque set register_time='"+value[0]+"',chain_id='',chain_name='"+value[1]+"',human_id='',human_name='"+value[2]+"',cheque_id='"+value[3]+"',pre_subtotal='"+value[4]+"',field='"+value[5]+"',gatherer='"+value[6]+"',chain_mate_id='"+value[7]+"',bank='"+value[8]+"',account='"+value[9]+"',pre_trans_time='"+value[10]+"',reim_time='"+value[11]+"',remark='"+value[12]+"',real_subtotal='"+value[13]+"',password='"+value[14]+"',file_id='"+file_id+"' where id='"+value[15]+"'";
}else{
sql="insert into finance_cheque(register_time,chain_id,chain_name,human_id,human_name,cheque_id,pre_subtotal,field,gatherer,chain_mate_id,bank,account,pre_trans_time,reim_time,remark,real_subtotal,password,file_id) values('"+value[0]+"','','"+value[1]+"','','"+value[2]+"','"+value[3]+"','"+value[4]+"','"+value[5]+"','"+value[6]+"','"+value[7]+"','"+value[8]+"','"+value[9]+"','"+value[10]+"','"+value[11]+"','"+value[12]+"','"+value[13]+"','"+value[14]+"','"+file_id+"')";
}
    finance_db.executeUpdate(sql);
String sql1="update finance_config_file_kind set delete_tag='1' where file_id='"+file_id+"'";
	finance_db.executeUpdate(sql1);//delete_tag为1说明被使用	

}
    finance_db.commit();
    finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}