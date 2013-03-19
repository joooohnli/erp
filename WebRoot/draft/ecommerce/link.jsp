<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*" import="com.fredck.FCKeditor.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@ page import="include.nseer_cookie.issPrint"%>
<%issPrint issPrint=new issPrint(request);%>
<%@ taglib uri="/erp" prefix="FCK" %>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db ecommerce_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<%
String checker_ID=(String)session.getAttribute("human_IDD");
String checker=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String register_time="";
String link_ID=request.getParameter("link_ID");

if(vt.validata((String)session.getAttribute("unit_db_name"),"ecommerce_link","link_ID",link_ID,"check_tag").equals("5")||vt.validata((String)session.getAttribute("unit_db_name"),"ecommerce_link","link_ID",link_ID,"check_tag").equals("9")){
try{
	String sqll = "select * from ecommerce_link where link_ID='"+link_ID+"'" ;
	ResultSet rss = ecommerce_db1.executeQuery(sqll) ;
	if(rss.next()){
	String content=rss.getString("content");
if(rss.getString("register_time").equals("1800-01-01 00:00:00.0")){
register_time="";
}else{
register_time=rss.getString("register_time");
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<form id="mutiValidation" method="post" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_ecommerce_link_draft_ok?link_ID="+rss.getString("link_ID")+"&"+Globals.TOKEN_KEY+"="+session.getAttribute(Globals.TOKEN_KEY)+"','../../xml/ecommerce/ecommerce_link.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_ecommerce_link_check_ok?link_ID=<%=rss.getString("link_ID")%>','../../xml/ecommerce/ecommerce_link.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></div>
 </td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","链接登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","链接名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="topic" value="<%=exchange.toHtml(rss.getString("topic"))%>">&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","链接地址")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="url" value="<%=exchange.toHtml(rss.getString("url"))%>">&nbsp;</td>
 </tr>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","链接简介")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
if(strhead.indexOf(browercheck.IE)!=-1){
%>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4"><textarea id="content" name="content" cols="122" rows="30"><%=content%></textarea>
<script type="text/javascript">
 var oFCKeditor = new FCKeditor('content') ;
 oFCKeditor.BasePath = "/erp/" ;
 oFCKeditor.Height = 400;
 oFCKeditor.ToolbarSet = "Default" ; 
 oFCKeditor.ReplaceTextarea();
</script>
</td>
<%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4"><textarea style="width:100%" id="content" name="content" cols="122" rows="30"><%=content%></textarea></td>
<%}%>
 </tr>
<%=issPrint.hasOrNot3(rss.getString("attachment1"),"链接图片","1",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,FILE_STYLE1,rss.getString("id"),"ecommerce_link")%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="hidden" name="register"  value="<%=exchange.toHtml(rss.getString("register"))%>"><%=exchange.toHtml(rss.getString("register"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="hidden" name="register"  value="<%=exchange.toHtml(rss.getString("register_time"))%>"><%=exchange.toHtml(rss.getString("register_time"))%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <input type="hidden" name="checker_ID" value="<%=checker_ID%>"><input type="hidden" name="checker" value="<%=exchange.toHtml(checker)%>">
 <input  name="check_time" type="hidden" value="<%=exchange.toHtml(time)%>">
 </tr>
 </table>
 <%@include file="../include/paper_bottom.html"%>
 </div>
 </form>
<%
}
	ecommerce_db1.close();
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	ecommerce_db1.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="link_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该草稿已提交审核，请返回！")%></td>
 </tr>
</table>
</div>
<%}%>