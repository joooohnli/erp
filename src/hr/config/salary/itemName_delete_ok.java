/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.config.salary;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.sql.*;
import java.io.*; 
import include.nseer_db.*;

public class itemName_delete_ok extends HttpServlet{
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

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr1_db = new nseer_db_backup1(dbApplication);

if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr1_db.conn((String)dbSession.getAttribute("unit_db_name"))){

int i;
int intRowCount;
String sqll = "select * from hr_config_public_char where kind='薪酬项目'" ;
ResultSet rs=hr_db.executeQuery(sqll) ;
rs.last();
intRowCount=rs.getRow();
String[] del=new String[intRowCount];
del=(String[])session.getAttribute("del");
if(del!=null){
for(i=1;i<=intRowCount;i++){
try{
	if(del[i-1]!=null){
	String sql2="select * from hr_config_public_char where id='"+del[i-1]+"'";
	ResultSet rs2=hr_db.executeQuery(sql2) ;
	if(rs2.next()){
		String item_name=rs2.getString("type_name");
		String sql4="select * from hr_salary_standard_details where item_name='"+item_name+"'";
		ResultSet rs4=hr_db.executeQuery(sql4) ;

		while(rs4.next()){
			String sql5="select * from hr_salary_standard where standard_ID='"+rs4.getString("standard_ID")+"'";
			ResultSet rs5=hr1_db.executeQuery(sql5) ;

			if(rs5.next()){
				double salary_sum=rs5.getDouble("salary_sum")-rs4.getDouble("salary");
				String sql6="update hr_salary_standard set salary_sum='"+salary_sum+"' where id='"+rs5.getString("id")+"'";
				hr1_db.executeUpdate(sql6) ;

				String sql7="update hr_file set salary_sum='"+salary_sum+"' where salary_standard_ID='"+rs4.getString("standard_ID")+"'";
				hr1_db.executeUpdate(sql7) ;

			}
		}
		String sql3="delete from hr_salary_standard_details where item_name='"+item_name+"'";
		hr_db.executeUpdate(sql3) ;
	}
	
	String sql = "delete from hr_config_public_char where id='"+del[i-1]+"'" ;
    hr_db.executeUpdate(sql) ;
	
	}
	}
	catch (Exception ex) {
		out.println("error"+ex);
	}
	}
}
hr_db.commit();
hr1_db.commit();
hr_db.close();
hr1_db.close();

response.sendRedirect("hr/config/salary/itemName.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}

}