/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package document.module.main;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.* ;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;

public class delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


HttpSession session=request.getSession();

try{
	nseer_db_backup1 document_db = new nseer_db_backup1(dbApplication);
	if(document_db.conn((String)dbSession.getAttribute("unit_db_name"))){
    String reason=exchange.unURL(request.getParameter("reason"));
String sql6="select * from "+reason+"_tree where main!='帮助'";
ResultSet rs6=document_db.executeQuery(sql6);
if(rs6.next()){
	response.sendRedirect("document/module/main/delete_ok_b.jsp");
}else{
	ServletContext context=session.getServletContext();
	String path=context.getRealPath("/");	
	delFile del=new delFile();
	String sql3="select * from document_main where reason='"+reason+"'";
	ResultSet rs=document_db.executeQuery(sql3) ;
	if(rs.next()){
		String picture_name="";
String picture_ext="";
StringTokenizer tokenTO = new StringTokenizer(rs.getString("picture"),".");
			while (tokenTO.hasMoreTokens()) {
				picture_name = tokenTO.nextToken();
				picture_ext = tokenTO.nextToken();
			}
		File file2=new File(path+"images\\"+picture_name+"1."+picture_ext);
		file2.delete();
		File file1=new File(path+"images\\"+rs.getString("picture"));
		file1.delete();
		for(int i=1;i<=6;i++){
			String field_name="attachment"+i;
			if(rs.getString(field_name).equals("")) continue;
			File file=new File(path+"document\\file_attachments\\"+rs.getString(field_name));
			file.delete();
		}
	}
    String sql = "delete from document_main where reason='"+reason+"'";
	document_db.executeUpdate(sql) ;
	String sql1 = "delete from document_main_temp where reason='"+reason+"'";
	document_db.executeUpdate(sql1) ;
	String sql2 = "delete from document_main_dig where reason='"+reason+"'";
	document_db.executeUpdate(sql2) ;
	
	String sql7 = "delete from document_first where main_kind_name='"+reason+"' and first_kind_name='help'";
	document_db.executeUpdate(sql7) ;
	String sql8 = "delete from document_first_temp where main_kind_name='"+reason+"' and first_kind_name='help'";
	document_db.executeUpdate(sql8) ;
	String sql15 = "delete from document_first_dig where main_kind_name='"+reason+"' and first_kind_name='help'";
	document_db.executeUpdate(sql15) ;
	String sql9 = "delete from document_help where main_kind_name='"+reason+"' and first_kind_name='help'";
	document_db.executeUpdate(sql9) ;
	String sql10 = "delete from document_help_temp where main_kind_name='"+reason+"' and first_kind_name='help'";
	document_db.executeUpdate(sql10) ;
	String sql16 = "delete from document_help_dig where main_kind_name='"+reason+"' and first_kind_name='help'";
	document_db.executeUpdate(sql16) ;
	String sql11 = "delete from document_businessprogram where main_kind_name='"+reason+"'";
	document_db.executeUpdate(sql11) ;
	String sql12 = "delete from document_businessprogram_temp where main_kind_name='"+reason+"'";
	document_db.executeUpdate(sql12) ;
	String sql17 = "delete from document_businessprogram_dig where main_kind_name='"+reason+"'";
	document_db.executeUpdate(sql17) ;
	String sql13 = "delete from document_maintest where reason='"+reason+"'";
	document_db.executeUpdate(sql13) ;
	String sql14 = "delete from document_maintest_temp where reason='"+reason+"'";
	document_db.executeUpdate(sql14) ;
	String sql18 = "delete from document_maintest_dig where reason='"+reason+"'";
	document_db.executeUpdate(sql18) ;
	String sql4="drop table "+reason+"_tree";
	document_db.executeUpdate(sql4);
	String sql5="drop table "+reason+"_allright";
	document_db.executeUpdate(sql5);
	sql5="drop table "+reason+"_view";
	document_db.executeUpdate(sql5);
	del.delete(path+reason);
	del.delete(path+"WEB-INF/src/"+reason);
	response.sendRedirect("document/module/main/delete_ok_a.jsp");//文件跳转
}
document_db.commit();
document_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
	}	
}
}