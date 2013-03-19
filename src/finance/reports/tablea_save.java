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

public class tablea_save extends HttpServlet{

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


		String item_year1=request.getParameter("item_year1");
		String item_month1=request.getParameter("item_month1");

		String item_year2=request.getParameter("item_year2");
		String item_month2=request.getParameter("item_month2");

		String item_year3=request.getParameter("item_year3");
		String item_month3=request.getParameter("item_month3");

		String item_year4=request.getParameter("item_year4");
		String item_month4=request.getParameter("item_month4");

		String item_year6=request.getParameter("item_year6");
		String item_month6=request.getParameter("item_month6");

		String item_year7=request.getParameter("item_year7");
		String item_month7=request.getParameter("item_month7");

		String item_year10=request.getParameter("item_year10");
		String item_month10=request.getParameter("item_month10");

		String item_year11=request.getParameter("item_year11");
		String item_month11=request.getParameter("item_month11");

		String item_year21=request.getParameter("item_year21");
		String item_month21=request.getParameter("item_month21");

		String item_year24=request.getParameter("item_year24");
		String item_month24=request.getParameter("item_month24");

		String item_year31=request.getParameter("item_year31");
		String item_month31=request.getParameter("item_month31");

        String item_year32=request.getParameter("item_year32");
		String item_month32=request.getParameter("item_month32");

		String item_year34=request.getParameter("item_year34");
		String item_month34=request.getParameter("item_month34");

		String item_year38=request.getParameter("item_year38");
		String item_month38=request.getParameter("item_month38");

		String item_year39=request.getParameter("item_year39");
		String item_month39=request.getParameter("item_month39");

		String item_year40=request.getParameter("item_year40");
		String item_month40=request.getParameter("item_month40");

		String item_year41=request.getParameter("item_year41");
		String item_month41=request.getParameter("item_month41");
		String item_year44=request.getParameter("item_year44");
		String item_month44=request.getParameter("item_month44");

		String item_year45=request.getParameter("item_year45");
		String item_month45=request.getParameter("item_month45");
		String item_year46=request.getParameter("item_year46");
		String item_month46=request.getParameter("item_month46");
		String item_year50=request.getParameter("item_year50");
		String item_month50=request.getParameter("item_month50");
		String item_year51=request.getParameter("item_year51");
		String item_month51=request.getParameter("item_month51");
		String item_year52=request.getParameter("item_year52");
		String item_month52=request.getParameter("item_month52");
		String item_year53=request.getParameter("item_year53");
		String item_month53=request.getParameter("item_month53");

		String item_year60=request.getParameter("item_year60");
		String item_month60=request.getParameter("item_month60");
		String item_year67=request.getParameter("item_year67");
		String item_month67=request.getParameter("item_month67");
		String item_year68=request.getParameter("item_year68");
		String item_month68=request.getParameter("item_month68");
		String item_year69=request.getParameter("item_year69");
		String item_month69=request.getParameter("item_month69");
		String item_year70=request.getParameter("item_year70");
		String item_month70=request.getParameter("item_month70");
		String item_year72=request.getParameter("item_year72");
		String item_month72=request.getParameter("item_month72");
		String item_year73=request.getParameter("item_year73");
		String item_month73=request.getParameter("item_month73");

		String item_year74=request.getParameter("item_year74");
		String item_month74=request.getParameter("item_month74");

		String item_year76=request.getParameter("item_year76");
		String item_month76=request.getParameter("item_month76");
		

		String item_year80=request.getParameter("item_year80");
		String item_month80=request.getParameter("item_month80");

		String item_year81=request.getParameter("item_year81");
		String item_month81=request.getParameter("item_month81");


		String item_year82=request.getParameter("item_year82");
		String item_month82=request.getParameter("item_month82");

		String item_year86=request.getParameter("item_year86");
		String item_month86=request.getParameter("item_month86");


		String item_year90=request.getParameter("item_year90");
		String item_month90=request.getParameter("item_month90");

		String item_year100=request.getParameter("item_year100");
		String item_month100=request.getParameter("item_month100");


		String item_year101=request.getParameter("item_year101");
		String item_month101=request.getParameter("item_month101");

		String item_year103=request.getParameter("item_year103");
		String item_month103=request.getParameter("item_month103");


		String item_year106=request.getParameter("item_year106");
		String item_month106=request.getParameter("item_month106");

		String item_year108=request.getParameter("item_year108");
		String item_month108=request.getParameter("item_month108");


		String item_year110=request.getParameter("item_year110");
		String item_month110=request.getParameter("item_month110");

		String item_year114=request.getParameter("item_year114");
		String item_month114=request.getParameter("item_month114");


		String item_year115=request.getParameter("item_year115");
		String item_month115=request.getParameter("item_month115");

