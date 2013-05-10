package include;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

import include.get_name_from_ID.getNameFromID;
import include.nseer_cookie.BrowerVer;
import include.nseer_db.*;
import include.tree_index.BusFirst;
import include.tree_index.businessComment;
import include.nseer_cookie.TreeMiddle;

import java.io.*;
import include.tree_index.Nseer;


public class tree2 extends HttpServlet{
	

public void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
try{
	Nseer n=new Nseer();
HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
nseer_db nseerdb=new nseer_db((String)dbSession.getAttribute("unit_db_name"));
nseer_db db=new nseer_db((String)dbSession.getAttribute("unit_db_name"));

PrintWriter out=response.getWriter();
getNameFromID getNameFromID=new getNameFromID();
businessComment demo=new businessComment();
demo.setPath(request);

out.println("<script language=\"javascript\" src=\"javascript/winopen/winopen.js\"></script>");
out.println("<script type='text/javascript' src='dwr/engine.js'></script>");
out.println("<script type='text/javascript' src='dwr/util.js'></script>");
out.println("<script type='text/javascript' src='dwr/interface/NseerModuleTreeNode.js'></script>");
out.println("<script language=\"javascript\" src=\"javascript/include/nseer_cookie/toolTip.js\"></script>");

String mod=request.getParameter("mod");
String mod_c=request.getParameter("mod_c");
String human_ID=(String)session.getAttribute("human_IDD");
String main_code=request.getParameter("main_code");
out.println("<script>");
out.println("var nseer_alarm=new nseer_alarm();");
out.println("nseer_alarm.main_id='"+main_code+"';");
out.println("</script>");

out.println("<style type=\"text/css\">");
out.println("    body {");
out.println("        font-size: 12px;");
out.println("        font-family: verdana;");
out.println("        background-color: white;");
out.println("		 white-space:nowrap;");
out.println("		 background: #ffffff;");

out.println("      }");
out.println("      .root {	  ");
out.println("	  border-left: #E1E1E1 1px solid;");
out.println("	  border-right: #E1E1E1 1px solid;");
out.println("	  border-top: #fff 0px solid;");
out.println("	  border-bottom: #ffffff 1px solid;");
out.println("      padding: 0px 0px 0px 0px;");
out.println("	  background: transparent url(images/two.jpg) repeat-x 0 -15px;");
	 


out.println("      }");
out.println("	  .hrefdiv {	  ");
out.println("	  border-left: #E1E1E1 1px solid;");
out.println("	  border-right: #E1E1E1 1px solid;");
out.println("	  border-top: #fff 0px solid;");
out.println("	  border-bottom: #E1E1E1 1px solid;");
out.println("      }");
out.println("      A:visited {");
out.println("	  color:#000000;");
out.println("	  TEXT-DECORATION: none;");
out.println("	  }");
out.println("	  A:active {");
out.println("	  color:#000000;");
out.println("	  TEXT-DECORATION: none;");
out.println("	  }");
out.println("	  A:hover {");

out.println("	  TEXT-DECORATION: none;");
out.println("	  }");
out.println("	  A:link {");
out.println("	  color:#000000;");
out.println("	  TEXT-DECORATION: none;");
out.println("	  }");
out.println("      .root div {");
out.println("      padding: 0px 0px 0px 0px;");
out.println("      display: none;");
out.println("	  border-left: 1px solid #E1E1E1;");
out.println("      margin-left: 20px;");
out.println("	  margin-top: 1px;");
out.println("      }");
out.println("	  #main_cur {");
out.println("        color:#ffffff;       ");
out.println("       }");
	  
out.println("      </style>");


out.println("<script type=\"text/javascript\" language=\"JavaScript\">");
out.println("function toggleNode(node,id,tablename) ");
out.println("{");

out.println("var parent_HTML=node.innerHTML;");
out.println("var temp=parent_HTML.toLowerCase().indexOf('</a>');");
out.println("temp=parent_HTML.substring(0,temp+4);");
out.println("var div_num=node.getElementsByTagName('DIV');");
out.println("if(div_num.length>0){");
out.println("var nodeArray = node.childNodes;");
out.println("        for(i=0; i < nodeArray.length; i++)");
out.println("       {");
out.println("          node = nodeArray[i];");
out.println("        if (node.tagName && node.tagName.toLowerCase() == 'a'){");
			
out.println("         var img=node.getElementsByTagName('IMG');");
out.println("img[0].src = (img[0].src == img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'side.gif') ?img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'down.gif': img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'side.gif';");
out.println("		   node.style.color = (node.style.color == '#1D27F3') ? '#000000' : '#000000';");
out.println("        }");
out.println("        if (node.tagName && node.tagName.toLowerCase() == 'div'){");
out.println("        node.style.display = (node.style.display == 'block') ? 'none' : 'block';");
out.println("		}");
out.println("        }");

out.println("}else{");
out.println("DWREngine.setAsync(true);");
out.println("NseerModuleTreeNode.Category(id,tablename,{callback:function(msg){");
out.println("node.innerHTML=temp+msg;");
out.println("var nodeArray = node.childNodes;");
out.println("        for(i=0; i < nodeArray.length; i++)");
out.println("        {");
out.println("          node = nodeArray[i];");
out.println("		  if (node.tagName && node.tagName.toLowerCase() == 'a'){");
out.println("			  var img=node.getElementsByTagName('IMG');");
out.println("           img[0].src = img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'down.gif'; ");
out.println("		  node.style.color = (node.style.display == 'block') ? '#000000' : '#000000';");
out.println("       }");
out.println("          if (node.tagName && node.tagName.toLowerCase() == 'div'){");
out.println("            node.style.display = (node.style.display == 'block') ? 'none' : 'block';");
out.println("       }");
out.println("		}");
out.println("}});");
out.println("DWREngine.setAsync(true);");
out.println("}}");

out.println("var nowli;");
out.println("function changeColor(obj,path){");
out.println("window.status=\"科技强医 \"");
out.println("obj.href=path");
out.println("obj.target=\"content\"");

out.println("if(nowli!=null)");
out.println("{	 ");
out.println("nowli.id = \"\";	");
out.println("nowli.parentNode.style.background='#ffffff';");
out.println("var span1=nowli.parentNode.getElementsByTagName('span');");
out.println("span1[0].style.visibility = \"visible\";");
out.println("}");
//obj.style.color='red';
out.println("obj.id = \"main_cur\";");
out.println("obj.parentNode.style.background='#FFA54A';");
out.println("var span=obj.parentNode.getElementsByTagName('span');");
out.println("span[0].style.visibility = \"hidden\";");

out.println("nowli = obj;");

out.println("}");

out.println("</script>");

out.println("<body>");
out.println("<div style=\"position:absolute;top:0px;left:0px\" id=\"root1\">");
out.println("<div style=\"height:23px;background-image:url(images/tree/alarm.gif);width:100%;color:#9DD337;text-align:left;border-bottom: #ffffff 2px solid;font-size: 14px;padding:1px 0px 0px 0px;\"><span id=\"flashtitle\" style=\"padding:0px 0px 0px 5px;\"></span><span  style=\"padding:0px 0px 0px 5px;\">");
	
int v=0;

BrowerVer browercheck=new  BrowerVer();

String strhead = request.getHeader("User-Agent");
		if(strhead.indexOf(browercheck.IE)==-1){


String userName=(String)session.getAttribute("realeditorc");


if (mod.equals("crm")){

double contact_period_limit1=0;
double contact_period_limit2=0;
double contact_period_limit3=0;
	int intRowCount1 = 0;
	int intRowCount2 = 0;
	int intRowCount3 = 0;
	String sql1="select * from crm_config_public_double where kind='联络红警'";
	ResultSet rs11=db.executeQuery(sql1) ;
	if(rs11.next()){
		contact_period_limit1=rs11.getDouble("type_value");
	}
	String sql2="select * from crm_config_public_double where kind='联络橙警'";
	ResultSet rs2=db.executeQuery(sql2) ;
	if(rs2.next()){
		contact_period_limit2=rs2.getDouble("type_value");
	}
	String sql3="select * from crm_config_public_double where kind='联络黄警'";
	ResultSet rs3=db.executeQuery(sql3) ;
	if(rs3.next()){
		contact_period_limit3=rs3.getDouble("type_value");
	}
	String sql4="select count(*) from crm_alarm_contact_expiry where period_expiry_over>='"+contact_period_limit1+"'";
	ResultSet rs4=db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
	String sql5="select count(*) from crm_alarm_contact_expiry where period_expiry_over>='"+contact_period_limit2+"' and period_expiry_over<'"+contact_period_limit1+"'";
	ResultSet rs5=db.executeQuery(sql5) ;
	if(rs5.next()){
		intRowCount2=rs5.getInt("count(*)");
	}
	String sql6="select count(*) from crm_alarm_contact_expiry where period_expiry_over>='"+contact_period_limit3+"' and period_expiry_over<'"+contact_period_limit2+"'";
	ResultSet rs6=db.executeQuery(sql6) ;
	if(rs6.next()){
		intRowCount3=rs6.getInt("count(*)");
	}
String sqll2="select * from crm_view where human_ID='"+human_ID+"' and file_name='"+"客户联络延期报警督办"+"'";
ResultSet rss2=db.executeQuery(sqll2);

if(rss2.next()){
	if(intRowCount1!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/red1.swf\">");
 out.println(" <param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/red.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");
}else if(intRowCount2!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/orange1.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/orange.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");
}else if(intRowCount3!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/orchid1.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/orchid.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");
}else{
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/green.swf\">");
 out.println(" <param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

	}
}

	double gather_period_limit1=0;
	double gather_period_limit2=0;
	double gather_period_limit3=0;
	intRowCount1 = 0;
	intRowCount2 = 0;
	intRowCount3 = 0;
	sql1="select * from crm_config_public_double where kind='回款红警'";
	rs11=db.executeQuery(sql1) ;
	if(rs11.next()){
		gather_period_limit1=rs11.getDouble("type_value");
	}
	sql2="select * from crm_config_public_double where kind='回款橙警'";
	rs2=db.executeQuery(sql2) ;
	if(rs2.next()){
		gather_period_limit2=rs2.getDouble("type_value");
	}
	sql3="select * from crm_config_public_double where kind='回款黄警'";
	rs3=db.executeQuery(sql3) ;
	if(rs3.next()){
		gather_period_limit3=rs3.getDouble("type_value");
	}
	sql4="select count(*) from crm_alarm_gather_expiry where period_expiry_over>='"+gather_period_limit1+"'";
	rs4=db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
	sql5="select count(*) from crm_alarm_gather_expiry where period_expiry_over>='"+gather_period_limit2+"' and period_expiry_over<'"+gather_period_limit1+"'";
	rs5=db.executeQuery(sql5) ;
	if(rs5.next()){
		intRowCount2=rs5.getInt("count(*)");
	}
	sql6="select count(*) from crm_alarm_gather_expiry where period_expiry_over>='"+gather_period_limit3+"' and period_expiry_over<'"+gather_period_limit2+"'";
	rs6=db.executeQuery(sql6) ;
	if(rs6.next()){
		intRowCount3=rs6.getInt("count(*)");
	}
String sqll1="select * from crm_view where human_ID='"+human_ID+"' and file_name='"+"客户回款超期报警督办"+"'";
ResultSet rss1=db.executeQuery(sqll1);
if(rss1.next()){
	if(intRowCount1!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/red2.swf\">");
 out.println(" <param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/red.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");
}else if(intRowCount2!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/orange2.swf\">");
 out.println(" <param name=\"quality\" value=\"high\">");
 out.println(" <embed src=\"images/orange.swf\" quality=\"high\""); out.println("pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");
}else if(intRowCount3!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/orchid2.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/orchid.swf\" quality=\"high\""); out.println("pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");
}else{
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/green.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

	}
}
	double gather_sum_limit1=0.0d;
	double gather_sum_limit2=0.0d;
	double gather_sum_limit3=0.0d;
	intRowCount1 = 0;
	intRowCount2 = 0;
	intRowCount3 = 0;
	sql1="select * from crm_config_public_double where kind='欠款红警'";
	rs11=db.executeQuery(sql1) ;
	if(rs11.next()){
		gather_sum_limit1=rs11.getDouble("type_value");
	}
	sql2="select * from crm_config_public_double where kind='欠款橙警'";
	rs2=db.executeQuery(sql2) ;
	if(rs2.next()){
		gather_sum_limit2=rs2.getDouble("type_value");
	}
	sql3="select * from crm_config_public_double where kind='欠款黄警'";
	rs3=db.executeQuery(sql3) ;
	if(rs3.next()){
		gather_sum_limit3=rs3.getDouble("type_value");
	}
	sql4="select count(*) from crm_alarm_gather_sum_limit where sum_absent_over>='"+gather_sum_limit1+"'";
	rs4=db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
	sql5="select count(*) from crm_alarm_gather_sum_limit where sum_absent_over>='"+gather_sum_limit2+"' and sum_absent_over<'"+gather_sum_limit1+"'";
	rs5=db.executeQuery(sql5) ;
	if(rs5.next()){
		intRowCount2=rs5.getInt("count(*)");
	}
	sql6="select count(*) from crm_alarm_gather_sum_limit where sum_absent_over>='"+gather_sum_limit3+"' and sum_absent_over<'"+gather_sum_limit2+"'";
	rs6=db.executeQuery(sql6) ;
	if(rs6.next()){
		intRowCount3=rs6.getInt("count(*)");
	}
