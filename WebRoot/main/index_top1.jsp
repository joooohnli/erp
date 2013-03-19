<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*"%>
<html>
<jsp:useBean id="browercheck" scope="session" class="include.nseer_cookie.BrowerVer"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<%
	  demo.setPath(request);
%>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>New Page 1</title>
<%
String security="";
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
String field_type=(String)session.getAttribute("field_type");
String unit_name=(String)session.getAttribute("unit_name");
String weburl="";
String sqlweb="select * from oa_config_public_char where kind='公司网站'";
ResultSet rsweb=db.executeQuery(sqlweb);
if(rsweb.next()){
	weburl=rsweb.getString("type_name");
}
String status="";
ResultSet rss=db.executeQuery("select * from document_config_public_char where kind='调试状态'");
if(rss.next()){
	status=rss.getString("type_name");
}
String user_ID=(String)session.getAttribute("human_IDD");
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
String develop="";
String sqld="select * from document_main where value='开发管理' order by id";
	ResultSet rsd=db.executeQuery(sqld);
	while(rsd.next()){
		String tablename=rsd.getString("reason")+"_view";
		String sql1d="select * from "+tablename+" where human_ID='"+user_ID+"'";
	ResultSet rs1d=db1.executeQuery(sql1d);
	if(rs1d.next()){
		develop=rsd.getString("reason");
	}
	}
	int i=0;
	int x=0;
	int mod_amount=0;
	
	String sqla="";
	if(field_type.equals("0")){
	sqla = "select * from document_main where value!='开发管理' order by id";
}else{
	sqla = "select * from document_main where value!='开发管理' and fieldType_tag='1' order by id";
}
	ResultSet rsa=db.executeQuery(sqla);
	while(rsa.next()){
		String tablename=rsa.getString("reason")+"_view";
		String sql1="select * from "+tablename+" where human_ID='"+user_ID+"'";
	ResultSet rs1=db1.executeQuery(sql1);
	if(rs1.next()&&!rsa.getString("reason").equals("erpPlatform")&&!rsa.getString("reason").equals("draft")&&!rsa.getString("reason").equals("garbage")){
		mod_amount++;
	}
	}
	int circle=(mod_amount+13)/14;
	
	int height=22;
	
	%>
<%
String strhead = request.getHeader("User-Agent");
		if(strhead.indexOf(browercheck.IE)==-1){
%>
<style type="text/css">
   body {
	margin:0;
	padding:0;
    background-image: url(../images/jk.gif);
   /* background-repeat:no-repeat;*/
	
	
}

	
/*- Menu Tabs F--------------------------- */

    #tabsF {
      float:left;
      font-size:85%;
	  
    
	/*  border-bottom:1px solid #666;*/
      }
    #tabsF ul {
	margin:0;
	cursor:hand;
	padding:0px 0px 0 0px;
	list-style:none;0
	 
      }
    #tabsF li {
    cursor:hand;
      display:inline;
      margin:0;
	 
      padding:0;     
	  width:10%;
      }
    #tabsF a {
      cursor:hand;
      float:left;
      background:url("../images/main/tableftF.gif") repeat left top;
      margin:0;
      padding:0 0 0 1px;
      text-decoration:none;
      }
    #tabsF a span {
    cursor:hand;
      float:left;
      display:block;
      background:url("../images/main/tabrightF.gif") repeat right top;
	  width:100%;
      padding:5px 20px 4px 0px;
      color:#666;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsF a span {float:none;}
    /* End IE5-Mac hack */
    #tabsF a:hover span {
    cursor:hand;
      color:#FFF;
      }
    #tabsF a:hover {
    cursor:hand;
      background-position:100% -42px;
      }
    #tabsF a:hover span {
    cursor:hand;
      background-position:100% -42px;
      }
	#tabsF #main_cur a {
                background-position:0% -42px;
       }
	#tabsF #main_cur a span {
	text-align:center;
	background-position:100% -42px;
     }
	
	

