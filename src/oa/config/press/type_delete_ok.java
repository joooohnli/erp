/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.config.press;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.* ;
import include.nseer_db.*;


public class type_delete_ok extends HttpServlet{
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

nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){


int i;
int intRowCount;
String sqll = "select * from oa_config_public_char where kind='公共关系分类' order by id" ;
ResultSet rs=oa_db.executeQuery(sqll) ;
rs.next();
rs.last();
intRowCount=rs.getRow();
String[] del=new String[intRowCount];
del=(String[])session.getAttribute("del");
String[] type_name=new String[intRowCount];
String[] real_del=new String[intRowCount];
int m=0;
int n=0;
if(del!=null){
for(i=1;i<=intRowCount;i++){
try{
	if(del[i-1]!=null){
		real_del[n]=del[i-1];
		n++;
	String sql2="select * from oa_config_public_char where id='"+del[i-1]+"'" ;
ResultSet rs2=oa_db.executeQuery(sql2) ;
if(rs2.next()){
	type_name[i-1]=rs2.getString("type_name");
}
	String sql = "delete from oa_config_public_char where id='"+del[i-1]+"'" ;
    oa_db.executeUpdate(sql) ;
}
}
	catch (Exception ex) {
		out.println("error"+ex);
	}
	}
}

if(n==0){
	response.sendRedirect("oa/config/press/type.jsp");
}else{
if(m<n&&m!=0){

 out.println("<table width=\"100%\" border=\"0\" width=\"100%\" cellpadding=\"2\">");
     out.println("<tr>");
       out.println("<td><font color=\"#1A98F1\">您正在做的业务是：客户关系--客户化设置--客户档案管理设置--I级分类设置</font></td>");
     out.println("</tr>");
   out.println("</table>");
   out.println("<table width=\"100%\" border=\"0\" cellpadding=\"2\" width=\"100%\">");
     out.println("<tr>");
       out.println("<td align=\"left\">因为");
	   for(int j=0;j<m;j++){
		   out.println(type_name[j]+",");
	   }
	   out.println("正在应用，无法删除，其他均已删除！请返回。</td>");
	   out.println("<td align=\"right\"><input type=\"button\" value=\"返回\" name=\"B2\" style=\"width:59; height:19\" onClick=location=\"oa/config/press/type.jsp\"></td>");
     out.println("</tr>");
   out.println("</table>");

	}else if(m==n){
response.sendRedirect("oa/config/press/type_delete_ok_a.jsp");

}else if(m==0){
response.sendRedirect("oa/config/press/type_delete_ok_b.jsp");
}
}
oa_db.commit();
oa_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}