		String item_year120=request.getParameter("item_year120");
		String item_month120=request.getParameter("item_month120");


		String item_year121=request.getParameter("item_year121");
		String item_month121=request.getParameter("item_month121");

		String item_year122=request.getParameter("item_year122");
		String item_month122=request.getParameter("item_month122");


		String item_year123=request.getParameter("item_year123");
		String item_month123=request.getParameter("item_month123");

		String item_year124=request.getParameter("item_year124");
		String item_month124=request.getParameter("item_month124");


		String item_year135=request.getParameter("item_year135");
		String item_month135=request.getParameter("item_month135");

		String sql1="delete from finance_report_01 where year='"+year+"' and month='"+month+"'";
		finance_db.executeUpdate(sql1);

		String sql="insert into finance_report_01(report_unit,year,month,item_year1,item_month1,item_year2,item_month2,item_year3,item_month3,item_year4,item_month4,item_year6,item_month6,item_year7,item_month7,item_year10,item_month10,item_year11,item_month11,item_year21,item_month21,item_year24,item_month24,item_year31,item_month31,item_year32,item_month32,item_year34,item_month34,item_year38,item_month38,item_year39,item_month39,item_year40,item_month40,item_year41,item_month41,item_year44,item_month44,item_year45,item_month45,item_year46,item_month46,item_year50,item_month50,item_year51,item_month51,item_year52,item_month52,item_year53,item_month53,item_year60,item_month60,item_year67,item_month67,item_year68,item_month68,item_year69,item_month69,item_year70,item_month70,item_year72,item_month72,item_year73,item_month73,item_year74,item_month74,item_year76,item_month76,item_year80,item_month80,item_year81,item_month81,item_year82,item_month82,item_year86,item_month86,item_year90,item_month90,item_year100,item_month100,item_year101,item_month101,item_year103,item_month103,item_year106,item_month106,item_year108,item_month108,item_year110,item_month110,item_year114,item_month114,item_year115,item_month115,item_year120,item_month120,item_year121,item_month121,item_year122,item_month122,item_year123,item_month123,item_year124,item_month124,item_year135,item_month135) values('"+report_unit+"','"+year+"','"+month+"','"+item_year1+"','"+item_month1+"','"+item_year2+"','"+item_month2+"','"+item_year3+"','"+item_month3+"','"+item_year4+"','"+item_month4+"','"+item_year6+"','"+item_month6+"','"+item_year7+"','"+item_month7+"','"+item_year10+"','"+item_month10+"','"+item_year11+"','"+item_month11+"','"+item_year21+"','"+item_month21+"','"+item_year24+"','"+item_month24+"','"+item_year31+"','"+item_month31+"','"+item_year32+"','"+item_month32+"','"+item_year34+"','"+item_month34+"','"+item_year38+"','"+item_month38+"','"+item_year39+"','"+item_month39+"','"+item_year40+"','"+item_month40+"','"+item_year41+"','"+item_month41+"','"+item_year44+"','"+item_month44+"','"+item_year45+"','"+item_month45+"','"+item_year46+"','"+item_month46+"','"+item_year50+"','"+item_month50+"','"+item_year51+"','"+item_month51+"','"+item_year52+"','"+item_month52+"','"+item_year53+"','"+item_month53+"','"+item_year60+"','"+item_month60+"','"+item_year67+"','"+item_month67+"','"+item_year68+"','"+item_month68+"','"+item_year69+"','"+item_month69+"','"+item_year70+"','"+item_month70+"','"+item_year72+"','"+item_month72+"','"+item_year73+"','"+item_month73+"','"+item_year74+"','"+item_month74+"','"+item_year76+"','"+item_month76+"','"+item_year80+"','"+item_month80+"','"+item_year81+"','"+item_month81+"','"+item_year82+"','"+item_month82+"','"+item_year86+"','"+item_month86+"','"+item_year90+"','"+item_month90+"','"+item_year100+"','"+item_month100+"','"+item_year101+"','"+item_month101+"','"+item_year103+"','"+item_month103+"','"+item_year106+"','"+item_month106+"','"+item_year108+"','"+item_month108+"','"+item_year110+"','"+item_month110+"','"+item_year114+"','"+item_month114+"','"+item_year115+"','"+item_month115+"','"+item_year120+"','"+item_month120+"','"+item_year121+"','"+item_month121+"','"+item_year122+"','"+item_month122+"','"+item_year123+"','"+item_month123+"','"+item_year124+"','"+item_month124+"','"+item_year135+"','"+item_month135+"')";


		finance_db.executeUpdate(sql);
		finance_db.commit();
		finance_db.close();
response.sendRedirect("finance/reports/tablea_save_a.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}