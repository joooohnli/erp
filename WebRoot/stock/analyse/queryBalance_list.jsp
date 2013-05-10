<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_balance.xml"/>
<% 
try{
	String tablename="stock_balance";
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String condition="";
String register_ID=(String)session.getAttribute("human_IDD");
String realname=(String)session.getAttribute("realeditorc");
String condition0="address_group!=''";
String queue="order by chain_id";
String validationXml="../../xml/stock/stock_balance.xml";
String nickName="动态库存";
String fileName="queryBalance_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的产品总数");
int k=1;
%>
<%@include file="../../include/search_a.jsp"%>
<%
condition=condition0;
%>
<%@include file="../../include/search_b.jsp"%>

<script type="text/javascript">
function load_ajax() {
	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp=new XMLHttpRequest();
	}
	else {
		xmlhttp=new ActiveObject("Microsotf.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function(){
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
			//alert(xmlhttp.responseText);
			var jsonString=xmlhttp.responseText;
			var data=eval("("+jsonString+")");
			//alert(data[1]);
			load_div_data(data);
			//document.getElementById("ajax_text_div").innerHTML=xmlhttp.responseText;
		}
	}
	var select_chain = document.getElementById("chain");
	var chain_name=select_chain.options[select_chain.selectedIndex].text;
	var select_stock = document.getElementById("stock");
	var stock_name=select_stock.options[select_stock.selectedIndex].text
	var select_stock_num = document.getElementById("stock_num");
	var stock_num = select_stock_num.options[select_stock_num.selectedIndex].text;
	var input_drug = document.getElementById("drug");
	var drug_name = input_drug.value;
	
	//alert(stock_num+"   "+drug_name);
	
	xmlhttp.open("GET", "queryBalance_list_ajax.jsp?chain_name="+chain_name
				+ "&&stock_name=" + stock_name
				+ "&&stock_num=" + stock_num
				+ "&&drug_name=" + drug_name, true);
	xmlhttp.send();
}

function load_div_data(parse_json_data) {
	var nseer_grid = new nseergrid();
	nseer_grid.callname = "nseer_grid";
	//clear the grid_div
	document.getElementById('nseer_grid_div').innerHTML="";
	nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
	nseer_grid.columns =[
					   {name: '<%=demo.getLang("erp","药品分类")%>'},
                       {name: '<%=demo.getLang("erp","药品编号/名称")%>'},
	                   {name: '<%=demo.getLang("erp","库存数量")%>'},
                       {name: '<%=demo.getLang("erp","安全库存上限")%>'},
	                   {name: '<%=demo.getLang("erp","安全库存下限")%>'},
	                   {name: '<%=demo.getLang("erp","质检不合格数")%>'}
	]
	nseer_grid.column_width=[300,200,100,100,100,100];
	nseer_grid.auto='<%=demo.getLang("erp","药品编号/名称")%>';
	
	for (var i=0;i<parse_json_data.length;i++){
		var color="#000000";
		if(Number(parse_json_data[i][2])>Number(parse_json_data[i][3])) {
			color="red";
		}
		if(Number(parse_json_data[i][2])<Number(parse_json_data[i][4])) {
			color="orange";
		}
		parse_json_data[i][2]="<div style=\"text-decoration : underline;color:#3366FF\" onclick=id_link(\"queryBalance.jsp?product_ID="+parse_json_data[i][1].split('/')[0]+"&&product_name="+parse_json_data[i][1].split('/')[1]+"\")><span style=\"color:'"+color+"'\">"+parse_json_data[i][2]+"</span></div>";
	}
	//nseer_grid.data need this!
	parse_json_data.push(['']);
	
	nseer_grid.data = parse_json_data;
	nseer_grid.init();
}
function id_link(link){
document.location.href=link;
}
function reset_search(){
	var select_chain = document.getElementById("chain");
	select_chain.options[0].selected=true;
	var select_stock = document.getElementById("stock");
	select_stock.options[0].selected=true;
	var select_stock_num = document.getElementById("stock_num");
	select_stock_num.options[0].selected=true;
	var input_drug = document.getElementById("drug");
	input_drug.value="";
	
	//全搜索
	search_button_click();
}
function search_button_click(){
	load_ajax();
}
</script>
<table>
	<tr>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="18%"><%=demo.getLang("erp","库房")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%">
			<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="stock" name="stock_name" onchange="search_button_click();">
				<option>--全部库房--</option>
			<%nseer_db stock_db_t = new nseer_db((String)session.getAttribute("unit_db_name"));
				String sql_t = "select * from stock_config_public_char where describe1='库房';";
				ResultSet rs_t = stock_db_t.executeQuery(sql_t);
				while (rs_t.next()) {
			%>
				<option><%=rs_t.getString("stock_name")%></option>
			<%
				}
				stock_db_t.close();
			%>
			</select>
		</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","药品种类")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%">
			<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="chain" name="chain_name" onchange="search_button_click();">
				<option>--全部种类--</option>
			<%nseer_db stock_db_s = new nseer_db((String)session.getAttribute("unit_db_name"));
				String sql_s = "select * from design_config_file_kind;";
				ResultSet rs_s = stock_db_s.executeQuery(sql_s);
				while (rs_s.next()) {
					if(!rs_s.getString("chain_name").equals("")) {
			%>
				<option><%=rs_s.getString("chain_name")%></option>
			<%
					}
				}
				stock_db_s.close();
			%>
			</select>
		</td>
	</tr>
	<tr>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","库存量")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%">
			<select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="stock_num" name="stock_num_num" onchange="search_button_click();">
				<option>--全部库存--</option>
				<option><50</option>
				<option>50-100</option>
				<option>100-500</option>
				<option>500-1000</option>
				<option>1000-2000</option>
				<option>2000-5000</option>
				<option>5000-10000</option>
				<option>10000-20000</option>
				<option>>20000</option>			
			</select>
		</td>
		<td <%=TD_STYLE1%> class="TD_STYLE8" width="16%"><%=demo.getLang("erp","药品编号/名称(关键字)")%>：</td>
		<td <%=TD_STYLE2%> class="TD_STYLE2" width="10%">
			<input <%=SELECT_STYLE1%> class="SELECT_STYLE1" type="text"  id="drug" name="drug_name" onpropertychange="search_button_click();">
		</td>
	</tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
  	<tr <%=TR_STYLE1%> class="TR_STYLE1">
    <td <%=TD_STYLE6%> class="TD_STYLE6">
    	<input type="button" class="BUTTON_STYLE1" value="重置搜索条件" onClick="reset_search();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	
		<input type="button"  class="BUTTON_STYLE1" value="<%=demo.getLang("erp","图表显示")%>" onClick="winopen('../monitor/query.jsp')"/>
		<input type="button"  class="BUTTON_STYLE1" id="select_all" value=打印  onclick="javascript:winopen('queryBalance_list_print.jsp')"/>
    </td>
  </tr>
</table>

<div id="nseer_grid_div"></div>

<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<script type="text/javascript">
search_button_click();
</script>
search_button_click();
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
stock_db.close();	
stock_db1.close();
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>