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
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
String table_width="1260";
try{

String file_id=(String)session.getAttribute("file_id");
String file_name=(String)session.getAttribute("file_name");

if(file_id!=null){
%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<link rel="stylesheet" type="text/css" href="../../css/include/nseerTree/nseertree.css" />
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<link rel="stylesheet" type="text/css" href="../../css/finance/tabs.css">

<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script language="javascript" src="../../javascript/finance/cheque.js"></script>
<script language="javascript" src="../../javascript/finance/human.js"></script>
<script type="text/javascript" src="../../javascript/include/div/divDisappear.js"></script>
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>	
<script language="javascript" src="../../javascript/ajax/ajax-validation-f.js"></script>

<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/kindCounter.js'></script>
<script type='text/javascript' src='../../dwr/interface/NseerTreeDB.js'></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseertree.js"></script>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<script type='text/javascript' src='../../javascript/include/covers/cover.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type='text/javascript' src="../../javascript/include/nseer_cookie/toolTip.js"></script>
<script type='text/javascript' src="../../javascript/finance/teller/treeBusiness.js"></script>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick="addRow()" value="<%=demo.getLang("erp","添加")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","删除")%>" onClick="deleteRow()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","保存")%>" onClick="send('<%=file_id%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="cheque_locate.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","科目")%>:<%=file_name%>(<%=file_id%>)</td>
 </tr>
 </table>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><font size="4"><b><%=demo.getLang("erp","支票登记簿")%></b></font></td>
 </tr>
</table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","领用日期")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","领用部门")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","领用人")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","支票号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","预计金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","用途")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","收款人")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","对方科目")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","付款银行名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","银行账号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","预计转账日期")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","报销日期")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","备注")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","实际金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","支票密码")%></td>
 </tr>
 <%
String sql="select * from finance_cheque where file_id='"+file_id+"' order by register_time";
   ResultSet rs=finance_db.executeQuery(sql);
   while(rs.next()){
%>
<script>
addRow();
var line=document.getElementById(row_id1);
var tag=line.getElementsByTagName('input');
tag[0].value='<%=rs.getString("register_time")%>'=='1800-01-01'?'':'<%=rs.getString("register_time")%>';
tag[1].value='<%=rs.getString("chain_name")%>';
tag[2].value='<%=rs.getString("human_name")%>';
tag[3].value='<%=rs.getString("cheque_id")%>';
tag[4].value='<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("pre_subtotal"))%>';
tag[5].value='<%=rs.getString("field")%>';
tag[6].value='<%=rs.getString("gatherer")%>';
tag[7].value='<%=rs.getString("chain_mate_id")%>';
tag[8].value='<%=rs.getString("bank")%>';
tag[9].value='<%=rs.getString("account")%>';
tag[10].value='<%=rs.getString("pre_trans_time")%>'=='1800-01-01'?'':'<%=rs.getString("pre_trans_time")%>';
tag[11].value='<%=rs.getString("reim_time")%>'=='1800-01-01'?'':'<%=rs.getString("reim_time")%>';
tag[12].value='<%=rs.getString("remark")%>';
tag[13].value='<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("real_subtotal"))%>';
tag[14].value='<%=rs.getString("password")%>';
tag[15].value='<%=rs.getString("id")%>';
disinput(tag[11].id);
</script>
 
<%
   }
%>
</table>
<%@include file="../include/paper_bottom.html"%> 

<%
}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="cheque_locate.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","请选择银行科目！")%></td>
 </tr>
 </table>
<%}
}catch(Exception ex){ex.printStackTrace();}
%>
<script type="text/javascript">
function cal_init(obj){
var a1='aaa'+obj;
var a2='kkk'+obj;
var a3='lll'+obj;
Calendar.setup ({inputField : a1, ifFormat : "%Y-%m-%d", showsTime : false, button : a1, singleClick : true, step : 1});
Calendar.setup ({inputField : a2, ifFormat : "%Y-%m-%d", showsTime : false, button : a2, singleClick : true, step : 1});
Calendar.setup ({inputField : a3, ifFormat : "%Y-%m-%d", showsTime : false, button : a3, singleClick : true, step : 1});
}
</script>
</div>
<div id="part" nseerDef="dragAble" style="position:absolute;left:300px;top:100px;display:none;width:450px;height:300px;overflow:hidden;z-index:3;background:#E8E8E8;">
<iframe src="javascript:false" style="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
  <TABLE width="100%" height="100%" border=0 cellPadding=0 cellSpacing=0>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1"><div class="cssDiv2"><%=demo.getLang("erp","川大科技信息化平台")%></div></div>
<div class="cssDiv3"  onclick="n_D.closeDiv('hidden')"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div id="nseer4_0" style="position:absolute;left:10px;top:40px;width:100%;height:89%;overflow:auto;">
<script>
var Nseer_tree4 = new Tree('Nseer_tree4');
 Nseer_tree4.setImagesPath('../../images/');
 Nseer_tree4.setTableName('hr_config_file_kind');
 Nseer_tree4.setModuleName('../../xml/finance/fixed_assets/fa_hr_tree');
 Nseer_tree4.addRootNode('No0','<%=demo.getLang("erp","全部机构")%>',false,'1',[]);
initMyTree(Nseer_tree4);
createButton('../../xml/finance/fixed_assets/fa_hr_tree','hr_config_file_kind','treeButton_finance');
function fa_hr_kind(div_id){
document.getElementById(div_id).style.display = "none";
loadCover('nseer4');
document.getElementById('nseer4').style.display='block';
}
</script>
</div>
</TD>
<TD  background="../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>
<input type="hidden" id="Storage_input" value="">
<%finance_db.close();%>