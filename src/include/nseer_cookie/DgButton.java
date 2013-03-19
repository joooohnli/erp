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

import include.tree_index.*;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class DgButton{

	public static String getDraft(String para,HttpServletRequest request){
		HttpSession dbSession=request.getSession();
		ServletContext dbApplication=dbSession.getServletContext();
		businessComment demo=new businessComment();
		demo.setPath(request);
		String result="";
		if(((String)dbApplication.getAttribute("nseerDraft")).equals("1")){
			result="&nbsp;<input type=\"button\" onClick=\"draftOk("+para+");\" value=\""+demo.getLang("erp","保存草稿")+"\" onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup' class=\"BUTTON_STYLE1\" name=\"B1\">";
		}
		return result;
	}
	
	public static String getDsend(String para,HttpServletRequest request){
		HttpSession dbSession=request.getSession();
		ServletContext dbApplication=dbSession.getServletContext();
		businessComment demo=new businessComment();
		demo.setPath(request);
		String result="";
		if(((String)dbApplication.getAttribute("nseerDraft")).equals("1")){
			result="&nbsp;<input type=\"button\" onClick=\"sendOk("+para+");\" value=\""+demo.getLang("erp","保存草稿")+"\" onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup' class=\"BUTTON_STYLE1\" name=\"B1\">";
		}
		return result;
	}
	
	public static String getGsend(String para,HttpServletRequest request){
		HttpSession dbSession=request.getSession();
		ServletContext dbApplication=dbSession.getServletContext();
		businessComment demo=new businessComment();
		demo.setPath(request);
		String result="";
		if(((String)dbApplication.getAttribute("nseerDraft")).equals("1")){
			result="<input type=\"button\" onClick=\"sendOk("+para+");\" value=\""+demo.getLang("erp","转入垃圾箱")+"\" onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup' class=\"BUTTON_STYLE1\" name=\"B1\">";
		}
		return result;
	}
	
	public static String getGar(String para,HttpServletRequest request){
		HttpSession dbSession=request.getSession();
		ServletContext dbApplication=dbSession.getServletContext();
		businessComment demo=new businessComment();
		demo.setPath(request);
		String result="";
		if(((String)dbApplication.getAttribute("nseerDraft")).equals("1")){
			result="&nbsp;<input type=\"button\" onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup' class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","转入垃圾箱")+"\" onclick=\"showGarDiv(document.getElementById('rows_num').value,'"+para+"');\">";
		}
		return result;
	}
	
	public static String getGar(String func,String para,HttpServletRequest request){
		HttpSession dbSession=request.getSession();
		ServletContext dbApplication=dbSession.getServletContext();
		businessComment demo=new businessComment();
		demo.setPath(request);
		String result="";
		if(((String)dbApplication.getAttribute("nseerDraft")).equals("1")){
			result="&nbsp;<input type=\"button\" onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup' class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","转入垃圾箱")+"\" onclick=\""+func+"(document.getElementById('rows_num').value,'"+para+"');\">";
		}
		return result;
	}
}