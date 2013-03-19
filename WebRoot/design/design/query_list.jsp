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
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_module.xml"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>

<style>
div.neat-dialog-cont { position: absolute; top: 0; left: 0; width: 100%;
  height: 100%; z-index: 98; background: transparent }
div.neat-dialog-bg { position: absolute; top: 0; left: 0; width: 100%;
  height: 100%; opacity: 0.8; z-index: -1; background-color:#93BBF4;
  filter: alpha(opacity=80) }

div.neat-dialog-title { line-height: 1.2em; border-bottom: 1px solid #444;
  margin: 0; padding: 0.1em 0.3em; position: relative; font-size: 9pt ;background:#3F5B8C;color:#ffffff}
img.nd-cancel { position: absolute; top: 0.2em; right: 0.2em }

div.neat-dialog p { padding: 0.2em; text-align: center }

</style>

<script>
function NeatDialog(sHTML, bCancel)
{window.neatDialog = null;
this.elt = null;
var dg = document.createElement("div");
dg.id='dg';
dg.style.position='absolute';
dg.style.top='3%';
dg.style.left='10%';
dg.style.width='80%';
dg.innerHTML = sHTML;
document.body.appendChild(dg);
loadCover('dg');
this.elt = dg;
window.neatDialog = this;
}
NeatDialog.prototype.close = function()
{
if (this.elt)
{
unloadCover('dg');
this.elt.parentNode.removeChild(this.elt);
}
window.neatDialog = null;
}
</script>
<%
String tablename="design_module";
String realname=(String)session.getAttribute("realeditorc");
String condition="(check_tag='0' or check_tag='1') and excel_tag='2'and gar_tag='0'";
String queue="order by register_time desc";
String validationXml="../../xml/design/design_module.xml";
String nickName="产品物料组成设计";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的设计单总数：");
String condition1="check_tag='0' and gar_tag='0' and change_tag='0' and excel_tag='2'";
String condition2="check_tag='1' and gar_tag='0' and excel_tag='2'";
String condition3="check_tag='0' and gar_tag='0' and change_tag='1' and excel_tag='2'";
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = design_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
%>

<%@include file="../../include/search_top.jsp"%>
<%int k=1;%> 
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '&nbsp;'},
					   {name: '<%=demo.getLang("erp","设计单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","设计单状态")%>'},
                       {name: '<%=demo.getLang("erp","审核状态")%>'},
                       {name: '<%=demo.getLang("erp","装配树")%>'}
]
nseer_grid.column_width=[50,160,180,200,70,70,70];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
	<%	
String check_tag="";
String design_module_tag="";
String color="#FF9A31";
if((rs1.getString("check_tag").equals("0")&&rs1.getString("change_tag").equals("0"))||rs1.getString("check_tag").equals("9")){
design_module_tag="等待";
}else if(rs1.getString("check_tag").equals("0")&&rs1.getString("change_tag").equals("1")){
design_module_tag="执行";
color="mediumseagreen";
}else if(rs1.getString("check_tag").equals("1")&&rs1.getString("change_tag").equals("0")){
design_module_tag="完成";
color="3333FF";
}
if(rs1.getString("check_tag").equals("0")){
check_tag="等待";
}else if(rs1.getString("check_tag").equals("1")){
check_tag="通过";
}else if(rs1.getString("check_tag").equals("9")){
check_tag="未通过";
}
%>
['<%if(design_module_tag.equals("完成")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("id")%>⊙<%=rs1.getString("used_tag")%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:<%=color%>" onclick=id_link("query.jsp?design_ID=<%=rs1.getString("design_ID")%>")><span style="color:<%=color%>"><%=rs1.getString("design_ID")%></span></div>','<span style="color:<%=color%>"><%=rs1.getString("product_ID")%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("product_name"))%></span>','<span style="color:<%=color%>"><%=design_module_tag%></span>','<span style="color:<%=color%>"><%=check_tag%></span>','<div style="text-decoration : underline;color:<%=color%>" onclick=Effect.Grow(\'d1\',\'<%=exchange.toHtml(rs1.getString("product_name"))%>\',\'<%=rs1.getString("design_ID")%>\')><%=demo.getLang("erp","装配树")%></div>'],
<%k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%@include file="../../include/head_msg.jsp"%>
<%design_db.close();%>

