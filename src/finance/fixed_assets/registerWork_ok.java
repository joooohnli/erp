/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.fixed_assets;
 
import include.get_name_from_ID.getNameFromID;
import include.nseer_db.nseer_db_backup1;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class registerWork_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
getNameFromID getNameFromID=new getNameFromID();
PrintWriter out=response.getWriter();
try{
if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	String sql="";
	String work_month=request.getParameter("work_month");
	String[] temp=work_month.split("◎");
	for(int i=0;i<temp.length;i++){
		sql="update finance_fa_file set work_month='"+temp[i].split("⊙")[1]+"' where file_id='"+temp[i].split("⊙")[0]+"'";
		finance_db.executeUpdate(sql);
	}
	out.print("提交成功");
		finance_db.commit();
		finance_db.close();
}
}catch (Exception ex){
		ex.printStackTrace();
	}
}
}