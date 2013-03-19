/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.users_lock;

import java.io.*;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.http.*;
import javax.servlet.ServletContext;

public class UserInfo extends java.lang.Object 
                      implements Serializable,HttpSessionBindingListener {
  private String userName="";

  public UserInfo(String uName) {
    this.userName=uName;
  }

  public void valueBound(HttpSessionBindingEvent event) {
    HttpSession session =event.getSession();
    ServletContext ctx =session.getServletContext();
    Map map =(Map)ctx.getAttribute("user");
    if(map==null) {
       map=new HashMap();
       ctx.setAttribute("user",map);
    }
    if (!map.containsValue(userName)) {
      map.put(userName,userName);      
    }
  }

  public void valueUnbound(HttpSessionBindingEvent event) {
    HttpSession session =event.getSession();
    ServletContext ctx =session.getServletContext();
    Map map =(Map)ctx.getAttribute("user");
    map.remove(userName);
  }

}
