/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.validator;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import include.tree_index.businessComment;

public class ValidatorDupfp extends HttpServlet {

	public void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
		try{
			response.setContentType("text/html;charset=UTF-8");
			HttpSession session=request.getSession();
			businessComment demo=new businessComment();
			demo.setPath(request);
			PrintWriter out=response.getWriter();
			String value=request.getParameter("validator_dup");
			String valued=request.getParameter("valued");
			String urlr=request.getParameter("urlr");
			String table_name=request.getParameter("valueb");
			String fn=request.getParameter("valuec");
			ValidatorDupBeanfp vdb=new ValidatorDupBeanfp();
			if(!vdb.isDup(session,table_name,fn,value,valued,urlr).equals("")){
				out.println(value+demo.getLang("erp","可能与")+vdb.isDup(session,table_name,fn,value,valued,urlr)+demo.getLang("erp","重复，请确认！"));
			}else{
				out.println(demo.getLang("erp","没有重复，请继续！"));
			}
		}catch(Exception ex){
		ex.printStackTrace();
		}
	}
}
