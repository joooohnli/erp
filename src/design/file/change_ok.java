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
 
 
import include.get_sql.getInsertSql;
import include.nseer_cookie.Divide1;
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;
import include.operateDB.CdefineUpdate;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;
import validata.ValidataTag;

public class change_ok extends HttpServlet{

public void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
getInsertSql getInsertSql=new getInsertSql();
try{

	if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ResultSet rset=null;
String id=request.getParameter("id");
String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);
String type=request.getParameter("type") ;
String product_ID=request.getParameter("product_ID") ;
String product_name=request.getParameter("product_name") ;
String factory_name=request.getParameter("factory_name") ;
String product_class=request.getParameter("product_class") ;
String product_nick=request.getParameter("product_nick") ;
String twin_name=request.getParameter("twin_name") ;
String twin_ID=request.getParameter("twin_ID") ;
String personal_unit=request.getParameter("personal_unit") ;
String personal_value=request.getParameter("personal_value") ;
personal_value=personal_value.replaceAll(",", "");
String warranty=request.getParameter("warranty") ;
String lifecycle=request.getParameter("lifecycle") ;
String amount_unit=request.getParameter("amount_unit") ;
String register=request.getParameter("register") ;
String bodyc = new String(request.getParameter("provider_group").getBytes("UTF-8"),"UTF-8");
String provider_group=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("product_describe").getBytes("UTF-8"),"UTF-8");
String product_describe=exchange.toHtml(bodya);
String changer_ID=request.getParameter("changer_ID") ;
String changer=request.getParameter("changer") ;
String change_time=request.getParameter("change_time") ;
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
int change_amount=Integer.parseInt(file_change_amount)+1;
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"design_file");
String list_price2=request.getParameter("list_price") ;    
String list_price=list_price2.replaceAll(",", "");
String cost_price2=request.getParameter("cost_price") ;       
String cost_price=cost_price2.replaceAll(",", "");
String responsible_person_ID="";
String responsible_person_name="";
String  responsible_person=request.getParameter("select4") ;
	if(!responsible_person.equals("")&&!responsible_person.equals("/")){	
		 responsible_person_ID=responsible_person.split("/")[0];
		 responsible_person_name=responsible_person.split("/")[1];
	}
int n=0;
		if(!validata.validata(list_price)){
			n++;
		}
		if(!validata.validata(cost_price)){
			n++;
		}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","id",id,"check_tag").equals("1")){
if(n==0){
if(true){
try{
	String sqla="insert into design_file_dig("+column_group+") select "+column_group+" from design_file where id='"+id+"'";
	design_db.executeUpdate(sqla) ;
	String sql = "update design_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',product_name='"+product_name+"',factory_name='"+factory_name+"',product_class='"+product_class+"',twin_name='"+twin_name+"',twin_ID='"+twin_ID+"',personal_unit='"+personal_unit+"',personal_value='"+personal_value+"',warranty='"+warranty+"',lifecycle='"+lifecycle+"',product_nick='"+product_nick+"',list_price='"+list_price+"',cost_price='"+cost_price+"',provider_group='"+provider_group+"',product_describe='"+product_describe+"',responsible_person_name='"+responsible_person_name+"',responsible_person_ID='"+responsible_person_ID+"',amount_unit='"+amount_unit+"',changer_ID='"+changer_ID+"',changer='"+changer+"',change_time='"+change_time+"',lately_change_time='"+lately_change_time+"',file_change_amount='"+change_amount+"',check_tag='0',excel_tag='1' where id="+id+"";
	design_db.executeUpdate(sql) ;
	/*****************************************************/
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql=CdefineUpdate.update("design_file","product_ID",product_ID,request);
	design_db.executeUpdate(sql) ;
	/*****************************************************/
	if(!chain_id.equals("")){
		sql="update design_config_file_kind set delete_tag='1' where file_id='"+chain_id+"'";
			design_db.executeUpdate(sql);//delete_tag为1说明机构被使用	
	}

	sql="delete from design_workflow where object_ID='"+product_ID+"'";
		design_db.executeUpdate(sql) ;

	List rsList = GetWorkflow.getList(design_db, "design_config_workflow", "01");
	if(rsList.size()==0){
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

	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into design_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+product_ID+"','"+elem[1]+"','"+elem[2]+"','01')" ;
		design_db.executeUpdate(sql) ;
		}
	}	


}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("design/file/change_choose_attachment.jsp?product_ID="+product_ID+"");
}else{
	response.sendRedirect("design/file/change_ok_a.jsp?id="+id+"");
	}
}else{
response.sendRedirect("design/file/change_ok_b.jsp?id="+id+"");
}}else{
response.sendRedirect("design/file/change_ok_c.jsp");
}
design_db.commit();
design_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}