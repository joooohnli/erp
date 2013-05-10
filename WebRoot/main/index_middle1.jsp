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
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>

<%@include file="head.jsp"%>

<%
	 demo.setPath(request);
%>

<style type="text/css">
<!--


body {
	
	background-color: #FFFFFF;
	background-position:top;
		
	
    
}




-->
</style></head>
<script language="JavaScript">
function correctPNG() // correctly handle PNG transparency in Win IE 5.5 & 6.
{
   var arVersion = navigator.appVersion.split("MSIE")
   var version = parseFloat(arVersion[1])
   if ((version >= 5.5) && (document.body.filters)) 
   {
      for(var j=0; j<document.images.length; j++)
      {
         var img = document.images[j]
         var imgName = img.src.toUpperCase()
         if (imgName.substring(imgName.length-3, imgName.length) == "PNG")
         {
            var imgID = (img.id) ? "id='" + img.id + "' " : ""
            var imgClass = (img.className) ? "class='" + img.className + "' " : ""
            var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' "
            var imgStyle = "display:inline-block;" + img.style.cssText 
            if (img.align == "left") imgStyle = "float:left;" + imgStyle
            if (img.align == "right") imgStyle = "float:right;" + imgStyle
            if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle
            var strNewHTML = "<span " + imgID + imgClass + imgTitle
            + " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"
            + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
            + "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>" 
            img.outerHTML = strNewHTML
            j = j-1
         }
      }
   }    
}
window.attachEvent("onload", correctPNG);
</script>
<SCRIPT language=JavaScript type=text/JavaScript>
<!--
function HideMenu() 
	{
	}

function MM_preloadImages() { //v3.0
 var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
 var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
 if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
 var p,i,x; if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
 d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
 if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
 for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
 if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImgRestore() { //v3.0
 var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_swapImage() { //v3.0
 var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
 if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//--
</SCRIPT>

<%
		if(strhead.indexOf(browercheck.IE)==-1){
%>

<body >

<%
}else{%>

<body>

<body  style="filter:progid:DXImageTransform.microsoft.gradient(gradienttype=0,startColorStr=#E3F1F7,endColorStr=#ffffff">


<%}%>



<p>&nbsp;</p>
<p>&nbsp;</p>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <%
 try{
 nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));
 String status="";
ResultSet rss=security_db.executeQuery("select * from document_config_public_char where kind='????'");
if(rss.next()){
	status=rss.getString("type_name");
}
String user_ID=(String)session.getAttribute("human_IDD");
int group_length=0;
int i=0;
String sqlb="";
if(status.equals("0")){
	sqlb="select count(*) from document_main order by id";
}else{
	sqlb="select count(*) from document_main where reason!='document' order by id";
}
ResultSet rsb=security_db.executeQuery(sqlb);
if(rsb.next()){
	group_length=rsb.getInt("count(*)");
}
String[] aaa=new String[group_length];
String[] bbb=new String[group_length];
String[] ccc=new String[group_length];
String[] ext=new String[group_length];
String sqla="";
if(status.equals("0")){
	sqla="select * from document_main order by id";
}else{
	sqla="select * from document_main where reason!='document' order by id";
}
ResultSet rsa=security_db.executeQuery(sqla);
while(rsa.next()){
	aaa[i]=rsa.getString("value");
	bbb[i]=rsa.getString("reason")+"_view";
	ccc[i]=rsa.getString("reason");
	ext[i]=rsa.getString("picture");
	i++;
}
String[] aaa1=new String[group_length];
String[] bbb1=new String[group_length];
String[] ccc1=new String[group_length];
String[] ext1=new String[group_length];
i=0;
int p=0;
for(int h=0;h<group_length;h++){
String sql1="select * from "+bbb[h]+" where human_ID='"+user_ID+"'";
	ResultSet rs1=security_db.executeQuery(sql1);
	if(rs1.next()){
		aaa1[i]=aaa[h];
 bbb1[i]=bbb[h];
	 ccc1[i]=ccc[h];
		 ext1[i]=ext[h];

	 i++;
	 p=group_length-i;
	}
}
int circle=(i+4)/5;
int x=0;
for(int q=0;q<circle;q++){
	int j=0;
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
	while(x<aaa1.length-p){
	%>
 <td width="20%" align="center"><div align="center"><table align="center"><tr><td><a style="cursor:pointer;text-decoration:none" href="../<%=ccc1[x]%>/include/index_middle1.jsp?mod_c=<%=aaa1[x]%>" target="a" onclick="setId('<%=ccc1[x]%>')"><img src="../images/erpPlatform/design/<%=ext1[x]%>" width="60" height="60" hspace="1" border="0" NAME="<%=ccc1[x]%>" ></a></td></tr><tr><td><a style="cursor:pointer;text-decoration:none" href="../<%=ccc1[x]%>/include/index_middle1.jsp?mod_c=<%=aaa1[x]%>" target="a"><font color="#000000"><%=demo.getLang("erp",aaa1[x])%></font></a></td></tr></table></div>





<%
x++;
j++;
if(j>=5) break;	
}
if(x<5){
for(int y=0;y<5-i;y++){

%>
<td width=20%>&nbsp;</td>
<%}}%>
 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"><td colspan=5>&nbsp;</td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"><td colspan=5>&nbsp;</td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"><td colspan=5>&nbsp;</td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"><td colspan=5>&nbsp;</td></tr>

 <tr <%=TR_STYLE1%> class="TR_STYLE1"><td colspan=5>&nbsp;</td></tr>
<%
	 }
 security_db.close();
}catch(Exception e){e.printStackTrace();}
%>
<script>
function setId(s){
window.parent.window.frames[0].setId(s);

window.parent.window.frames[2].setId(s);

}

</script>
	
	
</table>
</body>
</html>
   <div id="nseer_ad" style="position:absolute;bottom:10px;right:12px;width:400px;height:150px;"><TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0"><TBODY><TR><TD width="1%" height="1%"><IMG  src="../images/bg_0ltop.gif"></TD><TD width="100%" background="../images/bg_01.gif"></TD><TD width="1%" height="1%"><IMG  src="../images/bg_0rtop.gif"></TD></TR><TR><TD  background="../images/bg_03.gif"></TD><TD><div style="position:absolute;top:10px;width:380px;height:130px;background:#F0F3F5;"><div style="height:50px;text-align:left;color:#FF00FF;line-height:150%;padding-top:7px;padding-left:10px;padding-right:10px;">您知道吗？<br />&nbsp;&nbsp;&nbsp;&nbsp;软件公司、系统集成公司等IT企业可以通过加盟川大科技得到加盟授权、参加相关培训、得到技术支持后就可以为企业客户提供增值服务获得收益。欢迎符合条件的企业加盟川大科技为客户提供服务实现共赢。</div></div><span style="position:absolute;top:2px;right:7px;width:18px;height:18px;cursor:hand;" onclick="document.getElementById('nseer_ad').style.display='none';"><img src="../images/gb.gif" border="0" width=17px;height=17px></span></div></div> </TD><TD  background="../images/bg_04.gif"></TD></TR><TR><TD width="1%" height="1%"><IMG  src="../images/bg_0lbottom.gif" ></TD><TD background="../images/bg_02.gif"></TD><TD width="1%" height="1%"><IMG  src="../images/bg_0rbottom.gif"></TD> </TR></TBODY></TABLE></div>
