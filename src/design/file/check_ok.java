/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.file;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.nseer_cookie.*;
import include.operateDB.CdefineUpdate;

public class check_ok extends HttpServlet{

public void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
try{

if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String id=request.getParameter("id");
String config_id=request.getParameter("config_id");
String product_ID=request.getParameter("product_ID");
String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);
String oldKind_chain=request.getParameter("oldKind_chain");
String oldChain_id=Divide1.getId(oldKind_chain);
String responsible_person_ID="";
String responsible_person_name="";
String  responsible_person=request.getParameter("select4") ;
	if(!responsible_person.equals("")&&!responsible_person.equals("/")){	
		 responsible_person_ID=responsible_person.split("/")[0];
		 responsible_person_name=responsible_person.split("/")[1];
	}
String sql6="select id from design_workflow where object_ID='"+product_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=design_db.executeQuery(sql6);
if(!rs6.next()){
String product_name=request.getParameter("product_name") ;
String factory_name=request.getParameter("factory_name") ;
String type=request.getParameter("type") ;
String product_class=request.getParameter("product_class") ;
String product_nick=request.getParameter("product_nick") ;
String twin_name=request.getParameter("twin_name") ;
String twin_ID=request.getParameter("twin_ID") ;
String personal_unit=request.getParameter("personal_unit") ;
String personal_value=request.getParameter("personal_value") ;
if(personal_value.equals("NaN")) personal_value ="0.00";
personal_value=personal_value.replaceAll(",", "");
String warranty=request.getParameter("warranty") ;
String lifecycle=request.getParameter("lifecycle") ;
String amount_unit=request.getParameter("amount_unit") ;
String register=request.getParameter("register") ;
String bodyc = new String(request.getParameter("provider_group").getBytes("UTF-8"),"UTF-8");
String provider_group=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("product_describe").getBytes("UTF-8"),"UTF-8");
String product_describe=exchange.toHtml(bodya);
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;

String list_price2=request.getParameter("list_price") ;
StringTokenizer tokenTO4 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO4.hasMoreTokens()) {
                String list_price1 = tokenTO4.nextToken();
		list_price +=list_price1;
		}
String cost_price2=request.getParameter("cost_price") ;
StringTokenizer tokenTO5 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO5.hasMoreTokens()) {
                String cost_price1 = tokenTO5.nextToken();
		cost_price +=cost_price1;
		}
