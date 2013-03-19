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

public class registerReduce_ok extends HttpServlet{

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
int err_count=0;
if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	String sql="";
	String fa_reduce=request.getParameter("fa_reduce");
	
	if(fa_reduce.indexOf("◎")!=-1){
	String[] temp=fa_reduce.split("◎");
	for(int i=0;i<temp.length;i++){
		sql="update finance_fa_file set reduce_time='"+temp[i].split("⊙")[1]+"',reduceway_id='"+temp[i].split("⊙")[2].split(" ")[0]+"',reduceway_name='"+temp[i].split("⊙")[2].split(" ")[1]+"',clear_income='"+temp[i].split("⊙")[3]+"',clear_expense='"+temp[i].split("⊙")[4]+"',clear_reason='"+temp[i].split("⊙")[5]+"',tag='2' where file_id='"+temp[i].split("⊙")[0]+"'";
		finance_db.executeUpdate(sql);
		err_count=0;
	}
	}else if(fa_reduce.indexOf("⊙")!=-1){	
		sql="update finance_fa_file set reduce_time='"+fa_reduce.split("⊙")[1]+"',reduceway_id='"+fa_reduce.split("⊙")[2].split(" ")[0]+"',reduceway_name='"+fa_reduce.split("⊙")[2].split(" ")[1]+"',clear_income='"+fa_reduce.split("⊙")[3]+"',clear_expense='"+fa_reduce.split("⊙")[4]+"',clear_reason='"+fa_reduce.split("⊙")[5]+"',tag='2' where file_id='"+fa_reduce.split("⊙")[0]+"'";
		finance_db.executeUpdate(sql);
		err_count=1;
			
	}else{
		err_count=2;
	}
	out.print(err_count);
		finance_db.commit();
		finance_db.close();
}
}catch (Exception ex){
		ex.printStackTrace();
	}
}
}