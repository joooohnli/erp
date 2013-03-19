<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.*,java.text.*"%>
<jsp:useBean id="available" class="stock.getRetailBalanceAmount" scope="request"/>
<jsp:useBean id="available1" class="stock.getListPrice" scope="request"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="getRateFromID" class="include.get_rate_from_ID.getRateFromID" scope="page"/>
<%nseer_db stock_db= new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db1= new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js">
</script>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>
<script language="javascript">
//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var edit=window.opener.tableOnlineEdit;
var names=['product_ID','product_name','product_describe','amount','amount_unit','list_price','cost_price','real_cost_price'];
function addGoodsItem(product_IDa, product_namea, product_describea, amounta, amount_unita, list_pricea, cost_pricea, real_cost_pricea,off_discounta) {
var values=[product_IDa, product_namea, product_describea, amounta, amount_unita, list_pricea, cost_pricea, real_cost_pricea,off_discounta];
 if(checkRow(edit,values[0])) {
 addInstanceRow(edit,names,values);
 }
}
</script>
<%
String product_ID=request.getParameter("product_ID");
String product_name=exchange.unURL(request.getParameter("product_name"));
String register_ID=(String)session.getAttribute("human_IDD");
String stock_ID="";
String tablename="stock_config_public_char";String realname=(String)session.getAttribute("realeditorc");
String condition="responsible_person_ID like '%"+register_ID+"%'";
String queue="";
String validationXml="../../xml/stock/stock_config_public_char.xml";
String nickName="库房";
String fileName="register_product_list_query.jsp";
String rowSummary=demo.getLang("erp",product_name+"在不同责任库房的明细如下");
%>
<%@include file="../../include/search.jsp"%>