int n=0;
		if(!validata.validata(list_price)||Double.parseDouble(list_price)<0){
			n++;
		}
		if(!validata.validata(cost_price)||Double.parseDouble(cost_price)<0){
			n++;
		}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"check_tag").equals("0")){

if(n==0){

String sql2="select * from design_config_file_kind where chain_id='"+chain_id+"'";
ResultSet rs2=design_db.executeQuery(sql2) ;
if(!chain_id.equals("")){

product_ID=request.getParameter("product_ID");

if(product_ID==null||product_ID.equals("")){
product_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));	
}
try{
	String sql = "update design_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',product_ID='"+product_ID+"',product_name='"+product_name+"',factory_name='"+factory_name+"',product_class='"+product_class+"',type='"+type+"',twin_name='"+twin_name+"',twin_ID='"+twin_ID+"',personal_unit='"+personal_unit+"',personal_value='"+personal_value+"',warranty='"+warranty+"',lifecycle='"+lifecycle+"',product_nick='"+product_nick+"',list_price='"+list_price+"',cost_price='"+cost_price+"',register='"+register+"',provider_group='"+provider_group+"',product_describe='"+product_describe+"',responsible_person_name='"+responsible_person_name+"',responsible_person_ID='"+responsible_person_ID+"',amount_unit='"+amount_unit+"',checker='"+checker+"',check_time='"+check_time+"' where product_ID='"+product_ID+"' and check_tag='0'" ;
	design_db.executeUpdate(sql) ;
	/*****************************************************/
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql=CdefineUpdate.update("design_file","product_ID",product_ID,request);
	design_db.executeUpdate(sql) ;
	/*****************************************************/
	if(!chain_id.equals("oldChain_id")){
		sql="update design_config_file_kind set delete_tag='0' where file_id='"+oldChain_id+"'";
			design_db.executeUpdate(sql);
		sql="update design_config_file_kind set delete_tag='1' where file_id='"+chain_id+"'";
			design_db.executeUpdate(sql);//delete_tag为1说明机构被使用	
	}
	sql = "update design_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+product_ID+"' and config_id='"+config_id+"'" ;
	design_db.executeUpdate(sql) ;
    sql="select id from design_workflow where object_ID='"+product_ID+"' and check_tag='0'";
	ResultSet rset=design_db.executeQuery(sql) ;
	if(!rset.next()){//最后一个审核通过

		sql="update design_file set check_tag='1' where product_ID='"+product_ID+"'";
		design_db.executeUpdate(sql) ;

		if(!type.equals("物料")){//电子商务的销售信息发布
			List rsList1 = GetWorkflow.getList(design_db, "ecommerce_config_workflow", "01");
			sql="delete from ecommerce_workflow where object_ID='"+product_ID+"' and type_id='01'";
			design_db.executeUpdate(sql);
			if(rsList1.size()==0){
				sql = "update design_file set excel_tag='3' where product_ID='"+product_ID+"'";
				design_db.executeUpdate(sql);
			}else{
				Iterator ite1=rsList1.iterator();
				while(ite1.hasNext()){
					String[] elem=(String[])ite1.next();
					sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+product_ID+"','"+elem[1]+"','"+elem[2]+"','01')" ;
					design_db.executeUpdate(sql);
				}
			}
		}
		if(type.equals("物料")||type.equals("外购商品")){//电子商务的采购信息发布
			List rsList1 = GetWorkflow.getList(design_db, "ecommerce_config_workflow", "03");
			sql="delete from ecommerce_workflow where object_ID='"+product_ID+"' and type_id='03'";
			design_db.executeUpdate(sql);
			if(rsList1.size()==0){
				sql = "update design_file set excel_tag2='3' where product_ID='"+product_ID+"'";
				design_db.executeUpdate(sql);
			}else{
				Iterator ite1=rsList1.iterator();
				while(ite1.hasNext()){
					String[] elem=(String[])ite1.next();
					sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+product_ID+"','"+elem[1]+"','"+elem[2]+"','03')" ;
					design_db.executeUpdate(sql);
				}
			}
		}
		if(type.equals("委外部件")){//电子商务的委外信息发布
			List rsList1 = GetWorkflow.getList(design_db, "ecommerce_config_workflow", "04");
			sql="delete from ecommerce_workflow where object_ID='"+product_ID+"' and type_id='04'";
			design_db.executeUpdate(sql);
			if(rsList1.size()==0){
				sql = "update design_file set excel_tag3='3' where product_ID='"+product_ID+"'" ;
				design_db.executeUpdate(sql) ;
		    }else{
				Iterator ite1=rsList1.iterator();
				while(ite1.hasNext()){
					String[] elem=(String[])ite1.next();
					sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+product_ID+"','"+elem[1]+"','"+elem[2]+"','04')" ;
					design_db.executeUpdate(sql);
				}
			}
		}
		if(!type.equals("物料")&&!type.equals("服务型产品")){//电子商务的配送信息发布
			List rsList1 = GetWorkflow.getList(design_db, "ecommerce_config_workflow", "05");
			sql="delete from ecommerce_workflow where object_ID='"+product_ID+"' and type_id='05'";
			design_db.executeUpdate(sql);
			if(rsList1.size()==0){
				sql = "update design_file set excel_tag4='3' where product_ID='"+product_ID+"'" ;
				design_db.executeUpdate(sql) ;
		    }else{
				Iterator ite1=rsList1.iterator();
				while(ite1.hasNext()){
					String[] elem=(String[])ite1.next();
					sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+product_ID+"','"+elem[1]+"','"+elem[2]+"','05')" ;
					design_db.executeUpdate(sql) ;
				}
			}
		}

}

}catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("design/file/check_choose_attachment.jsp?product_ID="+product_ID+"");
}else{
	response.sendRedirect("design/file/check_ok_a.jsp?finished_tag=1");
	}
}else{
response.sendRedirect("design/file/check_ok_b.jsp?finished_tag=4");
}
}else{
response.sendRedirect("design/file/check_ok_c.jsp?finished_tag=2");
}
}else{
	

response.sendRedirect("design/file/check_ok.jsp?finished_tag=0");

}
	  design_db.commit();
	  finance_db.commit();
	  design_db.close();
	  finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}