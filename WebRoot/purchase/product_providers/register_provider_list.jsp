<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/purchase/purchase_file.xml"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>

<%
		if(strhead.indexOf(browercheck.IE)==-1){
%>
<script src="../../javascript/table/movetable.js">
</script>

<script type="text/javascript">

var xmlHttp;

var provider_ID;

var provider_name;

var type;

var provider_class;

var provider_tel1;

var contact_person1;

var provider_web;

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
function addGoodsItem(provider_IDa, provider_namea, typea, provider_classa, provider_tel1a, contact_person1a, provider_weba) {

 provider_name=provider_namea.replace(/★/g,"<br>").replace(/☆/g," ");
 type=typea.replace(/★/g,"<br>").replace(/☆/g," ");
 provider_class=provider_classa.replace(/★/g,"<br>").replace(/☆/g," ");
 provider_tel1=provider_tel1a.replace(/★/g,"<br>").replace(/☆/g," ");
 contact_person1=contact_person1a.replace(/★/g,"<br>").replace(/☆/g," ");
 provider_web=provider_weba.replace(/★/g,"<br>").replace(/☆/g," ");

var checkrow=window.opener.document.getElementById("mutiValidation");
var valuew = checkrow.provider_ID;
for (var i=0; i<valuew.length; i++) {
 if(valuew[i].value==provider_IDa){
return;
 }

}
provider_ID =provider_IDa;
	
action = "add";

var url = "../../include_ajax_GetXml?" 

+ createAddQueryString(provider_ID, provider_name, type, provider_class, provider_tel1, contact_person1, provider_web, "add") 

+ "&ts=" + new Date().getTime();

createXMLHttpRequest();

xmlHttp.onreadystatechange = handleAddStateChange;

xmlHttp.open("GET", url, true);

xmlHttp.send(null);

}

//*********************************************
function createAddQueryString(provider_ID, provider_name, type, provider_class, provider_tel1, contact_person1, provider_web, action) {

var queryString = "provider_ID=" + provider_ID 

+ "provider_name=" + provider_name

+ "type=" + type

+ "provider_class=" + provider_class

+ "provider_tel1=" + provider_tel1

+ "contact_person1=" + contact_person1

+ "provider_web=" + provider_web

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
var deleteButton41 = document.createElement("input");

deleteButton41.setAttribute("type", "text");

deleteButton41.setAttribute("name", "provider_ID");

deleteButton41.setAttribute("value", provider_ID);

deleteButton41.setAttribute("onFocus","this.blur()");

deleteButton41.setAttribute("class","INPUT_STYLE4");



var cell = document.createElement("td");

cell.appendChild(deleteButton41);

row.appendChild(cell);


//row.appendChild(createCellWithText(product_name));

var deleteButton51 = document.createElement("input");

deleteButton51.setAttribute("type", "text");

deleteButton51.setAttribute("name", "provider_name");

deleteButton51.setAttribute("value", provider_name);

deleteButton51.setAttribute("onFocus","this.blur()");

deleteButton51.setAttribute("class","INPUT_STYLE4");


var cell = document.createElement("td");

cell.appendChild(deleteButton51);

row.appendChild(cell);

//*********************************************
var deleteButton3 = document.createElement("input");

deleteButton3.setAttribute("type", "hidden");

deleteButton3.setAttribute("name", "type");

deleteButton3.setAttribute("value", type);

cell.appendChild(deleteButton3);

row.appendChild(cell);
//*********************************************
var deleteButton2 = document.createElement("input");

deleteButton2.setAttribute("type", "hidden");

deleteButton2.setAttribute("name", "provider_class");

deleteButton2.setAttribute("value", provider_class);

cell.appendChild(deleteButton2);

row.appendChild(cell);

//*********************************************
var deleteButton5 = document.createElement("input");

deleteButton5.setAttribute("type", "hidden");

deleteButton5.setAttribute("name", "provider_tel1");

deleteButton5.setAttribute("value", provider_tel1);

cell.appendChild(deleteButton5);

row.appendChild(cell);

//*********************************************
var deleteButton6 = document.createElement("input");

deleteButton6.setAttribute("type", "hidden");

deleteButton6.setAttribute("name", "contact_person1");

deleteButton6.setAttribute("value", contact_person1);

cell.appendChild(deleteButton6);

row.appendChild(cell);

//*********************************************
var deleteButton8 = document.createElement("input");

deleteButton8.setAttribute("type", "hidden");

deleteButton8.setAttribute("name", "provider_web");

deleteButton8.setAttribute("value", provider_web);

cell.appendChild(deleteButton8);

row.appendChild(cell);
//*********************************************

row.appendChild(createCellWithText(type));

row.appendChild(createCellWithText(provider_class));

row.appendChild(createCellWithText(provider_tel1));

row.appendChild(createCellWithText(contact_person1));

row.appendChild(createCellWithText(provider_web));




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
<%
String tablename="purchase_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1'";
String queue="order by register_time";
String validationXml="../../xml/purchase/purchase_file.xml";
String nickName="供应商档案";
String fileName="register_provider_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的供应商档案总数");
%>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs1=purchase_db.executeQuery(sql_search);
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","供应商编号")%>'},
                       {name: '<%=demo.getLang("erp","供应商名称")%>'},
                       {name: '<%=demo.getLang("erp","优质级别")%>'},
                       {name: '<%=demo.getLang("erp","产品分类")%>'},              
                       {name: '<%=demo.getLang("erp","所在区域")%>'},
                       {name: '<%=demo.getLang("erp","添加")%>'}
]
nseer_grid.column_width=[200,100,100,150,100,100];
nseer_grid.auto='<%=demo.getLang("erp","供应商名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?provider_ID=<%=rs1.getString("provider_ID")%>")><%=rs1.getString("provider_ID")%></div>','<%=exchange.toHtml(rs1.getString("provider_name"))%>','<%=exchange.toHtml(rs1.getString("provider_class"))%>','<%=exchange.toHtml(rs1.getString("chain_name"))%>','<%=exchange.toHtml(rs1.getString("type"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=addGoodsItem("<%=rs1.getString("provider_ID")%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("provider_name")))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("type")))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("provider_class")))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("provider_tel1")))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("contact_person1")))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("provider_web")))%>")><%=demo.getLang("erp","添加")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%purchase_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>

