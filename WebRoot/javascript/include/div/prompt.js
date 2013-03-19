/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function divPrompt3(value){
readXml('../../../css/include/nseer_cookie/xml-css.css','../../../xml/include/prompt/prompt3.xml','0');
multiLangValidate.dwrGetLang("erp",value,{callback:function(msg){document.getElementById('prompt_span').innerHTML=msg;}});
} 

function divPrompt2(value){
readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/include/prompt/prompt2.xml','0');
multiLangValidate.dwrGetLang("erp",value,{callback:function(msg){document.getElementById('prompt_span').innerHTML=msg;}});
} 