/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *这个文件是恩信科�?ERP软件的组成部分�??
 *版权�?有（C�?2006-2010 北京恩信创业科技有限公司/http://www.nseer.com
 *
 *这一程序是自由软件，你可以遵照自由软件基金会出版的GNU通用公共许可
 *证条款来修改和重新发布这�?程序。或者用许可证的第二版，或�?�（根据你的�?
 *择）用任何更新的版本�?
 *
 *发布这一程序的目的是希望它有用，但没有任何担保�?�甚至没有�?�合特定�?
 *的的隐含的担保�?�更详细的情况请参阅GNU通用公共许可证�??
 *你应该已经和程序�?起收到一份GNU通用公共许可证的副本。如果还没有�?
 *写信给：
 *The Free Software Foundation, Inc., 675 Mass Ave, Cambridge,
 *MA02139, USA
 */
package oa.config.press;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_db.*;

public class type_change_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);

if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){


String register_ID=(String)session.getAttribute("human_IDD");
String id=request.getParameter("id");
String describe1=request.getParameter("describe1");
	String responsible_person="";
int m=0;
	StringTokenizer tokenTO7 = new StringTokenizer(describe1,", ");        
	while(tokenTO7.hasMoreTokens()) {
		String sql1="insert into oa_config_human_ID_temp(human_ID,register_ID) values('"+tokenTO7.nextToken()+"','"+register_ID+"') ";

		oa_db.executeUpdate(sql1);
		
		m++;
		
	}
	String sql5="select distinct human_ID from oa_config_human_ID_temp where register_ID='"+register_ID+"'";

ResultSet rs5=oa_db.executeQuery(sql5);
rs5.last();

int n=0;
if(rs5.getRow()!=m){n++;}
String sql6="delete from oa_config_human_ID_temp where register_ID='"+register_ID+"'";
		oa_db.executeUpdate(sql6);

StringTokenizer tokenTO8 = new StringTokenizer(describe1,", ");        
	while(tokenTO8.hasMoreTokens()) {
		String sql2="select * from hr_file where human_ID='"+tokenTO8.nextToken()+"'";
		ResultSet rs2=hr_db.executeQuery(sql2);
		if(rs2.next()){
			responsible_person+=rs2.getString("human_name")+", ";
		}else{
		n++;
		}
	}
	StringTokenizer tokenTO9 = new StringTokenizer(describe1,", ");        
	while(tokenTO9.hasMoreTokens()) {
		String sql3="select * from hr_file where human_ID='"+tokenTO9.nextToken()+"'";
		ResultSet rs3=hr_db.executeQuery(sql3);
		if(!rs3.next()){
			
		n++;
		}
	}
if(n!=0){

	response.sendRedirect("oa/config/press/type_change_ok_a.jsp");


	}else{
      String sql = "update oa_config_public_char set describe1='"+describe1+"',describe2='"+responsible_person+"' where id='"+id+"'" ;
    	oa_db.executeUpdate(sql) ;
	response.sendRedirect("oa/config/press/type_change_ok_b.jsp");
	}
hr_db.commit();
oa_db.commit();
hr_db.close();
oa_db.close();


}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){}


}
}