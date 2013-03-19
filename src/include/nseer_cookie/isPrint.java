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

import include.tree_index.businessComment;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class isPrint
{

    private businessComment demo;

    public isPrint(HttpServletRequest request)
    {
        demo = new businessComment();
        demo.setPath(request);
    }

    public String printOrNotTd(String file, HttpServletResponse response,String id,String tablename,String field_name)
    {
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            if(!file.equals(""))
            {
                content.append("<td bgcolor=\"#FFFFFF\" width=\"15%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>&nbsp;</td>");
            } else
            {
                content.append("<td  bgcolor=\"#FFFFFF\" width=\"15%\">&nbsp;</td>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

    public String printOrNot(String file, String topic, HttpServletResponse response,String id,String tablename,String field_name)
    {
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            if(!file.equals(""))
            {
                content.append("<tr>");
                content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"20%\"><font color=\"#000000\">");
                content.append(demo.getLang("erp", topic));
                content.append("</font>&nbsp;</td>");
                content.append("<td bgcolor=\"#FFFFFF\" width=\"80%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>&nbsp;</td>");
                content.append("</tr>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

    public String printOrNot7(String file, String topic, HttpServletResponse response,String id,String tablename,String field_name)
    {
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            if(!file.equals(""))
            {
                content.append("<tr>");
                content.append("<td valign=\"top\" bgcolor=\"#FFFFFF\" width=\"11%\"><font color=\"#000000\">");
                content.append(demo.getLang("erp", topic));
                content.append("</font>&nbsp;</td>");
                content.append("<td colspan=\"7\" bgcolor=\"#FFFFFF\" width=\"86.5%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>&nbsp;</td>");
                content.append("</tr>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

    public String printOrNotSin(String file, HttpServletResponse response,String id,String tablename,String field_name)
    {
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            if(!file.equals(""))
            {
                content.append("<a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>");
            } else
            {
                content.append("&nbsp;");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

    public String hasOrNot(String file, String topic, String name, HttpServletResponse response, String td_style11, String td_style21,String id,String tablename)
    {
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            String field_name = "attachment" + name;
            name = "file" + name;
            if(!file.equals(""))
            {
                content.append("<td " + td_style11 + " CLASS=\"STYLE1\" width=\"11%\"><font color=\"#000000\">");
                content.append(demo.getLang("erp", topic));
                content.append("</font>&nbsp;</td>");
                content.append("<td " + td_style21 + " CLASS=\"STYLE2\" width=\"13%\"><input type=\"file\" name=\"" + name + "\" width=\"100%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>&nbsp;<input type=\"checkbox\" name=\"attachment\" value=\"" + field_name + "\">" + demo.getLang("erp", "删除该附件") + "</td>");
            } else
            {
                content.append("<td " + td_style11 + " CLASS=\"STYLE1\" width=\"11%\"><font color=\"#000000\">");
                content.append(demo.getLang("erp", topic));
                content.append("</font>&nbsp;</td>");
                content.append("<td " + td_style21 + " CLASS=\"STYLE2\" width=\"13%\"><input type=\"file\" name=\"" + name + "\" width=\"100%\"></td>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

    public String hasOrNot8(String file, String topic, String name, HttpServletResponse response,String id,String tablename)
    {
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            String field_name = "attachment" + name;
            name = "file" + name;
            if(!file.equals(""))
            {
                content.append("<tr>");
                content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"20%\"><font color=\"#000000\">");
                content.append(demo.getLang("erp", topic));
                content.append("</font>&nbsp;</td>");
                content.append("<td colspan=\"8\" bgcolor=\"#FFFFFF\" width=\"80%\"><input type=\"file\" name=\"" + name + "\" width=\"100%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>&nbsp;<input type=\"checkbox\" name=\"attachment\" value=\"" + field_name + "\">" + demo.getLang("erp", "删除该附件") + "</td>");
                content.append("</tr>");
            } else
            {
                content.append("<tr>");
                content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"20%\"><font color=\"#000000\">");
                content.append(demo.getLang("erp", topic));
                content.append("</font>&nbsp;</td>");
                content.append("<td colspan=\"8\" bgcolor=\"#FFFFFF\" width=\"80%\"><input type=\"file\" name=\"" + name + "\" width=\"100%\"></td>");
                content.append("</tr>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

    public String hasOrNot7(String file, String topic, String name, HttpServletResponse response,String id,String tablename)
    {
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            String field_name = "attachment" + name;
            name = "file" + name;
            if(!file.equals(""))
            {
                content.append("<tr>");
                content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"11%\"><font color=\"#000000\">");
                content.append(demo.getLang("erp", topic));
                content.append("</font>&nbsp;</td>");
                content.append("<td colspan=\"7\" bgcolor=\"#FFFFFF\" width=\"86.5%\"><input type=\"file\" name=\"" + name + "\" width=\"100%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>&nbsp;<input type=\"checkbox\" name=\"attachment\" value=\"" + field_name + "\">" + demo.getLang("erp", "删除该附件") + "</td>");
                content.append("</tr>");
            } else
            {
                content.append("<tr>");
                content.append("<td valign=\"top\" bgcolor=\"#CCCCCC\" width=\"11%\"><font color=\"#000000\">");
                content.append(demo.getLang("erp", topic));
                content.append("</font>&nbsp;</td>");
                content.append("<td colspan=\"7\" bgcolor=\"#FFFFFF\" width=\"86.5%\"><input type=\"file\" name=\"" + name + "\" width=\"100%\"></td>");
                content.append("</tr>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

	public String hasOrNot3(String file,String topic,String name,HttpServletResponse response,String tr_style,String td_style1,String td_style2,String id,String tablename){
		StringBuffer content=new  StringBuffer();
		try{
			java.io.PrintWriter out=response.getWriter();
			String field_name="attachment"+name;
			name="file"+name;
			if(!file.equals("")){
				content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
				content.append("<td " + td_style1 + " CLASS=\"TD_STYLE8\">");
				content.append(demo.getLang("erp",topic)+"：");
				content.append("</td>");
				content.append("<td colspan=\"3\"" + td_style2 + " CLASS=\"TD_STYLE2\"><input type=\"file\" name=\""+name+"\" width=\"100%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>&nbsp;<input type=\"checkbox\" name=\"attachment\" value=\""+field_name+"\">删除该附件</td>");
				content.append("</tr>");
			}else{
				content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
				content.append("<td " + td_style1 + " CLASS=\"TD_STYLE8\">");
				content.append(demo.getLang("erp",topic)+"：");
				content.append("</td>");
				content.append("<td colspan=\"3\"" + td_style2 + " CLASS=\"TD_STYLE2\" width=\"87%\"><input type=\"file\" name=\""+name+"\" width=\"100%\"></td>");
				content.append("</tr>");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
						return content.toString();

	}

	public String hasOrNot33(String file,String topic,String name,HttpServletResponse response,String tr_style,String td_style1,String td_style2,String id,String tablename){
		StringBuffer content=new  StringBuffer();
		try{
			java.io.PrintWriter out=response.getWriter();
			String field_name="attachment"+name;
			name="file"+name;
			if(!file.equals("")){
				content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
				content.append("<td " + td_style1 + " CLASS=\"TD_STYLE1\">");
				content.append(demo.getLang("erp",topic));
				content.append("</td>");
				content.append("<td colspan=\"3\"" + td_style2 + " CLASS=\"TD_STYLE2\"><input type=\"file\" name=\""+name+"\" width=\"100%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>&nbsp;<input type=\"checkbox\" name=\"attachment\" value=\""+field_name+"\">删除该附件</td>");
				content.append("</tr>");
			}else{
				content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
				content.append("<td " + td_style1 + " CLASS=\"TD_STYLE1\">");
				content.append(demo.getLang("erp",topic));
				content.append("</td>");
				content.append("<td colspan=\"3\"" + td_style2 + " CLASS=\"TD_STYLE2\" width=\"87%\"><input type=\"file\" name=\""+name+"\" width=\"100%\"></td>");
				content.append("</tr>");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
						return content.toString();

	}

	public String hasOrNot77(String file,String topic,String name,HttpServletResponse response,String tr_style,String td_style1,String td_style2,String id,String tablename){
		StringBuffer content=new  StringBuffer();
		try{
			java.io.PrintWriter out=response.getWriter();
			String field_name="attachment"+name;
			name="file"+name;
			if(!file.equals("")){
				content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
				content.append("<td " + td_style1 + " CLASS=\"TD_STYLE1\">");
				content.append(demo.getLang("erp",topic));
				content.append("：</td>");
				content.append("<td colspan=\"7\"" + td_style2 + " CLASS=\"TD_STYLE2\"><input type=\"file\" name=\""+name+"\" width=\"100%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
				content.append("')\"><font color=\"#3333FF\">");
				content.append(file.substring(10));
				content.append("</font></a>&nbsp;<input type=\"checkbox\" name=\"attachment\" value=\""+field_name+"\">删除该附件</td>");
				content.append("</tr>");
			}else{
				content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
				content.append("<td " + td_style1 + " CLASS=\"TD_STYLE1\">");
				content.append(demo.getLang("erp",topic));
				content.append("：</td>");
				content.append("<td colspan=\"7\"" + td_style2 + " CLASS=\"TD_STYLE2\" width=\"87%\"><input type=\"file\" name=\""+name+"\" width=\"100%\"></td>");
				content.append("</tr>");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
						return content.toString();

	}

	public String hasOrNot3d(String file, String topic, String name, HttpServletResponse response,String tr_style,String td_style1,String td_style2,String file_style,String id,String tablename){
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            String field_name = "attachment" + name;
            name = "file" + name;
            if(!file.equals(""))
            {
				content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
                content.append("<td " + td_style1 + " CLASS=\"TD_STYLE8\">");
                content.append(demo.getLang("erp", topic));
                content.append("：</td>");
                content.append("<td  colspan=\"3\"" + td_style2 + " CLASS=\"TD_STYLE2\"><input type=\"file\" name=\"" + name + "\"" +file_style+" CLASS=\"FILE_STYLE1\" width=\"100%\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>&nbsp;<input type=\"checkbox\" name=\"attachment\" value=\"" + field_name + "\">" + demo.getLang("erp", "删除该附件") + "</td>");
				content.append("</tr>");
			} else
            {
				content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
                content.append("<td " + td_style1 + " CLASS=\"TD_STYLE8\">");
                content.append(demo.getLang("erp", topic));
                content.append("：</td>");
                content.append("<td  colspan=\"3\"" + td_style2 + " CLASS=\"TD_STYLE2\"><input type=\"file\" name=\"" + name + "\"" +file_style+" CLASS=\"FILE_STYLE1\" width=\"100%\"></td>");
				content.append("</tr>");
			}
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

	public String printOrNot3(String file, String topic, HttpServletResponse response,String tr_style,String td_style1,String td_style2,String id,String tablename,String field_name)
    {
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            if(!file.equals(""))
            {
                content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
                content.append("<td " + td_style1 + " CLASS=\"TD_STYLE8\">");
                content.append(demo.getLang("erp", topic)+"：");
                content.append("</td>");
                content.append("<td colspan=\"3\"" + td_style2 + " CLASS=\"TD_STYLE2\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>&nbsp;</td>");
                content.append("</tr>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

	public String printOrNot33(String file, String topic, HttpServletResponse response,String tr_style,String td_style1,String td_style2,String id,String tablename,String field_name)
    {
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            if(!file.equals(""))
            {
                content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
                content.append("<td " + td_style1 + " CLASS=\"TD_STYLE1\">");
                content.append(demo.getLang("erp", topic));
                content.append("</td>");
                content.append("<td colspan=\"3\"" + td_style2 + " CLASS=\"TD_STYLE2\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>&nbsp;</td>");
                content.append("</tr>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

	public String printOrNot77(String file, String topic, HttpServletResponse response,String tr_style,String td_style1,String td_style2,String id,String tablename,String field_name)
    {
        StringBuffer content = new StringBuffer();
        try
        {
            java.io.PrintWriter out = response.getWriter();
            if(!file.equals(""))
            {
                content.append("<tr " + tr_style + " CLASS=\"TR_STYLE1\">");
                content.append("<td " + td_style1 + " CLASS=\"TD_STYLE1\">");
                content.append(demo.getLang("erp", topic));
                content.append("</td>");
                content.append("<td colspan=\"3\"" + td_style2 + " CLASS=\"TD_STYLE2\"><a href=\"javascript:winopenm('query_attachment.jsp?id=" + id+"&tablename="+tablename+"&fieldname="+field_name);
                content.append("')\"><font color=\"#3333FF\">");
                content.append(file.substring(10));
                content.append("</font></a>&nbsp;</td>");
                content.append("</tr>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return content.toString();
    }

}
