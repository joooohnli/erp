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
<%nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="mask" class="include.operateXML.Masking"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="ResultCcols" class="include.operateDB.ResultCcols" scope="page"/>

<jsp:setProperty name="mask" property="file" value="xml/security/data.xml"/>
<%String nickName="快捷方式";%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<form method="post" action="defineProp_ok.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class=BUTTON_STYLE1 value="<%=demo.getLang("erp","返回")%>" onclick=location="shortCut.jsp"></td>
</tr>
</table>
<%
String human_id=request.getParameter("human_ID");
String href1="change_char◎shortCut_change.jsp?tree_view_name=⊙⊙⊙tree_view_name⊙⊙⊙&&category=⊙⊙⊙category⊙⊙⊙&&human_id=⊙⊙⊙human_id⊙⊙⊙&&id=⊙⊙⊙id⊙⊙⊙";
String[] href={href1};
try{
Vector names=mask.getColumnAttributes(nickName,"name");
Vector listTags=mask.getColumnAttributes(nickName,"listTag");
Vector nicks=mask.getColumnAttributes(nickName,"nick");
Vector usedTags=mask.getColumnAttributes(nickName,"usedTag");
List column=(List)(new java.util.ArrayList());
List cols=(List)(new java.util.ArrayList());
int n=0;
while(n<listTags.size()) {
String listTag=(String)listTags.elementAt(n);
String name=(String)names.elementAt(n);
String nick=(String)nicks.elementAt(n);
String usedTag=(String)usedTags.elementAt(n);

if(listTag.equals("y")&&(usedTag.equals("y")||usedTag.equals("s"))){
column.add(name);
cols.add(nick);
}

n++;
}
String dbname=(String)session.getAttribute("unit_db_name");
String tablename="drag_img";
String condition=" where human_id='"+human_id+"'";
List rs=ResultCcols.getResult(dbname,tablename,column,condition,href);
%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
<%
String str="";
String row="";
String row1="";
for(int i=0;i<cols.size();i++){
str+="{name: '"+(String)cols.get(i)+"'},";
if(i==3) row1=(String)cols.get(i);
row+="220,";
}
str=str.substring(0,str.length()-1);
row=row.substring(0,row.length()-1);
%>
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");

nseer_grid.columns =[<%=str%>]
nseer_grid.column_width=[<%=row%>];
nseer_grid.auto='<%=demo.getLang("erp",row1)%>';
nseer_grid.data = [

<%
for(int i=0;i<rs.size();i++){%>[<%String[] col=(String[])rs.get(i);String str2="";for(int j=0;j<col.length;j++){str2+="'"+col[j].replace("\n","")+"',";%><%}%><%=str2.substring(0,str2.length()-1)%>],<%}%>

['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/head_msg.jsp"%>
</form>
<%	 security_db.close();
}catch(Exception ioexception){
 ioexception.printStackTrace();
} 
%>