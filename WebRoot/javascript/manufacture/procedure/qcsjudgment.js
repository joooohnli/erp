/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function qcsJudgment(){
	multiLangValidate.dwrGetLang("erp",'工序质检未通过，您不能完成本工序',{callback:function(msg){n_A.divShow(msg);}});
	return false;
}