<%			ResultSet rs1=stock_db.executeQuery(sql_search);

		if(strhead.indexOf(browercheck.IE)==-1){
%>
<script type="text/javascript">

var xmlHttp;

var product_ID;

var product_name;

var product_describe;

var amount;

var amount_unit;

var list_price;

var cost_price;

var real_cost_price;

var off_discount;

var department;

var EMP_PREFIX = "emp-";

//*********************************************
function createXMLHttpRequest() {

if (window.ActiveXObject) {

xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

} 

else if (window.XMLHttpRequest) {

xmlHttp = new XMLHttpRequest();

}

}
//*********************************************
function addGoodsItem(product_IDa, product_namea, product_describea, amounta, amount_unita, list_pricea, cost_pricea, real_cost_pricea,off_discounta) {

var checkrow=window.opener.document.getElementById("mutiValidation");
var valuew = checkrow.product_ID;
for (var i=0; i<valuew.length; i++) {
 if(valuew[i].value==product_IDa){
return;
 }

}
product_ID =product_IDa;
product_name =product_namea;
product_describe =product_describea;
amount = amounta;
amount_unit = amount_unita;
list_price=list_pricea;
cost_price=cost_pricea;
real_cost_price=real_cost_pricea;
off_discount = off_discounta;
	
action = "add";

var url = "../../include_ajax_GetXml?" 

+ createAddQueryString(product_ID, product_name, product_describe, amount, amount_unit, list_price, cost_price, real_cost_price,off_discount, "add") 

+ "&ts=" + new Date().getTime();

createXMLHttpRequest();

xmlHttp.onreadystatechange = handleAddStateChange;

xmlHttp.open("GET", url, true);

xmlHttp.send(null);

}

//*********************************************
function createAddQueryString(product_ID, product_name, product_describe, amount, amount_unit, list_price, cost_price, real_cost_price,off_discount, action) {

var queryString = "product_ID=" + product_ID 

+ "product_name=" + product_name

+ "product_describe=" + product_describe

+ "amount=" + amount

+ "amount_unit=" + amount_unit

+ "list_price=" + list_price

+ "cost_price=" + cost_price

+ "real_cost_price=" + real_cost_price

+ "off_discount=" + off_discount

+ "&action=" + action;

return queryString;

}
//*********************************************
//回调方法 
function handleAddStateChange() {

if(xmlHttp.readyState == 4) {

if(xmlHttp.status == 200) {

updateChoiceList();

clearInputBoxes();

}

else {

alert("Error while adding .");

}

}

}

function updateChoiceList() {

var responseXML = xmlHttp.responseXML;

var status = responseXML.getElementsByTagName("status").item(0).firstChild.nodeValue;

status = parseInt(status);

if(status != 1) {

return;

}
var row = document.createElement("tr");

responseXML.getElementsByTagName("uniqueID")[0].firstChild.nodeValue;
//*********************************************
var deleteButto = document.createElement("input");

deleteButto.setAttribute("type", "checkbox");

deleteButto.setAttribute("name", "checkbox");

cell = document.createElement("td");

cell.appendChild(deleteButto);

row.appendChild(cell);
//*********************************************
row.appendChild(createCellWithText(product_ID));

row.appendChild(createCellWithText(product_name));

row.appendChild(createCellWithText(product_describe));

//*********************************************
var deleteButton4 = document.createElement("input");

deleteButton4.setAttribute("type", "text");

deleteButton4.setAttribute("name", "amount");

deleteButton4.setAttribute("value", amount);

deleteButton4.setAttribute("class","INPUT_STYLE5");

cell = document.createElement("td");

cell.appendChild(deleteButton4);

row.appendChild(cell);

row.appendChild(createCellWithText(amount_unit));

row.appendChild(createCellWithText(list_price));

row.appendChild(createCellWithText(""));

//*********************************************
var deleteButton9 = document.createElement("input");

deleteButton9.setAttribute("type", "text");

deleteButton9.setAttribute("name", "off_discount");

deleteButton9.setAttribute("value", off_discount);

deleteButton9.setAttribute("class","INPUT_STYLE5");

cell = document.createElement("td");

cell.appendChild(deleteButton9);

row.appendChild(cell);


//*********************************************
var deleteButton1 = document.createElement("input");

deleteButton1.setAttribute("type", "hidden");

deleteButton1.setAttribute("name", "product_ID");

deleteButton1.setAttribute("value", product_ID);


cell.appendChild(deleteButton1);

row.appendChild(cell);

//*********************************************
var deleteButton2 = document.createElement("input");

deleteButton2.setAttribute("type", "hidden");

deleteButton2.setAttribute("name", "product_name");

deleteButton2.setAttribute("value", product_name);


cell.appendChild(deleteButton2);

row.appendChild(cell);

//*********************************************
var deleteButton3 = document.createElement("input");

deleteButton3.setAttribute("type", "hidden");

deleteButton3.setAttribute("name", "product_describe");

deleteButton3.setAttribute("value", product_describe);


cell.appendChild(deleteButton3);

row.appendChild(cell);

//*********************************************
var deleteButton5 = document.createElement("input");

deleteButton5.setAttribute("type", "hidden");

deleteButton5.setAttribute("name", "amount_unit");

deleteButton5.setAttribute("value", amount_unit);


cell.appendChild(deleteButton5);

row.appendChild(cell);

//*********************************************
var deleteButton6 = document.createElement("input");

deleteButton6.setAttribute("type", "hidden");

deleteButton6.setAttribute("name", "list_price");

deleteButton6.setAttribute("value", list_price);


cell.appendChild(deleteButton6);

row.appendChild(cell);

//*********************************************
var deleteButton7 = document.createElement("input");

deleteButton7.setAttribute("type", "hidden");

deleteButton7.setAttribute("name", "cost_price");

deleteButton7.setAttribute("value", cost_price);


cell.appendChild(deleteButton7);

row.appendChild(cell);


//*********************************************
var deleteButton8 = document.createElement("input");

deleteButton8.setAttribute("type", "hidden");

deleteButton8.setAttribute("name", "real_cost_price");

deleteButton8.setAttribute("value", real_cost_price);

cell.appendChild(deleteButton8);

row.appendChild(cell);




var edit=window.opener.document.getElementById("tableOnlineEdit");

edit.appendChild(row);



updateChoiceListVisibility();
}

//*********************************************
function createCellWithText(text) {

var cell = document.createElement("td");

cell.appendChild(document.createTextNode(text));

return cell;

}
//*********************************************
function updateChoiceListVisibility() {
var editt=window.opener.document.getElementById("tableOnlineEdit");
var choiceList = editt.getElementById("choiceList");
if(choiceList.childNodes.length> 0) {
editt.getElementById("choiceListSpan").style.display = "";
}else{
editt.getElementById("choiceListSpan").style.display = "none";
}
}
</script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","产品")%>：<%=product_name%>&nbsp;<%=demo.getLang("erp","在不同责任库房的明细如下")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="history.back()" value="<%=demo.getLang("erp","返回")%>"></div></td>
 </tr>
 </table>  
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(customer_ID,customer_name,sales_name,sales_ID){
var link1='register.jsp?customer_ID='+customer_ID+'&&customer_name='+customer_name+'&&sales_name='+sales_name+'&&sales_ID='+sales_ID;
document.location.href=link1;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","责任库房")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","用途类型")%>'},
                       {name: '<%=demo.getLang("erp","单位")%>'},
					   {name: '<%=demo.getLang("erp","市场单价")%>'},
					   {name: '<%=demo.getLang("erp","责任库存")%>'},
                       {name: '<%=demo.getLang("erp","定购")%>'}
]
nseer_grid.column_width=[200,100,100,100,100,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<%
		while(rs1.next()){
		stock_ID=rs1.getString("stock_ID");
						String sql2="select * from stock_balance_details where product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"'";
						ResultSet rs2=stock_db1.executeQuery(sql2);
			if(rs2.next()){%>
['<%=rs2.getString("stock_name")%>','<%=rs2.getString("product_ID")%>','<%=rs2.getString("product_name")%>','<%=rs2.getString("type")%>','<%=rs2.getString("amount_unit")%>','<%=available1.getListPrice((String)session.getAttribute("unit_db_name"),rs2.getString("product_ID"))%>','<%=rs2.getDouble("amount")%>','<div style="text-decoration : underline;color:#3366FF" onclick=addGoodsItem("<%=rs2.getString("product_ID")%>","<%=rs2.getString("product_name")%>","<%=exchange.unHtml(rs2.getString("product_describe"))%>","1","<%=rs2.getString("amount_unit")%>","<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(available1.getListPrice((String)session.getAttribute("unit_db_name"),rs2.getString("product_ID")))%>","<%=getRateFromID.getRateFromID((String)session.getAttribute("unit_db_name"),"design_file","product_ID",rs2.getString("product_ID"),"cost_price")%>","<%=rs2.getString("cost_price")%>","0")><%=demo.getLang("erp","定购")%></div>'],
<%}}%>	
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>

<%
	}else{
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","产品")%>：<%=product_name%>&nbsp;<%=demo.getLang("erp","在不同责任库房的明细如下")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="history.back()" value="<%=demo.getLang("erp","返回")%>"></div></td>
 </tr>
 </table>  
 <div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(customer_ID,customer_name,sales_name,sales_ID){
var link1='register.jsp?customer_ID='+customer_ID+'&&customer_name='+customer_name+'&&sales_name='+sales_name+'&&sales_ID='+sales_ID;
document.location.href=link1;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","责任库房")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","用途类型")%>'},
                       {name: '<%=demo.getLang("erp","单位")%>'},
					   {name: '<%=demo.getLang("erp","市场单价")%>'},
					   {name: '<%=demo.getLang("erp","责任库存")%>'},
                       {name: '<%=demo.getLang("erp","定购")%>'}
]
nseer_grid.column_width=[200,100,100,100,100,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<%
		while(rs1.next()){
		stock_ID=rs1.getString("stock_ID");
						String sql2="select * from stock_balance_details where product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"'";
						ResultSet rs2=stock_db1.executeQuery(sql2);
			if(rs2.next()){%>
['<%=rs2.getString("stock_name")%>','<%=rs2.getString("product_ID")%>','<%=rs2.getString("product_name")%>','<%=rs2.getString("type")%>','<%=rs2.getString("amount_unit")%>','<%=available1.getListPrice((String)session.getAttribute("unit_db_name"),rs2.getString("product_ID"))%>','<%=rs2.getDouble("amount")%>','<div style="text-decoration : underline;color:#3366FF" onclick=addGoodsItem("<%=rs2.getString("product_ID")%>","<%=rs2.getString("product_name")%>","<%=exchange.unHtml(rs2.getString("product_describe"))%>","1","<%=rs2.getString("amount_unit")%>","<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(available1.getListPrice((String)session.getAttribute("unit_db_name"),rs2.getString("product_ID")))%>","<%=getRateFromID.getRateFromID((String)session.getAttribute("unit_db_name"),"design_file","product_ID",rs2.getString("product_ID"),"cost_price")%>","<%=rs2.getString("cost_price")%>","0")><%=demo.getLang("erp","定购")%></div>'],
<%}}%>	
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<%}
stock_db.close();
	 stock_db1.close();
	 %>