<%}else{%>
<script src="../../javascript/table/movetable.js">
</script>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>
<script language="javascript">
//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var edit=window.opener.tableOnlineEdit;
var names=['provider_ID','provider_name','type','provider_class','provider_tel1','contact_person1','provider_web'];
function addGoodsItem(provider_IDa, provider_namea, typea, provider_classa, provider_tel1a, contact_person1a, provider_weba) {

 	var provider_name=provider_namea.replace(/★/g,"<br>").replace(/☆/g," ");
 	var type=typea.replace(/★/g,"<br>").replace(/☆/g," ");
 	var provider_class=provider_classa.replace(/★/g,"<br>").replace(/☆/g," ");
 	var provider_tel1=provider_tel1a.replace(/★/g,"<br>").replace(/☆/g," ");
 	var contact_person1=contact_person1a.replace(/★/g,"<br>").replace(/☆/g," ");
 	var provider_web=provider_weba.replace(/★/g,"<br>").replace(/☆/g," ");

	var values=[provider_IDa, provider_name, type, provider_class, provider_tel1, contact_person1, provider_web];
 if(checkRow(edit,values[0])) {
 addInstanceRow(edit,names,values);
 }
}
</script>
<%
String tablename="purchase_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1'";
String queue="order by register_time";
String validationXml="../../xml/purchase/purchase_file.xml";
String nickName="供应商档案";
String fileName="register_provider_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的供应商档案总数");
%>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs1=purchase_db.executeQuery(sql_search);
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","供应商编号")%>'},
                       {name: '<%=demo.getLang("erp","供应商名称")%>'},
                       {name: '<%=demo.getLang("erp","优质级别")%>'},
                       {name: '<%=demo.getLang("erp","产品分类")%>'},              
                       {name: '<%=demo.getLang("erp","所在区域")%>'},
                       {name: '<%=demo.getLang("erp","添加")%>'}
]
nseer_grid.column_width=[200,100,100,150,100,100];
nseer_grid.auto='<%=demo.getLang("erp","供应商名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?provider_ID=<%=rs1.getString("provider_ID")%>")><%=rs1.getString("provider_ID")%></div>','<%=exchange.toHtml(rs1.getString("provider_name"))%>','<%=exchange.toHtml(rs1.getString("provider_class"))%>','<%=exchange.toHtml(rs1.getString("chain_name"))%>','<%=exchange.toHtml(rs1.getString("type"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=addGoodsItem("<%=rs1.getString("provider_ID")%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("provider_name")))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("type")))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("provider_class")))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("provider_tel1")))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("contact_person1")))%>","<%=exchange.unHtmls(exchange.toHtml(rs1.getString("provider_web")))%>")><%=demo.getLang("erp","添加")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%purchase_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%}%>