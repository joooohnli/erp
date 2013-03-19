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
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% 
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db finance_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
String sql = "select account_period from finance_account_period where account_finished_tag='0' order by account_period";
ResultSet rs =finance_db.executeQuery(sql);
if(rs.next()){
	int start_account_period=0;
	start_account_period=rs.getInt("account_period");
String sqq="select id from finance_voucher";
ResultSet rsq=finance_db.executeQuery(sqq);
if(rsq.next()){
	response.sendRedirect("register_list_finish.jsp");
}else{
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@include file="../../include/head.jsp"%>
<script type="text/javascript" src="../../../javascript/include/search/ajaxDiv.js"></script>
<style>
input{
BORDER-BOTTOM:  1px;
BORDER-left:  1px ;
BORDER-right:  1px ;
BORDER-top:  1px ;
}
.ok{
background:#FFFF99;
text-align:right;
}
.ok1{
text-align:left;
background:#FFFFFF;
}
.td{
border:1px solid #FFFF99;
}
.td1{
border:0px solid #FFFF99;
}
.tdclass{
background:#ffffff;
}
.tdcolor{
background:#CCCCFF;
width:15%;
}
.tdcolor1{
background:#CCCCFF;
width:40%;
}
</style>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
try{
int i=1;
int j=0;
int rowCount=0;
int space_bar=0;
String sql1="";
ResultSet rs1 =null;
	sql = "select category_ID from finance_config_file_kind order by category_ID desc";
rs =finance_db.executeQuery(sql);
if(rs.next()){
	rowCount=rs.getInt("category_ID")+1;
}
int[][] parentIdGroup=new int[rowCount][3];
String[][] parentAmountIdGroup=new String[rowCount][3];
if(start_account_period!=1){	
%>
<script type='text/javascript' src='../../../javascript/finance/gl-init.js'></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
<table style="border:4px solid; border-collapse:collapse; width: 98%; " bordercolor=#B7D2F9 align=center cellspacing=1 id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td style="background-image:url(/erp/images/grid-hrow.gif)">&nbsp;</td>
<td style="background-image:url(/erp/images/grid-hrow.gif)" style="width:3%">&nbsp;</td>
<td style="background-image:url(/erp/images/grid-hrow.gif)" class="tdcolor" ><%=demo.getLang("erp","年初余额")%></td>
<td style="background-image:url(/erp/images/grid-hrow.gif)" class="tdcolor" ><%=demo.getLang("erp","累计借方")%></td>
<td style="background-image:url(/erp/images/grid-hrow.gif)" class="tdcolor"><%=demo.getLang("erp","累计贷方")%></td>
<td style="background-image:url(/erp/images/grid-hrow.gif)" class="tdcolor"><%=demo.getLang("erp","期初余额")%></td>
</tr>
<%
sql = "select * from finance_config_file_kind where parent_category_id!='-1' order by file_id";
rs =finance_db.executeQuery(sql);
while(rs.next()){
int[] parentId=new int[3];
String[] parentAmountId=new String[3];
	sql1="select * from finance_gl where file_ID='"+rs.getString("file_ID")+"'";
	rs1=finance_db1.executeQuery(sql1);
	if(!rs1.next()){
	if(rs.getString("details_tag").equals("1")&&rs.getInt("parent_category_id")==0){
%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onFocus="this.blur()"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdcolor"><input type=text style="background:#CCCCFF" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onFocus="this.blur()"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdcolor"><input type=text style="background:#CCCCFF" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onFocus="this.blur()"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" id="<%=parentId[0]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onFocus="this.blur()"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" id="<%=parentId[1]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onFocus="this.blur()"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdcolor"><input type=text id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onFocus="this.blur()" style="background:#CCCCFF;width:100%"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("1")&&rs.getInt("parent_category_id")!=0){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][0]%>" onFocus="this.blur()"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][1]%>" onFocus="this.blur()"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdcolor"><input type=text id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onFocus="this.blur()" style="background:#CCCCFF;width:100%"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%>&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdcolor" ><input type=text id="<%=parentId[0]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][0]%>" style="background:#CCCCFF" onFocus="this.blur()"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdcolor" ><input type=text id="<%=parentId[1]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][1]%>" style="background:#CCCCFF" onFocus="this.blur()"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdcolor"><input type=text id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onFocus="this.blur()" style="background:#CCCCFF;width:100%" ></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")==0&&rs.getString("debit_or_loan").equals("借")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>


<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[0]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[1]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>


<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")==0&&rs.getString("debit_or_loan").equals("贷")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>


<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[0]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[1]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>



<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")!=0&&rs.getString("debit_or_loan").equals("借")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdclass" ><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][0]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][1]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>


<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdclass" ><input type=text style="width:100%" id="<%=parentId[0]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][0]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[1]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][1]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")!=0&&rs.getString("debit_or_loan").equals("贷")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][0]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][1]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this,2)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[0]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][0]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[1]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][1]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this,2)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%
}
	}else{
	if(rs.getString("details_tag").equals("1")&&rs.getInt("parent_category_id")==0){
%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_sum")))%>"></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_sum")))%>"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdcolor" ><input type=text id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_sum")))%>"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdcolor"><input type=text id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onFocus="this.blur()" style="background:#CCCCFF;width:100%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_amount")))%>"></td>
<td class="tdcolor" ><input type=text id="<%=parentId[0]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_amount")))%>"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdcolor" ><input type=text id="<%=parentId[1]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_amount")))%>"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onFocus="this.blur()" style="background:#CCCCFF;width:100%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>


