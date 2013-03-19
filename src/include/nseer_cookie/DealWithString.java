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

import include.nseer_cookie.counter;
import javax.servlet.*;

public class DealWithString{

	private static String s;
	private static String[] ss={"",""};
	private ServletContext dbApplication;

	public DealWithString(ServletContext dbApplication){
		this.dbApplication=dbApplication;
	}
	  
	public String joinIn(String a,String b) {
		counter count=new counter(dbApplication);
		int filenum=count.read("ondemand1","erpAttachmentcount");

		count.write("ondemand1","erpAttachmentcount",filenum);
		s = a+filenum+b;
		return s;
    }
	//逆
    public String[] divide(String c,int k){
		counter count=new counter(dbApplication);
		String filenum=count.read("ondemand1","erpAttachmentcount")+"";
		ss[0]="";
		ss[1]="";
		if(!c.equals("")){
		ss[0] = c.substring(0,k);
		ss[1] = c.substring(k+filenum.length());
		}
		return ss;
  	}

}