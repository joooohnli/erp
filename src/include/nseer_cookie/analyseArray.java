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


public class analyseArray {

	public String[] ana(String[] a) {
		int amount=1;
		String m="";
		for(int j=0;j<a.length;j++){
			amount=1;
		for(int i=0;i<a.length;i++){
			if(j!=i&&a[j].equals(a[i])){
				a[i]=a[i]+amount;
				amount++;
			}
		}
		}
		return a;
	}
	
}