<%}else if(rs.getString("details_tag").equals("1")&&rs.getInt("parent_category_id")!=0){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_sum")))%>"></td>
<td class="tdcolor" ><input type=text id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][0]%>" style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_sum")))%>"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdcolor" ><input type=text id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][1]%>" style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_sum")))%>"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onFocus="this.blur()" style="background:#CCCCFF;width:100%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%>&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_amount")))%>"></td>
<td class="tdcolor" ><input type=text id="<%=parentId[0]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][0]%>" style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_amount")))%>"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdcolor" ><input type=text id="<%=parentId[1]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][1]%>" style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_amount")))%>"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onFocus="this.blur()" style="background:#CCCCFF;width:100%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")==0&&rs.getString("debit_or_loan").equals("借")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_sum")))%>"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_sum")))%>"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_sum")))%>"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_amount")))%>"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[0]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_amount")))%>"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[1]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_amount")))%>"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")==0&&rs.getString("debit_or_loan").equals("贷")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_sum")))%>"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_sum")))%>"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_sum")))%>"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_amount")))%>"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[0]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_amount")))%>"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[1]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_amount")))%>"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")!=0&&rs.getString("debit_or_loan").equals("借")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_sum")))%>"></td>
<td class="tdclass" ><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][0]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_sum")))%>"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][1]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_sum")))%>"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_amount")))%>"></td>
<td class="tdclass" ><input type=text style="width:100%" id="<%=parentId[0]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][0]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_amount")))%>"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[1]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][1]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_amount")))%>"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")!=0&&rs.getString("debit_or_loan").equals("贷")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_sum")))%>"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][0]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_sum")))%>"></td>
<%
parentId[0]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][1]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_sum")))%>"></td>
<%
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this,2)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<td class="tdcolor" ><input type=text style="background:#CCCCFF" onFocus="this.blur()" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("last_year_balance_amount")))%>"></td>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[0]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][0]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("debit_year_amount")))%>"></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[1]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][1]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("loan_year_amount")))%>"></td>
<%
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this,2)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%
}
	}
}
%>
</table>
<%
}else{	
%>
<script type='text/javascript' src='../../../javascript/finance/gl-init-first.js'></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
<table style="border:4px solid; border-collapse:collapse; width: 98%; " bordercolor=#B7D2F9 align=center cellspacing=1 id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td style="background-image:url(/erp/images/grid-hrow.gif)">&nbsp;</td>
<td style="background-image:url(/erp/images/grid-hrow.gif)" style="width:3%">&nbsp;</td>
<td style="background-image:url(/erp/images/grid-hrow.gif)" class="tdcolor"><%=demo.getLang("erp","期初余额")%></td>
</tr>
<%
sql = "select * from finance_config_file_kind where parent_category_id!='-1' order by file_id";
rs =finance_db.executeQuery(sql);
while(rs.next()){
int[] parentId=new int[3];
String[] parentAmountId=new String[3];
	sql1="select * from finance_gl where file_ID='"+rs.getString("file_ID")+"'";
	rs1=finance_db1.executeQuery(sql1);
	if(!rs1.next()){
	if(rs.getString("details_tag").equals("1")&&rs.getInt("parent_category_id")==0){
%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onFocus="this.blur()" style="background:#CCCCFF;width:100%" ></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onFocus="this.blur()" style="background:#CCCCFF;width:100%" ></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("1")&&rs.getInt("parent_category_id")!=0){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onFocus="this.blur()" style="background:#CCCCFF;width:100%" ></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%>&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onFocus="this.blur()" style="background:#CCCCFF;width:100%" ></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")==0&&rs.getString("debit_or_loan").equals("借")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")==0&&rs.getString("debit_or_loan").equals("贷")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")!=0&&rs.getString("debit_or_loan").equals("借")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")!=0&&rs.getString("debit_or_loan").equals("贷")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this,2)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this,2)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%
}
	}else{
	if(rs.getString("details_tag").equals("1")&&rs.getInt("parent_category_id")==0){
%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onFocus="this.blur()" style="background:#CCCCFF;width:100%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onFocus="this.blur()" style="background:#CCCCFF;width:100%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("1")&&rs.getInt("parent_category_id")!=0){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onFocus="this.blur()" style="background:#CCCCFF;width:100%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%>&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdcolor"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onFocus="this.blur()" style="background:#CCCCFF;width:100%" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")==0&&rs.getString("debit_or_loan").equals("借")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")==0&&rs.getString("debit_or_loan").equals("贷")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=rs.getString("file_id").substring(0,4)%>000" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=rs.getString("file_id").substring(0,4)%>000Amount" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")!=0&&rs.getString("debit_or_loan").equals("借")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this)" onkeyup="input_keyup(this,1,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>

<%}else if(rs.getString("details_tag").equals("0")&&rs.getInt("parent_category_id")!=0&&rs.getString("debit_or_loan").equals("贷")){%>
<tr id="<%=rs.getString("file_id")%>" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass"><%
space_bar=(rs.getString("file_ID").length()-4)/3;
for(int m=0;m<space_bar;m++){
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
}
%><%=rs.getString("file_name")%></td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentId[0]=i;
i++;
parentId[1]=i;
i++;
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=i%>" name="<%=parentIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this,2)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_sum")))%>"></td>
<%
parentId[2]=i;
parentIdGroup[rs.getInt("category_ID")]=parentId;
i++;
%>
</tr>

<%if(rs.getString("corr_stock_tag").equals("是")){%>
<tr id="<%=rs.getString("file_id")%>Amount" <%=TR_STYLE1%> class="TR_STYLE1">
<td class="tdclass">&nbsp;</td>
<td class="tdclass" style="width:3%"><%=rs.getString("debit_or_loan")%></td>
<%
parentAmountId[0]=parentId[0]+"Amount";
parentAmountId[1]=parentId[1]+"Amount";
%>
<td class="tdclass"><input type=text style="width:100%" id="<%=parentId[2]%>Amount" name="<%=parentAmountIdGroup[rs.getInt("parent_category_ID")][2]%>" onblur="input_blur(this)" maxlength="15" onfocus="input_focus(this,2)" onkeyup="input_keyup(this,2,'<%=rs.getString("file_id").substring(0,4)%>000Amount')" onchange="level_config" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Double.parseDouble(rs1.getString("current_balance_amount")))%>"></td>
<%
parentAmountId[2]=parentId[2]+"Amount";
parentAmountIdGroup[rs.getInt("category_ID")]=parentAmountId;
%>
</tr>
<%}%>
<%
}
	}
}
%>
</table>
<%
}

finance_db.close();
finance_db1.close();
}catch(Exception ex){
ex.printStackTrace();
}

}
}else{
	response.sendRedirect("register_list_a.jsp");
}
%>