<script src="../../javascript/load_tree/prototype.js" type="text/javascript"></script>
<script src="../../javascript/load_tree/scriptaculous.js" type="text/javascript"></script>
<script src="../../javascript/load_tree/unittest.js" type="text/javascript"></script>
<script type="text/javascript" src="../../javascript/load_tree/xtree.js"></script>
<script type="text/javascript" src="../../javascript/load_tree/xmlextras.js"></script>
<script type="text/javascript" src="../../javascript/load_tree/xloadtree.js"></script>
<link type="text/css" rel="stylesheet" href="../../javascript/load_tree/xtree.css" />
<script language="javascript">
switch (navigator.appName)
{
case "Microsoft Internet Explorer":
document.write("<style type=\"text/css\" media=\"screen\">#d1 { background-color: #8fbfef; width: 780px; height: 420px; }</style>");
break;
case "Netscape":
document.write(" <style type=\"text/css\" media=\"screen\">#d1 { background-color: #8fbfef; width: 780px; height: 420px;overflow:auto}</style>");
break;
}
</script>
<div style="z-index:1;position:absolute;left:10px;top:10px;">
<style>
.TipsGob{
position:relative;
background:#ccc;
display:none;
}
.TipsBody{
border:solid 1px #999;
top:-3px;left:-3px;
background:#e9f8f3;
position:relative;
display:none;
padding:10px;
}
</style>
<div class="TipsGob" id="open_div">
<div class="TipsBody" id="open_div1">
<div id="d1" style="display:none;border:solid 2px #9A9A9A">
<table width="100%">
<tr>
<td valign="top" width="20%">
<span id="opp"></span>
</td>
<td  width="80%" valign="top">
<span style="width:100%;height:400px;background:#D7FFFF;" id="content"></span>
</td>
</tr>
</table>
<script type="text/javascript">
var rti;
var lin1;
function href_link(lin){
if(lin.substring(0,9)==179206725){
lin1=lin.substring(9,lin.length);
}else{lin1=lin;}
var array_date_pro=lin1.split("︽");
var table_date="<table bordercolor=#000000  border=0 cellspacing=0 cellpadding=1 width=100%>";
table_date+="<tr style=\"background-image:url(../../images/line.gif);color:#000000\"><td style=\"padding: 2px 5px 2px 0.5em;\"><%=demo.getLang("erp","物料编号")%></td><td><%=demo.getLang("erp","物料名称")%></td><td><%=demo.getLang("erp","用途类型")%></td><td><%=demo.getLang("erp","描述")%></td><td><%=demo.getLang("erp","数量")%></td><td><%=demo.getLang("erp","单位")%></td><td><%=demo.getLang("erp","单价（元）")%></td><td><%=demo.getLang("erp","小计（元）")%></td></tr>";
for(var i=0;i<array_date_pro.length;i++)
{table_date+="<tr bgcolor=#CCCCFF>";
var array_date_pro1=array_date_pro[i].split("★");
for(var j=0;j<array_date_pro1.length;j++)
{
var array_data_pro_ok=array_date_pro1[j];


if(array_data_pro_ok=='7311732A')array_data_pro_ok='&nbsp;';
if(j==0){table_date+="<td style=\"background-image:url(../../images/newschannel_rightbg2.gif);padding: 2px 5px 2px 0.5em;\"><A HREF=\"javascript:details_ok('"+array_data_pro_ok.replace(/(^\s*)/g, "")+"')\" title=\"点击进入详细信息\">"+array_data_pro_ok.replace(/(^\s*)/g, "")+"</A></td>";
}else{table_date+="<td style=\"background-image:url(../../images/newschannel_rightbg2.gif);padding: 2px 5px 2px 0.5em;\">"+array_data_pro_ok+"</td>";}}
table_date+="</tr>";}
table_date+="</table>";

document.getElementById("content").innerHTML=table_date;

if(lin=='89A13'){document.getElementById("content").innerHTML=rti;}}
webFXTreeConfig.rootIcon		= "../../images/designBom/xp/folder.png";
webFXTreeConfig.openRootIcon	= "../../images/designBom/xp/openfolder.png";
webFXTreeConfig.folderIcon		= "../../images/designBom/xp/folder.png";
webFXTreeConfig.openFolderIcon	= "../../images/designBom/xp/openfolder.png";
webFXTreeConfig.fileIcon		= "../../images/designBom/xp/file.png";
webFXTreeConfig.lMinusIcon		= "../../images/designBom/xp/Lminus.png";
webFXTreeConfig.lPlusIcon		= "../../images/designBom/xp/Lplus.png";
webFXTreeConfig.tMinusIcon		= "../../images/designBom/xp/Tminus.png";
webFXTreeConfig.tPlusIcon		= "../../images/designBom/xp/Tplus.png";
webFXTreeConfig.iIcon			= "../../images/designBom/xp/I.png";
webFXTreeConfig.lIcon			= "../../images/designBom/xp/L.png";
webFXTreeConfig.tIcon			= "../../images/designBom/xp/T.png";
String.prototype.trim   =   function(){return   this.replace(/(^\s*)|(\s*$)/g,"");}
function view_tree(name,design_id){
var xmlhttp3;if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
var array_date_num=xmlhttp3.responseText.split("**");
var array_date_pro=array_date_num[0].split("@");
var table_date="<table bordercolor=#000000  border=0 cellspacing=0 cellpadding=1 width=100%>";
table_date+="<tr style=\"background-image:url(../../images/line.gif);color:#000000\"><td style=\"padding: 2px 5px 2px 0.5em;\"><%=demo.getLang("erp","物料编号")%></td><td><%=demo.getLang("erp","物料名称")%></td><td><%=demo.getLang("erp","用途类型")%></td><td><%=demo.getLang("erp","描述")%></td><td><%=demo.getLang("erp","数量")%></td><td><%=demo.getLang("erp","单位")%></td><td><%=demo.getLang("erp","单价（元）")%></td><td><%=demo.getLang("erp","小计（元）")%></td></tr>";
for(var i=0;i<array_date_pro.length;i++)
{table_date+="<tr bgcolor=#CCCCFF>";
var array_date_pro1=array_date_pro[i].split("#");
for(var j=0;j<array_date_pro1.length;j++)
{if(j==0){
table_date+="<td style=\"background-image:url(../../images/newschannel_rightbg2.gif);padding: 2px 5px 2px 0.5em;\"><A HREF=\"javascript:details_ok('"+array_date_pro1[j].replace(/(^\s*)/g, "")+"')\" title=\"点击进入详细信息\">"+array_date_pro1[j].replace(/(^\s*)/g, "")+"</A></td>";
}else{table_date+="<td style=\"background-image:url(../../images/newschannel_rightbg2.gif);padding: 2px 5px 2px 0.5em;\">"+array_date_pro1[j]+"</td>";}}
table_date+="</tr>";
}
table_date+="</table>";

rti=table_date;
document.getElementById("content").innerHTML=table_date;
var array_date=array_date_num[1].split("~!~");
var static_array_text=array_date[0].split(",");
var static_array_product=array_date[1].split("^");
var tree = new WebFXTree(name,'89A13');
for(var i=0;i<static_array_text.length;i++)
{if(parseInt(static_array_product[i].substring(0,9))==179206725){
tree.add(new WebFXTreeItem(static_array_text[i],static_array_product[i].trim()));
}else{var static_ok=static_array_product[i].split("|||");
var static_ok_one='179206725'+static_ok[1];
tree.add(new WebFXLoadTreeItem(static_array_text[i],"query_product_name.jsp?product_ID="+static_ok[0],static_ok_one));}}
document.getElementById('opp').innerHTML=tree;
}else {alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {
alert(exception);}}};
xmlhttp3.open("POST", "query_design_name.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('design_ID='+design_id);				
} else { alert('Can not create XMLHttpRequest object, please check your web browser.');}}
</script>
<p style="font-size:1em;" align="right"><a href="#" onclick="Effect.Shrink('d1');; return false;"><%=demo.getLang("erp","关闭")%></a></p>
</div>
</div>
</div>
</div>
<div id="file_details" style="width:700;height:400;position:absolute;top:30px;left:30px; display:none">
</div>
<script>
function  details_ok(product_id)
{var file_details=document.getElementById('file_details');
//file_details.style.display="block";
var xmlhttp3;
if (window.XMLHttpRequest){
xmlhttp3=new XMLHttpRequest();
}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");
}if(xmlhttp3) {
xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){
try {if(xmlhttp3.status==200) {
new NeatDialog(xmlhttp3.responseText.replace('<div align=center style=\"color:#000000;border:1px solid #ffffff;height:50px;padding:5px 0px 0px 0px\" id=\"id2\"><img src=\"../../images/include/indicator_medium.gif\">请稍候......</div>',''), false);
//file_details.innerHTML=xmlhttp3.responseText;
}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../file/query_div.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('product_ID='+product_id);				
} else {alert('Can not create XMLHttpRequest object, please check your web browser.');
}	
}
</script>
<script>
function  details_close()
{
window.neatDialog.close();
}
</script>