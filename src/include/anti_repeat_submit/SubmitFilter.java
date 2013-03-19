/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.anti_repeat_submit;
/**
 * SubmitFilter.java
 *
 *
 * Created: Fri Sep 24 15:04:04 2004
 *
 * @author <a href="mailto:Administrator@ORK"></a>
 * @version 1.0
 */
import javax.servlet.FilterConfig;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import java.security.*;

public class SubmitFilter implements Filter {
  private FilterConfig filterConfig=null;

  public SubmitFilter() {

  }

  /**
   * Describe <code>init</code> method here.
   *
   * @param filterConfig a <code>FilterConfig</code> value
   * @exception ServletException if an error occurs
   */
  public void init(FilterConfig filterConfig) throws ServletException {
    this.filterConfig=filterConfig;
  }

  /**
   * Describe <code>destroy</code> method here.
   *
   */
  public void destroy() {
    filterConfig=null;
  }

  /**
   * Describe <code>doFilter</code> method here.
   *
   * @param servletRequest a <code>ServletRequest</code> value
   * @param servletResponse a <code>ServletResponse</code> value
   * @param filterChain a <code>FilterChain</code> value
   * @exception ServletException if an error occurs
   * @exception IOException if an error occurs
   */
  public void doFilter(ServletRequest servletRequest,
                       ServletResponse servletResponse,
                       FilterChain filterChain)
      throws ServletException, IOException {
      if(filterConfig==null) {

	return;
      }
    HttpServletRequest request=(HttpServletRequest) servletRequest;
    HttpSession session=request.getSession();
    HttpServletResponse response=(HttpServletResponse) servletResponse;
    String path=request.getRequestURI();
    path=path.substring(1);
    path=path.split("/")[0];
	  try{
    request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    String  submit= (String)session.getAttribute(Globals.TOKEN_KEY);
    String page_submit=request.getParameter(Globals.TOKEN_KEY);
    if (page_submit==null) {
      filterChain.doFilter(servletRequest,servletResponse);
      return;
    }
    if (submit!=null&&
        !submit.equals(page_submit)) {
	  response.sendRedirect("/"+path+"/include/error_msg.jsp?finished_tag=0");
    } else {
      String token=generateToken(request);
      session.setAttribute(Globals.TOKEN_KEY,token);
      filterChain.doFilter(servletRequest,servletResponse);
    } // end of else
	  }catch(Exception ex){
		  ex.printStackTrace();
		  response.sendRedirect("/"+path+"/include/error_msg.jsp?finished_tag=1");
		  }
  }

  /**
   * 产生令牌
   *
   */
  protected String generateToken(HttpServletRequest request) {
   HttpSession session = request.getSession();
   try {
     byte id[] = session.getId().getBytes();
     byte now[] =
       new Long(System.currentTimeMillis()).toString().getBytes();
     MessageDigest md = MessageDigest.getInstance("MD5");
     md.update(id);
     md.update(now);
     return (toHex(md.digest()));
   } catch (IllegalStateException e) {
     return null;
   } catch (NoSuchAlgorithmException e) {
     return null;
   }
  }

  public String toHex(byte buffer[]) {
    StringBuffer sb = new StringBuffer();
    String s = null;
    for (int i = 0; i < buffer.length; i++) {
      s = Integer.toHexString((int) buffer[i] & 0xff);
      if (s.length() < 2) {
        sb.append('0');
      }
      sb.append(s);
    }
    return sb.toString();
  }

} // SubmitFilter