String sqll3="select * from crm_view where human_ID='"+human_ID+"' and file_name='"+"客户欠款超额报警督办"+"'";
ResultSet rss3=db.executeQuery(sqll3);
if(rss3.next()){
	if(intRowCount1!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/red3.swf\">");
 out.println("<param name=\"quality\" value=\"high\">");
 out.println("<embed src=\"images/red.swf\" quality=\"high\""); out.println("pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");
}else if(intRowCount2!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/orange3.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println(" <embed src=\"images/orange.swf\" quality=\"high\""); out.println("pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"4\" height=\"8\"></embed>");
out.println("</object>");
}else if(intRowCount3!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/orchid3.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/orchid.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\"type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");
}else{
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
out.println("<param name=\"movie\" value=\"images/green.swf\">");
out.println("<param name=\"quality\" value=\"high\">");
out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

	}
}


}

if(mod.equals("design")){
	int intRowCount1 = 0;
	String sql4="select count(*) from design_file where price_alarm_tag='1'";
	ResultSet rs4=db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
String sqll2="select * from design_view where human_ID='"+human_ID+"' and file_name='"+"产品价格调整管理"+"'";
ResultSet rss2=db.executeQuery(sqll2);
if(rss2.next()){
	if(intRowCount1!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/re1.swf\">");
 out.println("<param name=\"quality\" value=\"high\">");
 out.println("<embed src=\"images/red.swf\" quality=\"high\""); out.println("pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

	}else{
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/green.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

}
}


}
if(mod.equals("stock")){
int qq=0;
int q=0;
double max_amount=0.0d;
double min_amount=0.0d;

String sql3="select * from stock_balance";
ResultSet rs3=nseerdb.executeQuery(sql3);
while(rs3.next()){
	String sql2="select * from stock_cell where product_ID='"+rs3.getString("product_ID")+"'";
ResultSet rs2=db.executeQuery(sql2);
if(rs2.next()){
	max_amount=rs2.getDouble("max_amount");
	min_amount=rs2.getDouble("min_amount");
}
	if(rs3.getDouble("amount")>max_amount){
	qq++;
	}
	if(rs3.getDouble("amount")<min_amount){
	q++;
	}
}
String sqll2="select * from stock_view where human_ID='"+human_ID+"' and file_name='动态库存查询'";
ResultSet rss2=db.executeQuery(sqll2);
if(rss2.next()){
	if(qq!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/re2.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/red.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

	}else{
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/green.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

}
	if(q!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/or1.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/orange.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

	}else{
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/green.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

}
}


}

		}else{




String userName=(String)session.getAttribute("realeditorc");
if (mod.equals("crm")){

double contact_period_limit1=0;
	double contact_period_limit2=0;
	double contact_period_limit3=0;
	int intRowCount1 = 0;
	int intRowCount2 = 0;
	int intRowCount3 = 0;
	String sql1="select * from crm_config_public_double where kind='联络红警'";
	ResultSet rs11=db.executeQuery(sql1) ;
	if(rs11.next()){
		contact_period_limit1=rs11.getDouble("type_value");
	}
	String sql2="select * from crm_config_public_double where kind='联络橙警'";
	ResultSet rs2=db.executeQuery(sql2) ;
	if(rs2.next()){
		contact_period_limit2=rs2.getDouble("type_value");
	}
	String sql3="select * from crm_config_public_double where kind='联络黄警'";
	ResultSet rs3=db.executeQuery(sql3) ;
	if(rs3.next()){
		contact_period_limit3=rs3.getDouble("type_value");
	}
	String sql4="select count(*) from crm_alarm_contact_expiry where period_expiry_over>='"+contact_period_limit1+"'";
	ResultSet rs4=db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
	String sql5="select count(*) from crm_alarm_contact_expiry where period_expiry_over>='"+contact_period_limit2+"' and period_expiry_over<'"+contact_period_limit1+"'";
	ResultSet rs5=db.executeQuery(sql5) ;
	if(rs5.next()){
		intRowCount2=rs5.getInt("count(*)");
	}
	String sql6="select count(*) from crm_alarm_contact_expiry where period_expiry_over>='"+contact_period_limit3+"' and period_expiry_over<'"+contact_period_limit2+"'";
	ResultSet rs6=db.executeQuery(sql6) ;
	if(rs6.next()){
		intRowCount3=rs6.getInt("count(*)");
	}
String sqll2="select * from crm_view where human_ID='"+human_ID+"' and file_name='"+"客户联络延期报警督办"+"'";
ResultSet rss2=db.executeQuery(sqll2);
if(rss2.next()){
	if(intRowCount1!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/red1.swf\">");
 out.println(" <param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/red.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>&nbsp;");
}else if(intRowCount2!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/orange1.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/orange.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>&nbsp;");
}else if(intRowCount3!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/orchid1.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/orchid.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>&nbsp;");
}else{
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/green.swf\">");
 out.println(" <param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>&nbsp;");

	}
}
	double gather_period_limit1=0;
	double gather_period_limit2=0;
	double gather_period_limit3=0;
	intRowCount1 = 0;
	intRowCount2 = 0;
	intRowCount3 = 0;
	sql1="select * from crm_config_public_double where kind='回款红警'";
	rs11=db.executeQuery(sql1) ;
	if(rs11.next()){
		gather_period_limit1=rs11.getDouble("type_value");
	}
	sql2="select * from crm_config_public_double where kind='回款橙警'";
	rs2=db.executeQuery(sql2) ;
	if(rs2.next()){
		gather_period_limit2=rs2.getDouble("type_value");
	}
	sql3="select * from crm_config_public_double where kind='回款黄警'";
	rs3=db.executeQuery(sql3) ;
	if(rs3.next()){
		gather_period_limit3=rs3.getDouble("type_value");
	}
	sql4="select count(*) from crm_alarm_gather_expiry where period_expiry_over>='"+gather_period_limit1+"'";
	rs4=db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
	sql5="select count(*) from crm_alarm_gather_expiry where period_expiry_over>='"+gather_period_limit2+"' and period_expiry_over<'"+gather_period_limit1+"'";
	rs5=db.executeQuery(sql5) ;
	if(rs5.next()){
		intRowCount2=rs5.getInt("count(*)");
	}
	sql6="select count(*) from crm_alarm_gather_expiry where period_expiry_over>='"+gather_period_limit3+"' and period_expiry_over<'"+gather_period_limit2+"'";
	rs6=db.executeQuery(sql6) ;
	if(rs6.next()){
		intRowCount3=rs6.getInt("count(*)");
	}
