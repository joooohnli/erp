/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.config.procedure;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class itemName_delete_ok extends HttpServlet{

ServletContext application;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
HttpSession session=request.getSession();

try{
int i;
int intRowCount;
if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String sqll = "select * from manufacture_config_public_char where kind='工序' order by type_ID" ;
ResultSet rs=manufacture_db.executeQuery(sqll) ;
rs.next();
rs.last();
intRowCount=rs.getRow();
String[] del=new String[intRowCount];
del=(String[])session.getAttribute("del");
String[] real_del=new String[intRowCount];
String[] procedure_name=new String[intRowCount];
int n=0;
int m=0;
if(del!=null){
for(i=1;i<=intRowCount;i++){
	try{
	if(del[i-1]!=null){
		real_del[n]=del[i-1];
		n++;
	int p=0;
	String type_name="";
	String sql2="select * from manufacture_config_public_char where id='"+del[i-1]+"'" ;
	ResultSet rs2=manufacture_db.executeQuery(sql2) ;
	if(rs2.next()){
		type_name=rs2.getString("type_name");
	String sql3="select * from manufacture_design_procedure_details where procedure_name='"+type_name+"'" ;
	ResultSet rs3=manufacture_db.executeQuery(sql3) ;
	if(rs3.next()) p++;
	String sql4="select * from manufacture_procedure where procedure_name='"+type_name+"' and procedure_finish_tag!='2'" ;
	ResultSet rs4=manufacture_db.executeQuery(sql4) ;
	if(rs4.next()) p++;
	}
	if(p==0){
	String sql = "delete from manufacture_config_public_char where id='"+del[i-1]+"'" ;
    manufacture_db.executeUpdate(sql) ;
	}else{
			procedure_name[m]=type_name;
			m++;
	}
}

	}
	catch (Exception ex) {
		ex.printStackTrace();
	}
	}
}

if(n==0){
response.sendRedirect("manufacture/config/procedure/itemName.jsp");
}else{
	if(m<n&&m!=0){
		session.setAttribute("procedure_name",procedure_name);
	session.setAttribute("first_kind_count",m+"");
response.sendRedirect("manufacture/config/procedure/itemName_delete_ok_b.jsp");
}else if(m==n){
		response.sendRedirect("manufacture/config/procedure/itemName_delete_ok_c.jsp");
}else if(m==0){
	response.sendRedirect("manufacture/config/procedure/itemName_delete_ok_d.jsp");
}
}
  manufacture_db.commit();
  manufacture_db.close();
}else{
	response.sendRedirect("error_conn.htm");
    }

}
catch (Exception ex){
ex.printStackTrace();
}
}
}