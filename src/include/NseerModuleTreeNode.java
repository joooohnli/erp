package include;

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
import include.tree_index.Nseer;

public class NseerModuleTreeNode{

WebContext ctx = WebContextFactory.get();
HttpSession session = ctx.getSession();
HttpServletRequest request=ctx.getHttpServletRequest();

public NseerModuleTreeNode() {
}


public String Category(String categoryId,String tablename) {

ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
path=path.substring(0,path.length()-1);
int index=path.lastIndexOf("\\");
path=path.substring(index+1,path.length());
Nseer n=new Nseer();
nseer_db db=new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db1=new nseer_db((String)session.getAttribute("unit_db_name"));
	
String return_msg="";

try{

String sql="select * from "+tablename+"_view where PARENT_CATEGORY_ID='"+categoryId+"' and human_ID='"+(String)session.getAttribute("human_IDD")+"' and workflow_tag='0'";
			
ResultSet rs =db.executeQuery(sql);

while(rs.next()){
/**************************/

if(rs.getInt("DETAILS_TAG")==1){

return_msg+="<div style=\"background: transparent url(/"+path+"/images/tree/l.gif) repeat-x 0 -15px;\"><a href=\"javascript:void(0)\" style=\"background-image:url(/"+path+"/images/tree/l.gif);width:100%;\" onMouseOver=\"window.status='科技强医'; return true\" onclick=\"toggleNode(this.parentNode,'"+rs.getString("CATEGORY_ID")+"','"+tablename+"'); return false;\"  onfocus=\"this.blur()\"><span style=\"padding:0px 0px 0px 3px\"><img src=\"/"+path+"/images/side.gif\" align=\"absmiddle\" style=\"border: 0;\" ></span><span style=\"padding:0px 0px 0px 8px\">"+rs.getString("file_name")+"</span></a></div>";

}else{
if(!rs.getString("hreflink").equals("")){
return_msg+="<div style=\"background:#ffffff;width:100%\" class=\"hrefdiv\"><span style=\"padding:0px 0px 0px 3px\"><img src=\"/"+path+"/images/tree/2.gif\" align=\"absmiddle\" style=\"border: 0;\" ></span><span style=\"padding:0px 0px 0px 8px\"></span><A HREF=\"javascript:void(0);\" onmousedown=\"window.status='科技强医';this.href='javascript:void(0)';\" onmouseover=\"window.status='科技强医';this.href='javascript:void(0)'; return true\" onclick=\"changeColor(this,'/"+path+"/"+rs.getString("file_path")+rs.getString("hreflink")+"?readXml=n')\" onfocus=\"this.blur()\" >"+rs.getString("file_name")+"</A></div>";
}else{

return_msg+="<div style=\"background:#DDEAF6;width:100%\"><span style=\"padding:0px 0px 0px 3px\"><img src=\"/"+path+"/images/bean.JPG\" align=\"absmiddle\" style=\"border: 0;\" ></span><span style=\"padding:0px 0px 0px 8px\"></span>"+rs.getString("file_name")+"</div>";


}

/*********************************/

}
}
db.close();

}catch(Exception ex){ex.printStackTrace();}
  return return_msg;
}

}
