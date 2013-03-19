<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db fund_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/fund/fund_config_file_kind.xml"/>
<% String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
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

var file_kind;

var cost_price_subtotal;

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
function addGoodsItem(file_kinda) {

var checkrow=window.opener.document.getElementById("mutiValidation");
var valuew = checkrow.file_kind;
for (var i=0; i<valuew.length; i++) {
 if(valuew[i].value==file_kinda){
return;
 }

}

file_kind=file_kinda.replace(/★/g,"<br>").replace(/☆/g," ");

action = "add";

var url = "../../include_ajax_GetXml?" 

+ createAddQueryString(file_kind, "add") 

+ "&ts=" + new Date().getTime();

createXMLHttpRequest();

xmlHttp.onreadystatechange = handleAddStateChange;

xmlHttp.open("GET", url, true);

xmlHttp.send(null);

}

//*********************************************
function createAddQueryString(file_kind, action) {

var queryString = "file_kind=" + file_kind 

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
row.appendChild(createCellWithTextCol(file_kind,"2"));

var deleteButton4 = document.createElement("input");

deleteButton4.setAttribute("type", "text");

deleteButton4.setAttribute("name", "cost_price_subtotal");

deleteButton4.setAttribute("class","INPUT_STYLE5");

cell = document.createElement("td");

//cell.setAttribute("colspan", "2");

cell.appendChild(deleteButton4);

row.appendChild(cell); 

//*********************************************

var deleteButton2 = document.createElement("input");

deleteButton2.setAttribute("type", "hidden");

deleteButton2.setAttribute("name", "file_kind");

deleteButton2.setAttribute("value", file_kind);

cell.appendChild(deleteButton2);

row.appendChild(cell);

//*********************************************



var edit=window.opener.document.getElementById("tableOnlineEdit");

edit.appendChild(row);



updateChoiceListVisibility();
}

//*********************************************
function createCellWithText(text) {

var cell = document.createElement("td");

cell.appendChild(document.createTextNode(text));

//cell.setAttribute("colspan", "2");

return cell;

}

function createCellWithTextCol(text,number) {

var cell = document.createElement("td");

cell.appendChild(document.createTextNode(text));

//cell.setAttribute("colspan", number);

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
String tablename="fund_config_file_kind";
String realname=(String)session.getAttribute("realeditorc");
String condition="parent_category_id!='-1' and details_tag='0'";
String queue="order by file_ID";
String validationXml="../../xml/fund/fund_config_file_kind.xml";
String nickName="科目";
String fileName="applyPayExpenses_fund_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的科目总数");
%>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs1=fund_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","科目")%>'},
                       {name: '<%=demo.getLang("erp","添加")%>'}
]
nseer_grid.column_width=[180,100];
nseer_grid.auto='<%=demo.getLang("erp","科目")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("file_id")%>/<%=exchange.toHtml(rs1.getString("chain_name"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=addGoodsItem("<%=rs1.getString("file_id")%>/<%=exchange.unHtmls(exchange.toHtml(rs1.getString("chain_name")))%>")><%=demo.getLang("erp","添加")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%fund_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>

<%}else{%>
<script src="../../javascript/table/movetable.js">
</script>
<script language="javascript" src="../../javascript/edit/editTable.js">
</script>
<script language="javascript">
//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var edit=window.opener.tableOnlineEdit;
var names=['file_kind'];
function addGoodsItem(file_kinda) {
file_kind=file_kinda.replace(/★/g,"<br>").replace(/☆/g," ");
	var values=[file_kind];
 if(checkRow(edit,values[0])) {
 addInstanceRow(edit,names,values);
 }
}
</script>
<%
String tablename="fund_config_file_kind";
String realname=(String)session.getAttribute("realeditorc");
String condition="parent_category_id!='-1' and details_tag='0'";
String queue="order by file_ID";
String validationXml="../../xml/fund/fund_config_file_kind.xml";
String nickName="科目";
String fileName="applyPayExpenses_fund_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的科目总数");
%>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs1=fund_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","科目")%>'},
                       {name: '<%=demo.getLang("erp","添加")%>'}
]
nseer_grid.column_width=[180,100];
nseer_grid.auto='<%=demo.getLang("erp","科目")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 

['<%=rs1.getString("file_id")%>/<%=exchange.toHtml(rs1.getString("chain_name"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=addGoodsItem("<%=rs1.getString("file_id")%>/<%=exchange.unHtmls(exchange.toHtml(rs1.getString("chain_name")))%>")><%=demo.getLang("erp","添加")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%fund_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>
<%}%>