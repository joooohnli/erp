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

import java.util.*;

public class multi_businessComment{

public String getLang(ajax_businessComment demo,String group,String drag_text){
	String[] temp=drag_text.split("--");
	String ab=demo.getLang("erp",temp[0]);
	for(int i=1;i<temp.length;i++){
		ab+="--"+demo.getLang(group,temp[i]);
	}
	return ab;
}
}
