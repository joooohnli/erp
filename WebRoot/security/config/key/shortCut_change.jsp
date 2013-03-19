<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*" import ="include.tree_index.Nseer"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script type='text/javascript' src='../../../dwr/engine.js'></script>
<script type='text/javascript' src='../../../dwr/util.js'></script>
<script type='text/javascript' src='../../../dwr/interface/ShortModuleTreeNode.js'></script>
<%
Nseer n=new Nseer();
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
String tree_view_name=request.getParameter("tree_view_name");
String category=request.getParameter("category");
String human_id=request.getParameter("human_id");
String id=request.getParameter("id");
%>
<style type="text/css">

      .root {	  
	  border: 1px solid #B7B7B7;
      padding: 0px 0px 0px 0px;
	  background: transparent url(../../../images/two.jpg) repeat-x 0 -15px;
	 
      }
      A:visited {
	  TEXT-DECORATION: none;
	  }
	  A:active {
	
	  TEXT-DECORATION: none;
	  }
	  A:hover {
	  TEXT-DECORATION: none;
	  }
	  A:link {
	  color:#000000;
	  TEXT-DECORATION: none;
	  }
      .root div {
      padding: 0px 0px 0px 0px;
      display: none;
	  border-left: 1px solid #B7B7B7;
      margin-left: 20px;
	  margin-top: 1px;
      }
      </style>
<form id="mutiValidation"  method="post" action="../../../security_config_key_shortCut_change_ok">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>"  onclick=location="shortCut_list.jsp?human_ID=<%=human_id%>"></div></td>
 </tr>
 </table>

<input name="id" type="hidden" value="<%=id%>">
<script type="text/javascript" language="JavaScript">
function toggleNode(node,id,tablename) 
{
var parent_HTML=node.innerHTML;

var temp=parent_HTML.toLowerCase().indexOf('</a>');
temp=parent_HTML.substring(0,temp+4);

var div_num=node.getElementsByTagName('DIV');
if(div_num.length>0){
var nodeArray = node.childNodes;
        for(i=0; i < nodeArray.length; i++)
        {
          node = nodeArray[i];
        if (node.tagName && node.tagName.toLowerCase() == 'a'){
			
         var img=node.getElementsByTagName('IMG');
img[0].src = (img[0].src == img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'tree_icon_folder_close.gif') ?img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'tree_icon_folder_open.gif': img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'tree_icon_folder_close.gif';
		   node.style.color = (node.style.color == '#ffffff') ? '#000000' : '#ffffff';
        }
        if (node.tagName && node.tagName.toLowerCase() == 'div'){
        node.style.display = (node.style.display == 'block') ? 'none' : 'block';
		}
        }

}else{
DWREngine.setAsync(true);//选择主模块
ShortModuleTreeNode.Category(id,tablename,'<%=id%>',{callback:function(msg){
node.innerHTML=temp+msg;


var nodeArray = node.childNodes;
        for(i=0; i < nodeArray.length; i++)
        {
          node = nodeArray[i];
		  if (node.tagName && node.tagName.toLowerCase() == 'a'){
			  var img=node.getElementsByTagName('IMG');

           img[0].src = img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'tree_icon_folder_open.gif';
		   
		  node.style.color = (node.style.display == 'block') ? '#ffffff' : '#ffffff';
        }
          if (node.tagName && node.tagName.toLowerCase() == 'div'){
            node.style.display = (node.style.display == 'block') ? 'none' : 'block';
        }
		}
}});
DWREngine.setAsync(true);
}}
</script>
<body>
<div style="position:absolute;top:50px;left:0px" id="root1">
<%

String sql1="select * from "+tree_view_name+" where human_id='"+human_id+"'&&parent_category_id='"+category+"' order by file_id" ;
ResultSet rs =db.executeQuery(sql1);
int u=0;
while(rs.next()){
u++;
if(rs.getString("details_tag").equals("1")){
%>
<div class="root"><a href="" onclick="toggleNode(this.parentNode,'<%=rs.getString("CATEGORY_ID")%>','<%=tree_view_name.split("_")[0]%>'); return false;" style="background-image:url(../../../images/two.jpg);width:100%;"><span style="padding:0px 0px 0px 3px"><img src="../../../images/tree_icon_folder_close.gif" align="absmiddle" style="border: 0;" ></span><span style="padding:0px 0px 0px 8px"><%=rs.getString("file_name")%></span></a></div>
<%}else{%>
<div class="root"><a href="javascript:void(0)"  style="background-image:url(../../../images/two.jpg);width:100%;"><span style="padding:0px 0px 0px 8px"><input type="radio" name="firstwork_radio" value="<%=rs.getString("file_path")%><%=rs.getString("hreflink")%>"><%=rs.getString("file_name")%></span></a></div>
<%}

}
if(u==0)out.println(demo.getLang("erp","对不起，这已经是工作界面不需要变更！"));

db.close();
%>

</div>
</form>
<script>
window.onload=function (){
document.getElementById('root1').style.width=document.body.clientWidth+'px';
}
window.onresize=function (){
document.getElementById('root1').style.width=document.body.clientWidth+'px';
}
</script>