</style>
<%}else{%>
<style type="text/css">
   body {
	margin:0;
	padding:0;
    background-image: url(../images/jk.gif);
  
}

	
/*- Menu Tabs F--------------------------- */
<%
if(mod_amount<=14){	
%>
    #tabsF {
      float:left;
      font-size:80%;
	  white-space:nowrap;
      }
<%}else{%>
    #tabsF {
      float:left;
      font-size:50%;
	  /*white-space:nowrap;*/
}
<%}%>
    #tabsF ul {
	margin:0;
	cursor:hand;
	padding:0px 0px 0 0px;
	list-style:none;0
	 
      }
    #tabsF li {
    cursor:hand;
      display:inline;
      margin:0;	 
      padding:0;
	  <%
if(mod_amount>=14){	
%> 
	  width:expression(document.body.offsetWidth/<%=mod_amount%>);
<%}else{%>
	  width:expression(document.body.offsetWidth/14);
<%}%>
      }
    #tabsF a {
      cursor:hand;
      float:left;
      background:url("../images/main/tableftF.gif") repeat left top;
	  width:100%;
      margin:0;
      padding:0 0 0 1px;
      text-decoration:none;
      }
    #tabsF a span {
    cursor:hand;
      float:left;
      display:block;
      background:url("../images/main/tabrightF.gif") repeat right top;
	  width:100%;
      padding:5px 10px 4px 0px;
      color:#666;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsF a span {float:none;}
    /* End IE5-Mac hack */
    #tabsF a:hover span {
    cursor:hand;
      color:#FFF;
      }
    #tabsF a:hover {
    cursor:hand;
      background-position:100% -42px;
      }
    #tabsF a:hover span {
    cursor:hand;
      background-position:100% -42px;
      }
	#tabsF #main_cur a {
                background-position:0% -42px;
       }
	#tabsF #main_cur a span {
	text-align:center;
	background-position:100% -42px;
     }
	
	

</style>
<%}%>
<STYLE>



A:visited {
	TEXT-DECORATION: none
}
A:active {
	TEXT-DECORATION: none
}
A:hover {

}
A:link {
	TEXT-DECORATION: none
}
.t {
	LINE-HEIGHT: 1.4
}

TD {
	FONT-FAMILY: 宋体; FONT-SIZE: 12px
}

