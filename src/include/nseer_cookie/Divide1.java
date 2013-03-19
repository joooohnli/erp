/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
///////////////////////////////////////////////////////////////////////////////////////////
//
//该方法用于分切类似于 '010101/中国' 字符串，取第一个'/'之前的做id返回, 第一个'/'之后的所有做name返回
//
/////////////////////////////////////////////////////////////////////////////////////////
package include.nseer_cookie;
public class Divide1 {

	/**
	 * @param args
	 */
	public static String getId(String chain){
		if(chain.indexOf(" ")!=-1){
			return chain.split(" ")[0];
		}else {
			return chain;
		}
	}
	public static String getName(String chain){
		if(chain.indexOf(" ")!=-1){
			return chain.substring(chain.split(" ")[0].length()+1);
		}else {
			return chain;
		}
	}
}