String sqll1="select * from crm_view where human_ID='"+human_ID+"' and file_name='"+"客户回款超期报警督办"+"'";
ResultSet rss1=db.executeQuery(sqll1);
if(rss1.next()){
	if(intRowCount1!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/red2.swf\">");
 out.println(" <param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/red.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>&nbsp;");
}else if(intRowCount2!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/orange2.swf\">");
 out.println(" <param name=\"quality\" value=\"high\">");
 out.println(" <embed src=\"images/orange.swf\" quality=\"high\""); out.println("pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>&nbsp;");
}else if(intRowCount3!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/orchid2.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/orchid.swf\" quality=\"high\""); out.println("pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>&nbsp;");
}else{
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/green.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>&nbsp;");

	}
}
	double gather_sum_limit1=0.0d;
	double gather_sum_limit2=0.0d;
	double gather_sum_limit3=0.0d;
	intRowCount1 = 0;
	intRowCount2 = 0;
	intRowCount3 = 0;
	sql1="select * from crm_config_public_double where kind='欠款红警'";
	rs11=db.executeQuery(sql1) ;
	if(rs11.next()){
		gather_sum_limit1=rs11.getDouble("type_value");
	}
	sql2="select * from crm_config_public_double where kind='欠款橙警'";
	rs2=db.executeQuery(sql2) ;
	if(rs2.next()){
		gather_sum_limit2=rs2.getDouble("type_value");
	}
	sql3="select * from crm_config_public_double where kind='欠款黄警'";
	rs3=db.executeQuery(sql3) ;
	if(rs3.next()){
		gather_sum_limit3=rs3.getDouble("type_value");
	}
	sql4="select count(*) from crm_alarm_gather_sum_limit where sum_absent_over>='"+gather_sum_limit1+"'";
	rs4=db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
	sql5="select count(*) from crm_alarm_gather_sum_limit where sum_absent_over>='"+gather_sum_limit2+"' and sum_absent_over<'"+gather_sum_limit1+"'";
	rs5=db.executeQuery(sql5) ;
	if(rs5.next()){
		intRowCount2=rs5.getInt("count(*)");
	}
	sql6="select count(*) from crm_alarm_gather_sum_limit where sum_absent_over>='"+gather_sum_limit3+"' and sum_absent_over<'"+gather_sum_limit2+"'";
	rs6=db.executeQuery(sql6) ;
	if(rs6.next()){
		intRowCount3=rs6.getInt("count(*)");
	}
