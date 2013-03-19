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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/ecommerce/ecommerce_web_template_ii.xml"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String unit_id=(String)session.getAttribute("unit_id");
String sql="select * from ecommerce_web_base where unit_id='"+unit_id+"'";
ResultSet rs=ecommerce_db.executeQuery(sql);
String key="";
if(rs.next()){
	key=rs.getString("common_page");
}

String tablename="ecommerce_web_template_ii";
String realname=(String)session.getAttribute("realeditorc");
String condition="";
String queue="order by id";
String validationXml="../../../xml/ecommerce/ecommerce_web_template_ii.xml";
String nickName="模板";
String fileName="commonPage.jsp";
String rowSummary=demo.getLang("erp","符合条件的模板总数");
int n=0;
%>
<%@include file="../../../include/search.jsp"%>
 <% 
try{
ResultSet rs1 = ecommerce_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"submit\" "+SUBMIT_STYLE1+" class=\"SUBMIT_STYLE1\" value=\""+demo.getLang("erp","提交")+"\">";
%>
<form name="selectList" id="keyRegister" method="POST" action="../../../ecommerce_website_template_commonPage_ok">
<%@include file="../../../include/search_top.jsp"%>
<input type="hidden" name="unit_id" value="<%=unit_id%>"> 
 
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","请选择II级页面模版")%>'}
]

nseer_grid.column_width=[200];
nseer_grid.auto='<%=demo.getLang("erp","请选择II级页面模版")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<% 
if(key.equals(rs1.getString("filename"))){
%>
  ['<input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="col" value="<%=rs1.getString("filename")%>" checked><%=exchange.toHtml(rs1.getString("topic"))%>'],
 <%}else{%>
	['<input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="col" value="<%=rs1.getString("filename")%>"><%=exchange.toHtml(rs1.getString("topic"))%>'],
<%
}	
n++;
if(rs1.next()){
	if(key.equals(rs1.getString("filename"))){
%>
	['<input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="col" value="<%=rs1.getString("filename")%>" checked><%=exchange.toHtml(rs1.getString("topic"))%>'],
	<%}else{%>
	['<input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="col" value="<%=rs1.getString("filename")%>"><%=exchange.toHtml(rs1.getString("topic"))%>'],
<%
}	
}
n++;
if(rs1.next()){
	if(key.equals(rs1.getString("filename"))){
%>
	['<input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="col" value="<%=rs1.getString("filename")%>" checked><%=exchange.toHtml(rs1.getString("topic"))%>'],
	<%}else{%>
	['<input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="col" value="<%=rs1.getString("filename")%>"><%=exchange.toHtml(rs1.getString("topic"))%>'],
<%
	}	
}
n++;
if(rs1.next()){
	if(key.equals(rs1.getString("filename"))){
%>
	['<input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="col" value="<%=rs1.getString("filename")%>" checked><%=exchange.toHtml(rs1.getString("topic"))%>'],
	<%}else{%>
	['<input type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" name="col" value="<%=rs1.getString("filename")%>"><%=exchange.toHtml(rs1.getString("topic"))%>'],
<%
}	
}
n++;
%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%@include file="../../../include/search_bottom.jsp"%>
<%@include file="../../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
ecommerce_db.close();
}catch(Exception ex){ex.printStackTrace();}
%> 