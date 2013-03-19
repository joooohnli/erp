/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.reports;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class tablec_save extends HttpServlet{

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

		String finance_time=request.getParameter("finance_time");
		String report_unit=request.getParameter("report_unit");
		String year=finance_time.substring(0,4);
		String month=finance_time.substring(5,7);
		String day=finance_time.substring(8,10);


String item_year1=request.getParameter("item_year1");
String item_year8=request.getParameter("item_year8");
String item_year9=request.getParameter("item_year9");
String item_year10=request.getParameter("item_year10");
String item_year12=request.getParameter("item_year12");
String item_year13=request.getParameter("item_year13");
String item_year18=request.getParameter("item_year18");
String item_year20=request.getParameter("item_year20");
String item_year21=request.getParameter("item_year21");
String item_year22=request.getParameter("item_year22");
String item_year23=request.getParameter("item_year23");
String item_year25=request.getParameter("item_year25");
String item_year28=request.getParameter("item_year28");
String item_year29=request.getParameter("item_year29");
String item_year30=request.getParameter("item_year30");
String item_year31=request.getParameter("item_year31");
String item_year35=request.getParameter("item_year35");
String item_year36=request.getParameter("item_year36");
String item_year37=request.getParameter("item_year37");
String item_year38=request.getParameter("item_year38");
String item_year40=request.getParameter("item_year40");
String item_year43=request.getParameter("item_year43");
String item_year44=request.getParameter("item_year44");
String item_year45=request.getParameter("item_year45");
String item_year46=request.getParameter("item_year46");
String item_year52=request.getParameter("item_year52");
String item_year53=request.getParameter("item_year53");
String item_year54=request.getParameter("item_year54");
String item_year55=request.getParameter("item_year55");
String item_year56=request.getParameter("item_year56");
String item_year57=request.getParameter("item_year57");
String item_year58=request.getParameter("item_year58");
String item_year59=request.getParameter("item_year59");
String item_year60=request.getParameter("item_year60");
String item_year61=request.getParameter("item_year61");
String item_year64=request.getParameter("item_year64");
String item_year65=request.getParameter("item_year65");
String item_year66=request.getParameter("item_year66");
String item_year67=request.getParameter("item_year67");
String item_year68=request.getParameter("item_year68");
String item_year69=request.getParameter("item_year69");
String item_year70=request.getParameter("item_year70");
String item_year71=request.getParameter("item_year71");
String item_year72=request.getParameter("item_year72");
String item_year73=request.getParameter("item_year73");
String item_year74=request.getParameter("item_year74");
String item_year75=request.getParameter("item_year75");
String item_year76=request.getParameter("item_year76");
String item_year77=request.getParameter("item_year77");
String item_year78=request.getParameter("item_year78");
String item_year79=request.getParameter("item_year79");
String item_year80=request.getParameter("item_year80");
String item_year81=request.getParameter("item_year81");
String item_year82=request.getParameter("item_year82");
String item_year83=request.getParameter("item_year83");




		
		String sql1="delete from finance_report_03 where year='"+year+"' and month='"+month+"'";
		finance_db.executeUpdate(sql1);

		String sql="insert into finance_report_03(report_unit,year,month,day,item_year1,item_year8,item_year9,item_year10,item_year12,item_year13,item_year18,item_year20,item_year21,item_year22,item_year23,item_year25,item_year28,item_year29,item_year30,item_year31,item_year35,item_year36,item_year37,item_year38,item_year40,item_year43,item_year44,item_year45,item_year46,item_year52,item_year53,item_year54,item_year55,item_year56,item_year57,item_year58,item_year59,item_year60,item_year61,item_year64,item_year65,item_year66,item_year67,item_year68,item_year69,item_year70,item_year71,item_year72,item_year73,item_year74,item_year75,item_year76,item_year77,item_year78,item_year79,item_year80,item_year81,item_year82,item_year83) values('"+report_unit+"','"+year+"','"+month+"','"+day+"','"+item_year1+"','"+item_year8+"','"+item_year9+"','"+item_year10+"','"+item_year12+"','"+item_year13+"','"+item_year18+"','"+item_year20+"','"+item_year21+"','"+item_year22+"','"+item_year23+"','"+item_year25+"','"+item_year28+"','"+item_year29+"','"+item_year30+"','"+item_year31+"','"+item_year35+"','"+item_year36+"','"+item_year37+"','"+item_year38+"','"+item_year40+"','"+item_year43+"','"+item_year44+"','"+item_year45+"','"+item_year46+"','"+item_year52+"','"+item_year53+"','"+item_year54+"','"+item_year55+"','"+item_year56+"','"+item_year57+"','"+item_year58+"','"+item_year59+"','"+item_year60+"','"+item_year61+"','"+item_year64+"','"+item_year65+"','"+item_year66+"','"+item_year67+"','"+item_year68+"','"+item_year69+"','"+item_year70+"','"+item_year71+"','"+item_year72+"','"+item_year73+"','"+item_year74+"','"+item_year75+"','"+item_year76+"','"+item_year77+"','"+item_year78+"','"+item_year79+"','"+item_year80+"','"+item_year81+"','"+item_year82+"','"+item_year83+"')";

		finance_db.executeUpdate(sql);
		finance_db.commit();
		finance_db.close();
response.sendRedirect("finance/reports/tablec_save_a.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}