String sqll3="select * from crm_view where human_ID='"+human_ID+"' and file_name='"+"客户欠款超额报警督办"+"'";
ResultSet rss3=db.executeQuery(sqll3);
if(rss3.next()){
	if(intRowCount1!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
 out.println(" <param name=\"movie\" value=\"images/red3.swf\">");
 out.println("<param name=\"quality\" value=\"high\">");
 out.println("<embed src=\"images/red.swf\" quality=\"high\""); out.println("pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>&nbsp;");
}else if(intRowCount2!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/orange3.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println(" <embed src=\"images/orange.swf\" quality=\"high\""); out.println("pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"4\" height=\"8\"></embed>");
out.println("</object>&nbsp;");
}else if(intRowCount3!=0){
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/orchid3.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/orchid.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\"type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>&nbsp;");
}else{
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/green.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

	}
}


}

if(mod.equals("design")){
	int intRowCount1 = 0;
	String sql4="select count(*) from design_file where price_alarm_tag='1'";
	ResultSet rs4=db.executeQuery(sql4) ;
	if(rs4.next()){
		intRowCount1=rs4.getInt("count(*)");
	}
String sqll2="select * from design_view where human_ID='"+human_ID+"' and file_name='"+"产品价格调整管理"+"'";
ResultSet rss2=db.executeQuery(sqll2);
if(rss2.next()){
	if(intRowCount1!=0){
v++;
		out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
		 out.println(" <param name=\"movie\" value=\"images/re1.swf\">");
		 out.println(" <param name=\"quality\" value=\"high\">");
		  out.println("<embed src=\"images/red.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
		out.println("</object>&nbsp;");

	}else{
v++;
out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
  out.println("<param name=\"movie\" value=\"images/green.swf\">");
  out.println("<param name=\"quality\" value=\"high\">");
  out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
out.println("</object>");

}
}


}
				if (mod.equals("stock")) {
					int qq = 0;
					int q = 0;
					double max_amount = 0.0d;
					double min_amount = 0.0d;

					String sql3 = "select * from stock_balance";
					ResultSet rs3 = nseerdb.executeQuery(sql3);
					while (rs3.next()) {
						String sql2 = "select * from stock_cell where product_ID='"
								+ rs3.getString("product_ID") + "'";
						ResultSet rs2 = db.executeQuery(sql2);
						if (rs2.next()) {
							max_amount = rs2.getDouble("max_amount");
							min_amount = rs2.getDouble("min_amount");
						}
						if (rs3.getDouble("amount") > max_amount) {
							qq++;
						}
						if (rs3.getDouble("amount") < min_amount) {
							q++;
						}
					}
					String sqll2 = "select * from stock_view where human_ID='"
							+ human_ID + "' and file_name='" + "动态库存查询" + "'";
					ResultSet rss2 = db.executeQuery(sqll2);
					if (rss2.next()) {
						if (qq != 0) {
							v++;
							out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
							out.println("<param name=\"movie\" value=\"images/re2.swf\">");
							out.println("<param name=\"quality\" value=\"high\">");
							out.println("<embed src=\"images/red.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
							out.println("</object>&nbsp;");

						} else {
							v++;
							out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
							out.println("<param name=\"movie\" value=\"images/green.swf\">");
							out.println("<param name=\"quality\" value=\"high\">");
							out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
							out.println("</object>&nbsp;");

						}
						if (q != 0) {
							v++;
							out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
							out.println(" <param name=\"movie\" value=\"images/or1.swf\">");
							out.println("<param name=\"quality\" value=\"high\">");
							out.println("<embed src=\"images/orange.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
							out.println("</object>&nbsp;");

						} else {
							v++;
							out.println("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"6\" height=\"10\">");
							out.println("<param name=\"movie\" value=\"images/green.swf\">");
							out.println("<param name=\"quality\" value=\"high\">");
							out.println("<embed src=\"images/green.swf\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"6\" height=\"10\"></embed>");
							out.println("</object>");

						}
					}

				}

		}


out.println("</span></div>");

String sql1 = "select category_id,file_name from "+mod+"_view where PARENT_CATEGORY_ID='0' and human_id='"+(String)session.getAttribute("human_IDD")+"'";
ResultSet rs =db.executeQuery(sql1);
while(rs.next()){

out.println("<div class=\"root\"><a href=\"javascript:void(0)\"  onclick=\"toggleNode(this.parentNode,'"+rs.getString("category_id")+"','"+mod+"'); return false;\" style=\"background-image:url(images/tree/l.gif);width:100%;\" onfocus=\"this.blur()\"><span style=\"padding:0px 0px 0px 3px\"><img src=\"images/side.gif\" align=\"absmiddle\" style=\"border: 0;\" ></span><span style=\"padding:0px 0px 0px 8px\">"+rs.getString("file_name")+"</span></a></div>");

}
db.close();
TreeMiddle.wr(out);
out.println("</div>");
out.println("</body>");
out.println("<script>");
out.println("window.onload=function (){");
out.println("window.status=\"科技强医 \"");
out.println("document.getElementById('root1').style.width=document.body.clientWidth+'px';");
out.println("}");
out.println("window.onresize=function (){");
out.println("document.getElementById('root1').style.width=document.body.clientWidth+'px';");
out.println("}");
out.println("</script>");
}catch(Exception ex){
	ex.printStackTrace();
}
}
}
