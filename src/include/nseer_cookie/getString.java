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


public class getString {

	private String result="";

	public String getString(String a,String b,String c,String d){
		try{
			if(a.equals("")&&b.equals("")&&c.equals("")&&d.equals("")){
				result="";
			}else if(!a.equals("")&&b.equals("")&&c.equals("")&&d.equals("")){
				result=a+"/";
			}else if(!a.equals("")&&!b.equals("")&&c.equals("")&&d.equals("")){
				result=a+"/"+b+"/";
			}else if(!a.equals("")&&!b.equals("")&&!c.equals("")&&d.equals("")){
				result=a+"/"+b+"/"+c+"/";
			}else if(!a.equals("")&&!b.equals("")&&!c.equals("")&&!d.equals("")){
				result=a+"/"+b+"/"+c+"/"+d+"/";
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return result;
	}

}