package include.nseer_cookie;

import java.io.*;
import java.util.*;
import java.text.*;
import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;
import include.nseer_db.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;

public class ShortModuleTreeNode{

WebContext ctx = WebContextFactory.get();
HttpSession session = ctx.getSession();


public ShortModuleTreeNode() {
}


public String Category(String categoryId,String tablename,String id) {
	nseer_db db=new nseer_db((String)session.getAttribute("unit_db_name"));
	nseer_db db1=new nseer_db((String)session.getAttribute("unit_db_name"));
	
String return_msg="";

try{

String sql="select * from "+tablename+"_view where PARENT_CATEGORY_ID='"+categoryId+"' and human_ID='"+(String)session.getAttribute("human_IDD")+"' and workflow_tag='0'";			
ResultSet rs =db.executeQuery(sql);
while(rs.next()){
if(rs.getInt("DETAILS_TAG")==1){

return_msg+="<div style=\"background: transparent url(images/two.jpg) repeat-x 0 -15px;\"><a href=\"javascript:void(0)\" style=\"background-image:url(/erp/images/two.jpg);width:100%\" onclick=\"toggleNode(this.parentNode,'"+rs.getString("CATEGORY_ID")+"','"+tablename+"'); return false;\"  ><span style=\"padding:0px 0px 0px 3px\"><img src=\"/erp/images/tree_icon_folder_close.gif\" align=\"absmiddle\" style=\"border: 0;\" ></span><span style=\"padding:0px 0px 0px 8px\">"+rs.getString("FILE_NAME")+"</span></a></div>";
}else{
if(!rs.getString("HREFLINK").equals("")){
String firstworkname=rs.getString("FILE_PATH")+rs.getString("HREFLINK");
String sql1="select * from drag_img where id='"+id+"'";
ResultSet rs1 =db1.executeQuery(sql1);
String checked="";
if(rs1.next()){
if(rs1.getString("firstworkname").equals(firstworkname)){
checked="checked";
}
}
return_msg+="<div style=\"background:#DDEAF6;width:100%\"><span style=\"padding:0px 0px 0px 8px\"></span><input type=\"radio\" name=\"firstwork_radio\" value="+rs.getString("FILE_PATH")+rs.getString("HREFLINK")+" "+checked+">"+rs.getString("FILE_NAME")+"</div>";
}else{
return_msg+="<div style=\"background:#DDEAF6;width:100%\"><span style=\"padding:0px 0px 0px 8px\"></span><input type=\"radio\" name=\"firstwork_radio\" value="+rs.getString("FILE_PATH")+rs.getString("HREFLINK")+">"+rs.getString("FILE_NAME")+"</div>";
}

}
}
db.close();
db1.close();

}catch(Exception ex){ex.printStackTrace();}
  return return_msg;
}

}
