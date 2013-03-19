/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var vheight = window.screen.height-200
var vwidth =  window.screen.width-200
function winopenm(file){
	file=encodeURI(file);	
window.open(file,"","height="+vheight+",width="+vwidth+",top =0,left=0,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
}