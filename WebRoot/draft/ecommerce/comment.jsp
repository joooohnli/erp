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
<%@ page import="include.nseer_cookie.iisPrint"%>
<%iisPrint iisPrint=new iisPrint(request);%>
<%@ taglib uri="/erp" prefix="FCK" %>
<script type="text/javascript" src="/erp/fckeditor.js"></script>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db ecommerce_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="vt" scope ="page" class ="validata.ValidataTag"/>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<%
String checker_ID=(String)session.getAttribute("human_IDD");
String checker=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String write_time="";
String comment_ID=request.getParameter("comment_ID");
String config_id=request.getParameter("config_id");
String sql6="select * from ecommerce_workflow where object_ID='"+comment_ID+"' and check_tag='0' and config_id<'"+config_id+"'";
ResultSet rs6=ecommerce_db.executeQuery(sql6);
if(!rs6.next()&&vt.validata((String)session.getAttribute("unit_db_name"),"ecommerce_comment","comment_ID",comment_ID,"check_tag").equals("5")||!rs6.next()&&vt.validata((String)session.getAttribute("unit_db_name"),"ecommerce_comment","comment_ID",comment_ID,"check_tag").equals("9")){
try{
	String sqll = "select * from ecommerce_comment where comment_ID='"+comment_ID+"'" ;
	ResultSet rss = ecommerce_db1.executeQuery(sqll) ;
	while(rss.next()){
	String comment=rss.getString("comment");
if(rss.getString("write_time").equals("1800-01-01 00:00:00.0")){
write_time="";
}else{
write_time=rss.getString("write_time");
}
%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<form id="mutiValidation" method="post" ENCTYPE="multipart/form-data">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDsend("'mutiValidation','../../draft_ecommerce_comment_draft_ok?comment_ID="+comment_ID+"&"+Globals.TOKEN_KEY+"="+session.getAttribute(Globals.TOKEN_KEY)+"','../../xml/ecommerce/ecommerce_comment.xml'",request)%>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交审核")%>" onClick="sendOk('mutiValidation','../../draft_ecommerce_comment_check_ok?comment_ID=<%=comment_ID%>&<%=Globals.TOKEN_KEY%>=<%=session.getAttribute(Globals.TOKEN_KEY)%>','../../xml/ecommerce/ecommerce_comment.xml');">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();" /></div></td>
 </tr>
</table>
<input name="config_id" type="hidden" value="<%=config_id%>">
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","反馈信息")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","姓名")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="comment_ID" type="hidden" value="<%=rss.getString("comment_ID")%>"><input name="name" type="hidden" value="<%=exchange.toHtml(rss.getString("name"))%>"><%=exchange.toHtml(rss.getString("name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","性别")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%">
 <select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="sex">
 <%if(rss.getString("sex").equals("男")){%>
  <option selected><%=demo.getLang("erp","男")%></option>
  <option><%=demo.getLang("erp","女")%></option>
<%}else{%>
  <option><%=demo.getLang("erp","男")%></option>
  <option selected><%=demo.getLang("erp","女")%></option>
<%}%></select> 
</td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","单位")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="company" value="<%=exchange.toHtml(rss.getString("company"))%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","地址")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="address" value="<%=exchange.toHtml(rss.getString("address"))%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","电话")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="tel" type="hidden" value="<%=exchange.toHtml(rss.getString("tel"))%>"><%=exchange.toHtml(rss.getString("tel"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","Email")%>&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="email" type="hidden" value="<%=exchange.toHtml(rss.getString("email"))%>"><%=exchange.toHtml(rss.getString("email"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","反馈信息分类")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="kind">
  <%
  String sql4 = "select * from ecommerce_config_public_char where kind='反馈信息分类' order by id" ;
	 ResultSet rs4 = ecommerce_db.executeQuery(sql4) ;
while(rs4.next()){
	if(rs4.getString("type_name").equals(rss.getString("kind"))){%>
		<option value="<%=exchange.toHtml(rs4.getString("type_name"))%>" selected><%=exchange.toHtml(rs4.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs4.getString("type_name"))%>"><%=exchange.toHtml(rs4.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","反馈时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="write_time" value="<%=exchange.toHtml(write_time)%>"><%=exchange.toHtml(write_time)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","反馈信息内容")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
if(strhead.indexOf(browercheck.IE)!=-1){
%>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4"><textarea id="comment" name="comment" cols="122" rows="30"><%=comment%></textarea>
<script type="text/javascript">
 var oFCKeditor = new FCKeditor('comment') ;
 oFCKeditor.BasePath = "/erp/" ;
 oFCKeditor.Height = 400;
 oFCKeditor.ToolbarSet = "Default" ; 
 oFCKeditor.ReplaceTextarea();
</script>
</td>
<%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4"><textarea style="width:100%" id="comment" name="comment" cols="122" rows="30"><%=comment%></textarea></td>
<%}%>
 </tr>
<%=iisPrint.hasOrNot7(rss.getString("attachment1"),"附件","1",response,rss.getString("id"),FILE_STYLE1,"ecommerce_comment")%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","回复")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="reply"><%=exchange.unHtml(rss.getString("reply"))%></textarea>
</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","回复人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="hidden" name="checker_ID" value="<%=checker_ID%>"><input type="hidden" name="checker" value="<%=exchange.toHtml(checker)%>"><%=exchange.toHtml(checker)%></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","回复时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input  name="check_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
<%
	ecommerce_db.close();	
}
	ecommerce_db1.close();
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	ecommerce_db.close();	
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="comment_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该草稿已重新登记，请返回！")%></td>
 </tr>
</table>
</div>
<%}%>