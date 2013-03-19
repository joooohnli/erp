/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.ajax;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.*;
import include.tree_index.businessComment;
import include.nseer_db.*;

public class ajax_workSpace extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup erp_db = null;

public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{
PrintWriter out=response.getWriter();
nseer_db_backup db = new nseer_db_backup(dbApplication);
businessComment demo=new businessComment();
demo.setPath(request);
if(db.conn((String)dbSession.getAttribute("unit_db_name"))){
String CATEGORY=request.getParameter("CATEGORY") ;
String module_name=request.getParameter("module_name") ;
String link=request.getParameter("link") ;
String view_tree_name=request.getParameter("view") ;
String sql="insert into security_workspace(module_name,link,view_tree_name,CATEGORY)values('"+module_name+"','"+link+"','"+view_tree_name+"','"+CATEGORY+"')";
db.executeUpdate(sql) ;

out.println(demo.getLang("erp","已成功将 ")+module_name+demo.getLang("erp"," 加入您的个人工作台"));

db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
ex.printStackTrace();
}
}
}





