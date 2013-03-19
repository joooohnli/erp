/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.ajax;

import java.sql.ResultSet;
import java.util.StringTokenizer;
import java.util.Vector;
import include.nseer_db.*;
import include.tree_index.businessComment;


import javax.servlet.*;
import javax.servlet.http.*;

public class SearchSuggest extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, java.io.IOException {
		response.setContentType("text/text;charset=UTF-8");
		HttpSession session = request.getSession();
		ServletContext context=session.getServletContext();
		businessComment demo=new businessComment();
               demo.setPath(request);
		String search = request.getParameter("search");
		String tn="";
		String fn="";
		String tfn = (String)session.getAttribute("tfn");
		StringTokenizer tokenTO1 = new StringTokenizer(tfn,"&"); 
		while(tokenTO1.hasMoreTokens()) {
			tn = tokenTO1.nextToken();
			fn = tokenTO1.nextToken();
		} 
		String condition = (String)session.getAttribute("condition");
		nseer_db_backup db = new nseer_db_backup(context);
		String sql="";
		if(condition!=null){
			sql = "select "+fn+" from "+tn+" where "+condition+" and "+fn+" like '"+search+"%' order by "+fn;
		}else{
			sql = "select "+fn+" from "+tn+" where "+fn+" like '"+search+"%' order by "+fn;
		}
		ResultSet rs = null;
		Vector vData = new Vector();
		java.io.PrintWriter out = response.getWriter();
		try {
			if(db.conn((String)session.getAttribute("unit_db_name"))){
			rs = db.executeQuery(sql);
			while (rs.next())
			{
				vData.add(rs.getString(fn));
			}
			db.close();
			StringBuffer buf = new StringBuffer();
			for (int i=0;i<vData.size();i++)
			{
				String keyword = (String)vData.get(i);
				buf.append(keyword+"\n");
			}
			out.print(buf.toString());
			}else
		{
			out.println(demo.getLang("erp","数据库连接故障，请返回确认！"));
		}
		} catch (Exception e) {
e.printStackTrace();
} 
}
public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, java.io.IOException {
doPost(request, response);
}
public static String  unescape (String src) {
        StringBuffer tmp = new StringBuffer(); 
        tmp.ensureCapacity(src.length());
        int  lastPos=0,pos=0; 
        char ch; 
        while (lastPos<src.length())  { 
            pos = src.indexOf("%",lastPos); 
            if (pos == lastPos){ 
              if (src.charAt(pos+1)=='u'){ 
                ch = (char)Integer.parseInt(src.substring(pos+2,pos+6),16); 
                tmp.append(ch); 
                lastPos = pos+6;  
              }else{ 
                ch = (char)Integer.parseInt(src.substring(pos+1,pos+3),16); 
                tmp.append(ch);
                lastPos = pos+3; 
              }
            }else{ 
                  if (pos == -1){
                      tmp.append(src.substring(lastPos));
                      lastPos=src.length(); 
                   }else{     
                      tmp.append(src.substring(lastPos,pos)); 
                      lastPos=pos;
                   } 
            }
        } 
        return tmp.toString();
   } 




/*
	public String parasToXML(Vector v) {// 该方法将数据转化成XML格式输出
		StringBuffer buf = new StringBuffer();
		buf.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		buf.append("<pictures>");
		for (int i = 0; i < v.size(); i++) {
			AlbumEO album = (AlbumEO) v.get(i);
			buf.append("<item>");
			buf.append("<name>" + album.getAlbumName() + "</name>");
			buf.append("<url>" + album.getAlbumURL() + "</url>");
			buf.append("<description>" + album.getAlbumDescription()
					+ "</description>");
			buf.append("</item>");
		}
		buf.append("</pictures>");
		return buf.toString();
	}
*/
}