FORM {
	FONT-FAMILY: 宋体; FONT-SIZE: 12px
}
OPTION {
	FONT-FAMILY: 宋体; FONT-SIZE: 12px
}
P {
	FONT-FAMILY: 宋体; FONT-SIZE: 12px
}
TD {
	FONT-FAMILY: 宋体; FONT-SIZE: 12px
}
BR {
	FONT-FAMILY: 宋体; FONT-SIZE: 12px
}
INPUT {
	BORDER-BOTTOM-COLOR: #cccccc; BORDER-BOTTOM-WIDTH: 1px; BORDER-LEFT-COLOR: #cccccc;  BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #cccccc; BORDER-RIGHT-WIDTH: 1px;  BORDER-TOP-COLOR: #cccccc; BORDER-TOP-WIDTH: 1px; FONT-SIZE: 12px; HEIGHT: 18px;  PADDING-BOTTOM: 1px; PADDING-LEFT: 1px; PADDING-RIGHT: 1px; PADDING-TOP: 1px
}
TEXTAREA {
	BACKGROUND-COLOR: #efefef; BORDER-BOTTOM-COLOR: #000000; BORDER-BOTTOM-WIDTH: 1px;  BORDER-LEFT-COLOR: #000000; BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #000000;  BORDER-RIGHT-WIDTH: 1px; BORDER-TOP-COLOR: #000000; BORDER-TOP-WIDTH: 1px; FONT-FAMILY: 宋体 ; FONT-SIZE: 12px
}
SELECT {
	BACKGROUND-COLOR: #efefef; BORDER-BOTTOM-COLOR: #000000; BORDER-BOTTOM-WIDTH: 1px;  BORDER-LEFT-COLOR: #000000; BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #000000;  BORDER-RIGHT-WIDTH: 1px; BORDER-TOP-COLOR: #000000; BORDER-TOP-WIDTH: 1px; FONT-FAMILY: 宋体 ; FONT-SIZE: 12px
}
.tdhead2{
  COLOR: #000000;
  FILTER: DropShadow(Color=#eeeeee, OffX=1, OffY=1, Positive=1);
  FONT-SIZE: 10pt; font:family: 宋体;
  HEIGHT: 10pt;
  letter-spacing:1.5px;
}
</STYLE>
<!--end css info-->
<META content="Microsoft FrontPage 4.0" name=GENERATOR>
             
<STYLE>.gray {
	CURSOR: hand; FILTER: gray
}
</STYLE>
<SCRIPT language=JavaScript type=text/JavaScript>
	function HideMenu() 
	{
	}
	</SCRIPT>

<base target="middle">

<style type="text/css">
.tb{BORDER-BOTTOM: #ff0000 1px solid;BORDER-TOP: #ff0000 1px solid;BORDER-RIGHT: #cccccc 1px solid;}
.cd{BORDER-BOTTOM: #cccccc 1px solid;BORDER-TOP: #cccccc 1px solid;BORDER-LEFT: #cccccc 1px solid;}
.ef{BORDER-BOTTOM: #cccccc 1px solid;BORDER-TOP: #cccccc 1px solid;BORDER-LEFT: #cccccc 1px solid;BORDER-RIGHT: #cccccc 1px solid;}
</style>
<link rel="stylesheet" href="images/CSS.CSS" type="text/css">
</head>
<body>
<body topmargin="0" leftmargin="0">

<script>

function setId(s){
var obj=document.getElementsByName('nseer_mod');

for(var i=0;i<obj.length;i++){

if(s==obj[i].nseer1){
obj[i].parentNode.id = "main_cur";
}

}
}

var nowli;
function selectM(obj,path){

obj.href=path;
obj.target="a";

var obj1=document.getElementsByName('nseer_mod');

for(var i=0;i<obj1.length;i++){
obj1[i].parentNode.id = "";
}
//if(nowli!=null){nowli.id = "";}
obj.parentNode.id = "main_cur";		
//nowli = obj.parentNode;
window.parent.window.frames[2].setNull();
}
function setNull(){
	var lis=document.getElementById('tabsF').getElementsByTagName('li');
	for(var a=0;a<lis.length;a++){
		lis[a].id='';
	}
}
</script>

<table>
<tr>
<td height="33"><img src="../images/main/0427.gif"/>
</td>
</tr>
</table>

<table border="0" cellspacing="0" width="100%" id="AutoNumber7" cellpadding="0" height="<%=height%>">
<tr>
	<td height="100%" align="right" background="/images/bg_s.jpg" style="padding-left:100"></td>
	 <div id="tabsF">
     <ul>

 
  <%String sql="";
	if(field_type.equals("0")){
	sql = "select * from document_main where value!='开发管理' AND (reason='design' OR reason='stock') order by id";
}else{
	sql = "select * from document_main where value!='开发管理' AND (reason='design' OR reason='stock') and fieldType_tag='1' order by id";
}
	ResultSet rs=db.executeQuery(sql);
	for(int p=0;p<circle;p++){
		x=0;
		%>
	
	<%
	while(rs.next()){
	
	String table=rs.getString("reason");
	String tablenick = "";
	       
	String tablename=rs.getString("reason")+"_view";
	String sql1="select * from "+tablename+" where human_ID='"+user_ID+"'";
	ResultSet rs1=db1.executeQuery(sql1);
	if(rs1.next()&&!rs.getString("reason").equals("erpPlatform")&&!rs.getString("reason").equals("draft")&&!rs.getString("reason").equals("garbage")){
	x++;
	%>
<li><a href="javascript:void(0)" onclick="selectM(this,'../<%=table%>/include/index_middle1.jsp?mod_c=<%=demo.getLang("erp",rs.getString("value"))%>&&main_code=<%=rs.getString("main_code")%>');" name="nseer_mod" nseer1="<%=rs.getString("reason")%>" target="a" onmouseover="window.status='powered by nseer erp';this.href='javascript:void(0)'; return true"><span><font color="#FFFFFF"><%=demo.getLang("erp",rs.getString("value"))%></span></a></li>
    
<%
}
if(x>=14) break;
}
%>
<!--  <td class="cd" width="7%" align="left"><a href="../introduce/include/index_middle.htm"><font color="#000000">使用说明</font></a></td> -->
<%
if(x<14){
for(int j=0;j<14-x;j++){%>
<%}}%>
<%
 }
db.close();
db1.close();
%>
  

  </ul>
</div>
 
</table>


</body>