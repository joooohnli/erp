/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function key()
{
	var locate=document.getElementById('locate');
	var key_locate=document.getElementById('key_locate');
	locate.style.display='none';
	key_locate.style.display='block';
	document.getElementById('timeLocateValidation').action='change_key_locate_getpara.jsp';
}
function back()
{
	var locate=document.getElementById('locate');
	var key_locate=document.getElementById('key_locate');
	locate.style.display='block';
	key_locate.style.display='none';
	document.getElementById('timeLocateValidation').action='change_locate_getpara.jsp';
}
function closefile(){
document.getElementById('nseer1').style.display='none';
document.body.removeChild(document.getElementById('treeButton'));
}