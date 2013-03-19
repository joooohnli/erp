/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import java.io.*;
import javax.servlet.http.*;
import include.tree_index.businessComment;

public class iisPrint {

private businessComment demo=new businessComment();
    
	public iisPrint(HttpServletRequest request){
		demo.setPath(request);	
	}

	public String  printOrNotTd(String file,HttpServletResponse response,String id,String tablename,String field_name){
		
		StringBuffer content=new StringBuffer();
		try{
           
			

			PrintWriter out=response.getWriter();
			if(!file.equals("")){
				
				
				content.append("<td bgcolor=\"#FFFFFF\" width=\"15%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>&nbsp;</td>");
			}else{
				
			content.append("<td  bgcolor=\"#FFFFFF\" width=\"15%\">&nbsp;</td>");
			
			
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return content.toString();
	}

	public String printOrNot(String file,String topic,HttpServletResponse response,String id,String tablename,String field_name){
		
                
           StringBuffer content=new StringBuffer();
           try{
                   
			PrintWriter out=response.getWriter();
			if(!file.equals("")){
				content.append("<tr>");
				content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"20%\"><font color=\"#000000\">");
				content.append(demo.getLang("erp",topic));
				content.append("</font>&nbsp;</td>");
				content.append("<td bgcolor=\"#FFFFFF\" width=\"80%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>&nbsp;</td>");
				content.append("</tr>");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return content.toString();
	}

	public String printOrNot7(String file,String topic,HttpServletResponse response,String id,String tablename,String field_name){
		
                
           StringBuffer content=new StringBuffer();
           try{
                   
			PrintWriter out=response.getWriter();
			if(!file.equals("")){
				content.append("<tr>");
				content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"11%\"><font color=\"#000000\">");
				content.append(demo.getLang("erp",topic));
				content.append("</font>&nbsp;</td>");
				content.append("<td colspan=\"7\" bgcolor=\"#FFFFFF\" width=\"86.5%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>&nbsp;</td>");
				content.append("</tr>");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return content.toString();
	}

	public String printOrNotSin(String file,HttpServletResponse response,String id,String tablename,String field_name){
		
           StringBuffer content=new StringBuffer();
           try{
           
			PrintWriter out=response.getWriter();
			if(!file.equals("")){
				content.append("<a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>");
			}else{
			
			content.append("&nbsp;");
			
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return content.toString();
	}

	public String printOrNotSin(String file,HttpServletResponse response,String main,String id,String tablename,String field_name){
		
           StringBuffer content=new StringBuffer();
           try{
           
			PrintWriter out=response.getWriter();
			if(!file.equals("")){
				content.append("<a href=\"javascript:winopenm('../../"+main+"/include/query.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>");
			}else{
			
			content.append("&nbsp;");
			
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return content.toString();
	}

	public String hasOrNot(String file,String topic,String name,HttpServletResponse response,String id,String tablename){
		
		StringBuffer content=new StringBuffer();
		
		try{
			
			
			
			PrintWriter out=response.getWriter();
			String field_name="attachment"+name;
			name="file"+name;
			if(!file.equals("")){
				content.append("<tr>");
				content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"20%\"><font color=\"#000000\">");
				content.append(demo.getLang("erp",topic));
				content.append("</font>&nbsp;</td>");
				content.append("<td bgcolor=\"#FFFFFF\" width=\"80%\"><input type=\"file\" name=\""+name+"\" width=\"100%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>&nbsp;<input type=\"checkbox\" name=\"attachment\" value=\""+field_name+"\">"+demo.getLang("erp","删除该附件")+"</td>");
				content.append("</tr>");
			}else{
				content.append("<tr>");
				content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"20%\"><font color=\"#000000\">");
				content.append(demo.getLang("erp",topic));
				content.append("</font>&nbsp;</td>");
				content.append("<td bgcolor=\"#FFFFFF\" width=\"80%\"><input type=\"file\" name=\""+name+"\" width=\"100%\"></td>");
				content.append("</tr>");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
				return content.toString();

	}

	public String hasOrNot8(String file,String topic,String name,HttpServletResponse response,String id,String tablename){
		
			StringBuffer content=new StringBuffer();
			
			try{
			PrintWriter out=response.getWriter();
			String field_name="attachment"+name;
			name="file"+name;
			if(!file.equals("")){
				content.append("<tr>");
				content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"20%\"><font color=\"#000000\">");
				content.append(demo.getLang("erp",topic));
				content.append("</font>&nbsp;</td>");
				content.append("<td colspan=\"8\" bgcolor=\"#FFFFFF\" width=\"80%\"><input type=\"file\" name=\""+name+"\" width=\"100%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>&nbsp;<input type=\"checkbox\" name=\"attachment\" value=\""+field_name+"\">"+demo.getLang("erp","删除该附件")+"</td>");
				content.append("</tr>");
			}else{
				content.append("<tr>");
				content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"20%\"><font color=\"#000000\">");
				content.append(demo.getLang("erp",topic));
				content.append("</font>&nbsp;</td>");
				content.append("<td colspan=\"8\" bgcolor=\"#FFFFFF\" width=\"80%\"><input type=\"file\" name=\""+name+"\" width=\"100%\"></td>");
				content.append("</tr>");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
				return content.toString();

	}

	public String hasOrNot7(String file,String topic,String name,HttpServletResponse response,String id,String file_style,String tablename){
		
			StringBuffer content=new StringBuffer();
			
			try{
			PrintWriter out=response.getWriter();
			String field_name="attachment"+name;
			name="file"+name;
			if(!file.equals("")){
				content.append("<tr>");
				content.append("<td align=\"right\" bgcolor=\"#FFFFFF\" width=\"11%\"><font color=\"#000000\">");
				content.append(demo.getLang("erp",topic));
				content.append("：</font>&nbsp;</td>");
				content.append("<td colspan=\"3\" bgcolor=\"#FFFFFF\" width=\"89%\"><input type=\"file\" name=\""+name+"\"" +file_style+" CLASS=\"FILE_STYLE1\" width=\"100%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>&nbsp;<input type=\"checkbox\" name=\"attachment\" value=\""+field_name+"\">"+demo.getLang("erp","删除该附件")+"</td>");
				content.append("</tr>");
			}else{
				content.append("<tr>");
				content.append("<td align=\"right\" bgcolor=\"#FFFFFF\" width=\"11%\"><font color=\"#000000\">");
				content.append(demo.getLang("erp",topic));
				content.append("：</font>&nbsp;</td>");
				content.append("<td colspan=\"3\" bgcolor=\"#FFFFFF\" width=\"89%\"><input type=\"file\" name=\""+name+"\"" +file_style+" CLASS=\"FILE_STYLE1\" width=\"100%\"></td>");
				content.append("</tr>");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}		
				return content.toString();

	}

}