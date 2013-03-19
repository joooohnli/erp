<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java"%>
<META content="MSHTML 6.00.2900.2722" name=GENERATOR></HEAD>
<form method="post" action="defineProp_ok.jsp?xml_file=<%=xml_file%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><%=handbook%></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","保存")%>">&nbsp;&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onclick=location="defineProp_locate.jsp"></td>
</tr>
</table>
<%
try{
String url_temp0="";
for(int i=0;i<request.getRequestURI().split("/").length-3;i++){url_temp0+="../";}
Vector types=mask.getColumnAttributes("type");
Vector requireds=mask.getColumnAttributes("required");
Vector names=mask.getColumnAttributes("name");
Vector columns1=mask.getColumnAttributes("usedTag");
Vector columns=mask.getColumnAttributes("nick");
Vector services=mask.getColumnAttributes("service");
%>
<script type="text/javascript" src="<%=url_temp0%>javascript/include/nseergrid/nseergrid.js"></script>
<link rel="stylesheet" type="text/css" href="<%=url_temp0%>css/include/nseergrid/nseer.css" />
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.imgPath = '<%=url_temp0%>';
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","属性名称")%>'},
					   {name: '<%=demo.getLang("erp","用途")%>'},
					   {name: '<%=demo.getLang("erp","字段类型")%>'},
					   {name: '<%=demo.getLang("erp","是否为必填项")%>'},
                       {name: '<%=demo.getLang("erp","是否启用")%>'}
]
nseer_grid.column_width=[100,200,200,200,200];
nseer_grid.auto="属性名称";
nseer_grid.data = [
<%
int n=0;
while(n<columns.size()) {
String usedTag=(String)columns1.elementAt(n);
String required=(String)requireds.elementAt(n);
String service=(String)services.elementAt(n);
if(service.equals("b")||service.equals("p")){
	String service_temp="";if(service.equals("b")){service_temp=demo.getLang("erp","业务");}else if(service.equals("p")){service_temp=demo.getLang("erp","页面");}
if(usedTag.equals("s")){
%>
['<%=exchange.toHtml((String)columns.elementAt(n))%>','<%=exchange.toHtml(service_temp)%>','<%=exchange.toHtml((String)types.elementAt(n))%>','<%if(required.equals("y")){%><input type="checkbox" name="req" value="<%=exchange.toHtml((String)names.elementAt(n))%>" checked><%}else if(required.equals("n")){%><input type="checkbox" name="req" value="<%=exchange.toHtml((String)names.elementAt(n))%>"><%}%>','<%=demo.getLang("erp","系统内置")%>'],
<%}else if(usedTag.equals("y")){%>
['<input type="text" name="nick" value="<%=exchange.toHtml((String)columns.elementAt(n))%>" onclick=this.focus()>','<%=exchange.toHtml(service_temp)%>','<%=exchange.toHtml((String)types.elementAt(n))%>','<%if(required.equals("y")){%><input type="checkbox" name="req" value="<%=exchange.toHtml((String)names.elementAt(n))%>" checked><%}else if(required.equals("n")){%><input type="checkbox" name="req" value="<%=exchange.toHtml((String)names.elementAt(n))%>"><%}%>','<input type="checkbox" name="col" value="<%=exchange.toHtml((String)names.elementAt(n))%>" checked>'],
<%}else if(usedTag.equals("n")){%>
['<input type="text" name="nick" value="<%=exchange.toHtml((String)columns.elementAt(n))%>" onclick=this.focus()>','<%=exchange.toHtml(service_temp)%>','<%=exchange.toHtml((String)types.elementAt(n))%>','<%if(required.equals("y")){%><input type="checkbox" name="req" value="<%=exchange.toHtml((String)names.elementAt(n))%>" checked><%}else if(required.equals("n")){%><input type="checkbox" name="req" value="<%=exchange.toHtml((String)names.elementAt(n))%>"><%}%>','<input type="checkbox" name="col" value="<%=exchange.toHtml((String)names.elementAt(n))%>">'],

<%}}%>
<%n++;}%>
/*************************************************************/
['']];
nseer_grid.init();
/***********************************************************/
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
</head>
<!-- /*************************************************************/ -->
</html>  
<%n=0;
while(n<columns.size()) {%>
<input type="hidden" name="colname" value="<%=exchange.toHtml((String)names.elementAt(n))%>">
<%
n++;
}%>
</form>
<%	 
}catch(Exception ioexception){
 ioexception.printStackTrace();
} 
%>