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
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>	
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>  
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
    <form id="retailSaleBonus" class="x-form" method="post" action="../../../hr_config_salary_retailSaleBonus_change_ok" onSubmit="return doValidate('../../../xml/hr/hr_config_public_char.xml','retailSaleBonus')">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="retailSaleBonus.jsp"></td>
 </tr>
 </table>
 <script language="javascript">
 var onecount;
 subcat = new Array();  
 subcat[0] = new 
 Array("12","","按销售额计算");  
 subcat[1] = new 
 Array("15","按计划成本单价","按毛利润计算");
	 subcat[2] = new 
 Array("18","按成本单价","按毛利润计算"); 
 onecount=3; 
 function changelocation(locationid)
  {
  retailSaleBonus.select2.length = 0;  
  var locid=locationid;
  var i;
  for (i=0;i < onecount; i++)
  {
 		 if(locid==""||locid==null){retailSaleBonus.select2.options[retailSaleBonus.select2.length]=
 			 new Option(subcat[i][1],subcat[i][1]);}//如果select1为空，则select2选择全部值
  else if (subcat[i][2] == locid)
  { 
   retailSaleBonus.select2.options[retailSaleBonus.select2.length] = new Option(subcat[i][1], 
 subcat[i][1]);
  } 
  } 
 }
</script>
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","绩效计算方式")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select1" style="width: 30%;" onChange="changelocation(retailSaleBonus.select1.options[retailSaleBonus.select1.selectedIndex].value)">
		<option value="按毛利润计算"><%=demo.getLang("erp","按毛利润计算")%></option>
		<option value="按销售额计算"><%=demo.getLang("erp","按销售额计算")%></option>
  </select></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","成本类型")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select2" style="width=30%;"><script language = "JavaScript">
	//if (retailSaleBonus.select1.value){ 如果select1没做出选择时，想让select2的值为空，则加上这个条件
	 changelocation(retailSaleBonus.select1.value)
 //}
 </script>
 </select></td>
</tr>
</table>
</form>
</div>
