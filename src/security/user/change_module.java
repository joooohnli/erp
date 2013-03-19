package security.user;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.* ;
import java.io.*;

import include.nseer_cookie.DealWithString;
import include.nseer_cookie.KindDeep;
import include.nseer_cookie.MaxKind;
import include.nseer_cookie.ReadXmlLength;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import include.tree_index.Nseer;
import include.tree_index.businessComment;



public class change_module extends HttpServlet{
ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();
businessComment demo=new businessComment();
ReadXmlLength xml=new ReadXmlLength();
DealWithString DealWithString=new DealWithString(application);
String mod="/erp/security/user/change_module.jsp";
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
PrintWriter out=response.getWriter();
try{
Nseer n=new Nseer();
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
String dbase="";
String module="";
String human_name=request.getParameter("human_name");
String human_ID=request.getParameter("human_ID");
String choose_value=request.getParameter("choose_value");

MaxKind max=new MaxKind((String)session.getAttribute("unit_db_name"),choose_value.split("/")[0]+"_tree","file_id");
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
path=path+"xml\\hr\\config\\file\\tree-config.xml";
int first_length=2;
int step_length=2;
int kind_rows=KindDeep.getDeep(max.maxValue("file_id"),first_length,step_length);
kind_rows=kind_rows-1;
max.close();
include.nseer_cookie.BrowerVer browercheck = null;
synchronized (session) {
  browercheck = (include.nseer_cookie.BrowerVer) pageContext.getAttribute("browercheck", PageContext.SESSION_SCOPE);
  if (browercheck == null){
    browercheck = new include.nseer_cookie.BrowerVer();
    pageContext.setAttribute("browercheck", browercheck, PageContext.SESSION_SCOPE);
  }
}
String strhead = request.getHeader("User-Agent");
out.write("\r\n");
out.write("<style>\r\n");
out.write(".nseerGround{\r\n");
out.write("\tposition:absolute;\r\n");
out.write("\tleft:1%;\r\n");
out.write("\theight:100%;\r\n");
out.write("\twidth:98%;\r\n");
out.write("\t");
if(strhead.indexOf(browercheck.IE)!=-1){
out.write("z-index:-1;");
}
out.write("\r\n");
out.write("}\r\n");
out.write(".div_handbook{\r\n");
out.write("\tposition:absolute;\r\n");
out.write("\tleft:1%;\r\n");
out.write("\twidth:98%\r\n");
out.write("}\r\n");
out.write("form{\r\n");
out.write("\tmargin:0;\r\n");
out.write("}\r\n");
out.write(".resizeDivClass\r\n");
out.write("{\r\n");
out.write("position:relative;\r\n");
out.write("background-color:#DEDBD6;\r\n");
out.write("width:2;\r\n");
out.write("z-index:1;\r\n");
out.write("left:expression(this.parentElement.offsetWidth-1);\r\n");
out.write("cursor:e-resize;\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write("A:visited {\r\n");
out.write("\tTEXT-DECORATION: none\r\n");
out.write("}\r\n");
out.write("A:active {\r\n");
out.write("\tTEXT-DECORATION: none\r\n");
out.write("}\r\n");
out.write("A:hover {\r\n");
out.write("\tTEXT-DECORATION: underline overline\r\n");
out.write("}\r\n");
out.write("A:link {\r\n");
out.write("\tTEXT-DECORATION: none\r\n");
out.write("}\r\n");
out.write(".t {\r\n");
out.write("\tLINE-HEIGHT: 1.4\r\n");
out.write("}\r\n");
out.write("BODY {\r\n");
out.write("\tFONT-FAMILY: 宋体;\r\n");
out.write("\tFONT-SIZE: 9pt;\r\n");
out.write("\tscrollbar-face-color :#F1F1F1;\r\n");
out.write("\tSCROLLBAR-HIGHLIGHT-COLOR: #F1F1F1;\r\n");
out.write("\tSCROLLBAR-SHADOW-COLOR: buttonface;\r\n");
out.write("\tSCROLLBAR-3DLIGHT-COLOR: buttonhighlight;\r\n");
out.write("\tSCROLLBAR-TRACK-COLOR: #868686\r\n");
out.write("\tSCROLLBAR-DARKSHADOW-COLOR: buttonshadow;\r\n");
out.write("\tmargin-left: 0px;\r\n");
out.write("\tmargin-top: 0px;\r\n");
out.write("\tmargin-right: 0px;\r\n");
out.write("\tmargin-bottom: 0px;\r\n");
out.write("}\r\n");
out.write("TD {\r\n");
out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
out.write("}\r\n");
out.write("DIV {\r\n");
out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
out.write("}\r\n");
out.write("FORM {\r\n");
out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
out.write("}\r\n");
out.write("OPTION {\r\n");
out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
out.write("}\r\n");
out.write("P {\r\n");
out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
out.write("}\r\n");
out.write("TD {\r\n");
out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
out.write("}\r\n");
out.write("BR {\r\n");
out.write("\tFONT-FAMILY: 宋体; FONT-SIZE: 9pt\r\n");
out.write("}\r\n");
out.write(".gray {\r\n");
out.write("\tCURSOR: hand; FILTER: gray\r\n");
out.write("}\r\n");
out.write(".style3 {\r\n");
out.write("\tfont-size: 16px;\r\n");
out.write("\tfont-weight: bold;\r\n");
out.write("}\r\n");
out.write(".TABLE_STYLE11{\r\n");
out.write("\tborder: 1px solid;\r\n");
out.write("\tborder-collapse: collapse;\r\n");
out.write("\twidth: 95%;\r\n");
out.write("\t\r\n");
out.write("}\r\n");
out.write(".TABLE_STYLE1{\r\n");
out.write("\tborder: 1px solid;\r\n");
out.write("\tborder-collapse: collapse;\r\n");
out.write("\twidth: 95%;\r\n");
out.write("\t\r\n");
out.write("}\r\n");
out.write(".TABLE_STYLE2{\r\n");
out.write("\twidth: 95%;\r\n");
out.write("\t\r\n");
out.write("}\r\n");
out.write(".TABLE_STYLE3{\r\n");
out.write("\twidth: 100%;\r\n");
out.write("\t\r\n");
out.write("}\r\n");
out.write(".TABLE_STYLE4{\r\n");
out.write("\twidth: 95%;\r\n");
out.write("\t\r\n");
out.write("}\r\n");
out.write(".TABLE_STYLE5{\r\n");
out.write("\tborder: 1px solid;\r\n");
out.write("\tborder-collapse: collapse;\r\n");
out.write("\twidth: 95%;\r\n");
out.write("\t\r\n");
out.write("}\r\n");
out.write(".TABLE_STYLE6{\r\n");
out.write("\twidth: 820;\t\r\n");
out.write("}\r\n");
out.write(".TABLE_STYLE7{\r\n");
out.write("\tborder: 1px solid;\r\n");
out.write("\tborder-collapse: collapse;\r\n");
out.write("\twidth: 100%;\t\r\n");
out.write("}\r\n");
out.write(".ALL-STYLE{\r\n");
out.write("\tborder: 1px ridge #666666;\r\n");
out.write("\tborder-color:#DEDBD6;\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".TR_STYLE1{\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".TR_STYLE2{\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".style8 {color: #000066}\r\n");
out.write("\r\n");
out.write(".TD_HANDBOOK_STYLE1 {\r\n");
out.write("\tvertical-align : top ;\r\n");
out.write("\twidth:100%;\r\n");
out.write("\tcolor:#0000FF;\r\n");
out.write("}\r\n");
out.write("\r\n");
out.write(".TD_STYLE1{\r\n");
out.write("  background-image:url(/erp/images/line7.gif);\r\n");
out.write("}\r\n");
out.write("\r\n");
out.write(".TD_STYLE2{\r\n");
out.write("border-spacing: 1px;\r\n");
out.write("}\r\n");
out.write(".TD_STYLE3{\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".TD_STYLE4{\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".TD_STYLE5{\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".TD_STYLE6{\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".TD_STYLE7{\r\n");
out.write("  background-image:url(/erp/images/line4.gif);\r\n");
out.write("}\r\n");
out.write(".TD_STYLE8{\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".SUBMIT_STYLE1{\r\n");
out.write("BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#B3D997); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".BUTTON_STYLE1{\r\n");
out.write("BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#B3D997); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
out.write("}\r\n");
out.write(".RESET_STYLE1{\r\n");
out.write("BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#B3D997); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
out.write("}\r\n");
out.write(".RADIO_STYLE1{\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".CHECKBOX_STYLE1{\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".SELECT_STYLE1{\r\n");
out.write("width:100%;\r\n");
out.write("}\r\n");
out.write(".SELECT_STYLE2{\r\n");
out.write("width:100%;\r\n");
out.write("}\r\n");
out.write(".TEXTAREA_STYLE1{\r\n");
out.write("width:100%;\r\n");
out.write("}\r\n");
out.write(".DIV_STYLE1{\r\n");
out.write("\r\n");
out.write("float :right ;\r\n");
out.write("vertical-align : top ;\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".DIV_STYLE2{\r\n");
out.write("\r\n");
out.write("float :center ;\r\n");
out.write("vertical-align : top ;\r\n");
out.write("\r\n");
out.write("}\r\n");
out.write(".INPUT_STYLE1{\r\n");
out.write("width:100%\r\n");
out.write("}\r\n");
out.write(".INPUT_STYLE3{\r\n");
out.write("BORDER-BOTTOM:  1px solid #000000;\r\n");
out.write("BORDER-left:  0px ;\r\n");
out.write("BORDER-right:  0px ;\r\n");
out.write("BORDER-top:  0px ;\r\n");
out.write("width:100%\r\n");
out.write("}\r\n");
out.write(".INPUT_STYLE4{\r\n");
out.write("BORDER-BOTTOM:  0px;\r\n");
out.write("BORDER-left:  0px ;\r\n");
out.write("BORDER-right:  0px ;\r\n");
out.write("BORDER-top:  0px ;\r\n");
out.write("width:100%\r\n");
out.write("}\r\n");
out.write(".INPUT_STYLE5{\r\n");
out.write("background-color:#FFFFCC;\r\n");
out.write("BORDER-BOTTOM:  0px;\r\n");
out.write("BORDER-left:  0px ;\r\n");
out.write("BORDER-right:  0px ;\r\n");
out.write("BORDER-top:  0px ;\r\n");
out.write("width:100%\r\n");
out.write("}\r\n");
out.write(".FILE_STYLE1{\r\n");
out.write("BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#B3D997); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
out.write("}\r\n");
out.write(".btn3_mouseout {\r\n");
out.write("BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#B3D997); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
out.write("}\r\n");
out.write(".btn3_mouseover {\r\n");
out.write("BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#B3D997); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
out.write("}\r\n");
out.write(".btn3_mousedown\r\n");
out.write("{\r\n");
out.write("BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#B3D997); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
out.write("}\r\n");
out.write(".btn3_mouseup {\r\n");
out.write("BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#B3D997); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid\r\n");
out.write("}\r\n");
out.write("</STYLE>\r\n");
out.write("</head>\r\n");
out.write("<body bgcolor=\"#000000\" oncontextmenu=\"event.returnValue=true\" style=\"filter:progid:DXImageTransform.microsoft.gradient(gradienttype=0,startColorStr=#E4F1F7,endColorStr=#DFFCCE\">\r\n");

try{
String url_temp="";
String file_url=request.getRequestURI();
for(int i=0;i<file_url.split("/").length-3;i++){
url_temp+="../";
}

out.write("\r\n");
out.write("<script type=\"text/javascript\" src=\"");
out.print(url_temp);
out.write("javascript/include/nseergrid/nseergrid.js\"></script>\r\n");
out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
out.print(url_temp);
out.write("css/include/nseergrid/nseer.css\" />\r\n");
out.write("<script type=\"text/javascript\" src=\"");
out.print(url_temp);
out.write("javascript/include/search/ajaxDiv.js\"></script>\r\n");
out.write("<script type='text/javascript' src='");
out.print(url_temp);
out.write("dwr/engine.js'></script>\r\n");
out.write("<script type='text/javascript' src='");
out.print(url_temp);
out.write("dwr/util.js'></script>\r\n");
out.write("<script type='text/javascript' src='");
out.print(url_temp);
out.write("dwr/interface/Multi.js'></script>\r\n");
out.write("<script type='text/javascript' src='");
out.print(url_temp);
out.write("dwr/interface/multiLangValidate.js'></script>\r\n");
out.write("<script type='text/javascript' src='");
out.print(url_temp);
out.write("dwr/interface/ResultKey.js'></script>\r\n");
out.write("<script type=\"text/javascript\" src=\"");
out.print(url_temp);
out.write("javascript/calendar/cal.js\"></script>\r\n");
out.write("<script type=\"text/javascript\" src=\"");
out.print(url_temp);
out.write("javascript/include/validate/validation-framework.js\"></script>\r\n");
out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
out.print(url_temp);
out.write("css/include/nseer_cookie/xml-css.css\"/>\r\n");
out.write("<link rel=\"stylesheet\" type=\"text/css\" media=\"all\" href=\"");
out.print(url_temp);
out.write("javascript/calendar/calendar-win2k-cold-1.css\">\r\n");
out.write("<script type=\"text/javascript\" src=\"");
out.print(url_temp);
out.write("javascript/ajax/niceforms.js\"></script>\r\n");
out.write("<script type='text/javascript' src='");
out.print(url_temp);
out.write("javascript/include/div/divViewChange.js'></script>\r\n");
out.write("<script type='text/javascript' src='");
out.print(url_temp);
out.write("javascript/include/covers/cover.js'></script>\r\n");
out.write("<script language=\"javascript\">\r\n");
out.write("if (window.attachEvent)window.attachEvent(\"onload\",function(){document.all('LoadProcess_head').style.visibility =\"hidden\";document.all('mengban_head').style.visibility = \"hidden\";document.all('ifra_head').style.visibility = \"hidden\";});\r\n");
out.write("if (window.addEventListener)window.addEventListener(\"load\",function(){document.all('LoadProcess_head').style.visibility = \"hidden\";document.all('mengban_head').style.visibility = \"hidden\";document.all('ifra_head').style.visibility = \"hidden\";},false)\r\n");
out.write("</script>\r\n");
out.write("<style>\r\n");
out.write(".mengban_head{ \r\n");
out.write("position:absolute;\r\n");
out.write("height:50px;\r\n");
out.write("z-index:10;\r\n");
out.write("top:0;\r\n");
out.write("left:0;\r\n");
out.write("background-color:#84ACFF;\r\n");
out.write("width:100%;\r\n");
out.write("visibility: visible;\r\n");
out.write("filter:alpha(opacity=10);\r\n");
out.write("}\r\n");
out.write("</style>\r\n");
out.write("<iframe id=\"ifra_head\" style=\"filter:alpha(opacity=50);position:absolute;width:expression(this.nextSibling.offsetWidth);height:50px;top:expression(this.nextSibling.offsetTop);left:expression(this.nextSibling.offsetLeft);\" frameborder=\"0\" ></iframe>\r\n");
out.write("<div class=\"mengban_head\" id=\"mengban_head\"></div>\r\n");
out.write("<div  id=\"LoadProcess_head\" style=\"position:absolute; left:40%; top:111px; width:280px; height:50px; z-index:1;z-index:11;\"> \r\n");
out.write("  <div align=center style=\"color:#000000;border:0px solid #ffffff;height:50px;padding:5px 0px 0px 0px\" id=\"id2\"></div>\r\n");
out.write("</div>\r\n");

}catch(Exception ex){}

out.write('\r');
out.write('\n');

String TABLE_STYLE11="bordercolor=#000000 bordercolorlight=#848284 bordercolordark=#eeeeee border=1 cellspacing=0 cellpadding=0 align=center";
String TABLE_STYLE1="bordercolor=#000000 bordercolorlight=#000000 bordercolordark=#000000 border=0 cellspacing=1 cellpadding=1 bgcolor=#EEEEEE align=center";
String TABLE_STYLE2="";
String TABLE_STYLE3="";
String TABLE_STYLE4="align=center";
String TABLE_STYLE5="bordercolor=#000000 bordercolorlight=#848284 bordercolordark=#eeeeee border=1 cellspacing=0 cellpadding=0 align=center";
String TABLE_STYLE6="align=center";
String TABLE_STYLE7="bordercolor=#000000  bordercolorlight=#000000 bordercolordark=#000000 border=0 cellspacing=1 cellpadding=1 bgcolor=#ffffff align=center";//书签
String TR_STYLE1="height=20";
String TR_STYLE2="height=20 bgcolor=#D2E9FF";
String TD_STYLE1="bordercolorlight=#848284 bordercolordark=#eeeeee align=right";
String TD_STYLE2="bordercolor=#DEDBD6 align=left";
String TD_STYLE11="bgcolor=#D2E9FF bordercolorlight=#000000 bordercolordark=#000000 align=left height=20";
String TD_STYLE21="valign=top bgcolor=#eeeeee bordercolor=#000000";
String TD_STYLE3="";
String TD_STYLE4="bgcolor=#D2E9FF bordercolorlight=#000000 bordercolordark=#000000 align=right";//档案类
String TD_STYLE5="align=center height=5";
String TD_STYLE6="bordercolor=#DEDBD6 align=right";
String TD_STYLE7="";
String TD_STYLE8="";
String INPUT_STYLE1="";
String INPUT_STYLE3="";
String INPUT_STYLE4="";
String INPUT_STYLE5="";
String SUBMIT_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String BUTTON_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String RESET_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String FILE_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String RADIO_STYLE1="";
String CHECKBOX_STYLE1="";
String SELECT_STYLE1="";
String SELECT_STYLE2="size=1";
String TEXTAREA_STYLE1="rows=4";
String DIV_STYLE1="";
String DIV_STYLE2="";
String TD_HANDBOOK_STYLE1="";
out.println("<form method=\"post\" id=\"keyRegister\" name=\"selectList\" action=\"security_user_change_module_ok\">");    
out.println("<table "+TABLE_STYLE2+" class=\"TABLE_STYLE2\">"); 
out.println(" <tr "+TR_STYLE1+" class=\"TR_STYLE1\">"); 
out.println(" <td "+TD_HANDBOOK_STYLE1+" class=\"TD_HANDBOOK_STYLE1\"><div class=\"div_handbook\">"+handbook+"</div></td>"); 
out.println(" </tr>"); 
out.println(" </table>"); 
out.println(" <table "+TABLE_STYLE2+" class=\"TABLE_STYLE2\" style=\"width:100%\">"); 
out.println("	<tr "+TR_STYLE1+" class=\"TR_STYLE1\">"); 
out.println(" <td "+TD_STYLE3+" class=\"TD_STYLE3\">"); 
out.println(" <div "+DIV_STYLE1+" class=\"DIV_STYLE1\"><input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","全选")+"\" id=\"check\" onClick=\"selAl()\">&nbsp;<input type=\"submit\" "+SUBMIT_STYLE1+" class=\"SUBMIT_STYLE1\" value=\""+demo.getLang("erp","提交")+"\" name=\"B1\"> <input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","返回")+"\" onClick=\"history.back()\"></div>"); 
out.println(" </td>"); 
out.println(" </tr>"); 
out.println("</table>"); 
out.println("<input type=\"hidden\" name=\"choose_value\" value=\""+exchange.toHtml(choose_value)+"\">"); 
out.println("<input type=\"hidden\" name=\"human_ID\" value=\""+human_ID+"\">"); 
out.println("<input type=\"hidden\" name=\"human_name\" value=\""+exchange.toHtml(human_name)+"\">"); 
out.println("<div id=\"nseer_grid_div\"></div>"); 
out.println("<script type=\"text/javascript\">"); 
out.println("function id_link(link){"); 
out.println("document.location.href=link;"); 
out.println("}"); 
out.println("var nseer_grid = new nseergrid();"); 
out.println("nseer_grid.callname = \"nseer_grid\";"); 
out.println("nseer_grid.parentNode = nseer_grid.$(\"nseer_grid_div\");"); 
out.println("nseer_grid.columns =["); 

for(int i=1;i<=kind_rows;i++){
if(i!=kind_rows){
out.println("  {name: '"+i+demo.getLang("erp","级模块")+"'},"); 
}else{
out.println(" {name: '"+i+demo.getLang("erp","级模块")+"'}"); 
}}    
out.println("]"); 
out.println("nseer_grid.column_width=["); 

for(int i=1;i<=kind_rows;i++){
if(i!=kind_rows){
out.println(" 250,"); 
}else{
out.println(" 250"); 
}}
out.println("];"); 
out.println("nseer_grid.auto='"+demo.getLang("erp","3级模块")+"';"); 
out.println("nseer_grid.data = ["); 

String sql1="select * from "+choose_value.split("/")[0]+"_tree where workflow_tag='0' order by file_id" ;
ResultSet rs1=db.executeQuery(sql1);
rs1.next();
while(rs1.next()){
String file_id=rs1.getString("file_id").trim();
int len=KindDeep.getDeep(file_id,2,2);//判断长度,判断属于几级机构.
len=len-2;
if(!rs1.getString("hreflink").equals("")||rs1.getInt("details_tag")==1){
	String sql="select id from "+choose_value.split("/")[0]+"_view where human_ID='"+human_ID+"' and file_id='"+rs1.getString("file_id")+"'";
	ResultSet rs=db1.executeQuery(sql);
	if(rs.next()){

String str="";	
for(int i=0;i<kind_rows;i++){
if(len==i){
	str+="'<input type=\"checkbox\" name=\"file_id\" value="+rs1.getString("file_id")+" onclick=\"select_value(this)\" checked>"+rs1.getString("file_name")+"',";
}else{
   str+="'',";
}
}
str=str.substring(0,str.length()-1);

out.println("["+str+"],"); 
}else{

String str1="";	
for(int i=0;i<kind_rows;i++){
if(len==i){
	str1+="'<input type=\"checkbox\" name=\"file_id\" value="+rs1.getString("file_id")+" onclick=\"select_value(this)\" >"+rs1.getString("file_name")+"',";
}else{
   str1+="'',";
}
}
str1=str1.substring(0,str1.length()-1);

out.println("["+str1+"],"); 

}
}}

out.println("['']];"); 
out.println("nseer_grid.init();"); 
out.println("</script>"); 
out.println("<div id=\"drag_div\"></div>"); 
out.println("<div id=\"point_div_t\"></div>"); 
out.println("<div id=\"point_div_b\"></div>"); 
out.println("</form>"); 

db.close();
db1.close();
}catch(Exception ex){ex.printStackTrace();}

out.println("<script>"); 
out.println("function select_value(s){"); 
out.println("var value_length=s.value.length;"); 
out.println("if(s.checked){"); 
out.println("var checkbox_array=document.getElementsByTagName('input');"); 
out.println("for(var i=0;i<checkbox_array.length;i++){"); 
out.println("if(checkbox_array[i].type=='checkbox'&&checkbox_array[i].value.substring(0,value_length)==s.value&&checkbox_array[i].value.length>value_length){"); 
out.println("checkbox_array[i].checked=true;"); 
out.println("}"); 
out.println("}"); 
out.println("}else{"); 
out.println("var checkbox_array=document.getElementsByTagName('input');"); 
out.println("for(var i=0;i<checkbox_array.length;i++){"); 
out.println("if(checkbox_array[i].type=='checkbox'&&checkbox_array[i].value.substring(0,value_length)==s.value&&checkbox_array[i].value.length>value_length){"); 
out.println("checkbox_array[i].checked=false;"); 
out.println("}"); 
out.println("}"); 
out.println("}"); 
out.println("}"); 
out.println("function selAl(){"); 
out.println("var checkbox_array=document.getElementsByTagName('input');"); 
out.println("if(document.getElementById('check').value=='反选'){"); 
out.println("for(var i=0;i<checkbox_array.length;i++){"); 
out.println("if(checkbox_array[i].type=='checkbox'){"); 
out.println("checkbox_array[i].checked=false;"); 
out.println("}"); 
out.println("}"); 
out.println("document.getElementById('check').value='全选';"); 
out.println("}else{"); 
out.println("for(var i=0;i<checkbox_array.length;i++){"); 
out.println("if(checkbox_array[i].type=='checkbox'){"); 
out.println("checkbox_array[i].checked=true;"); 
out.println("}"); 
out.println("}"); 
out.println("document.getElementById('check').value='反选';"); 
out.println("}"); 
out.println("}"); 
out.println("</script>");
}catch(Exception ex){
	ex.printStackTrace();
}
}
}