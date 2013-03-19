/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */

var select;
function killerrors() { 
return true; 
} 
window.onerror = killerrors;

function onload(){
var shtml=search_suggest.innerHTML;
var ifm=document.createElement("<iframe frameborder=0 marginheight=0 marginwidth=0 hspace=0 vspace=0 ></iframe>")
ifm.style.width=search_suggest.offsetWidth
ifm.name=ifm.uniqueID
search_suggest.innerHTML=""
search_suggest.appendChild(ifm)
window.frames[ifm.name].document.write(s.outerHTML+"<body leftmargin=0 topmargin=0>"+shtml+"</body>")
}

function show(){
with(document.all.img1){
x=offsetLeft;
y=offsetTop;
objParent=offsetParent;
while(objParent.tagName.toUpperCase()!= "BODY"){
x+=objParent.offsetLeft;
y+=objParent.offsetTop;
objParent = objParent.offsetParent;
}
y+=offsetHeight-1
}
with(document.all.search_suggest.style){
pixelLeft=x
pixelTop=y
visibility=''
}
}
var one;
var searchReq;
var conter="";

function getXmlHttpRequestObject() {
	if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else if(window.ActiveXObject) {
		return new ActiveXObject("Microsoft.XMLHTTP");
	} else {
	}
}

function createAjaxObj(){
  var httprequest=false;
  var conter="";
if (window.XMLHttpRequest)
  { 
    httprequest=new XMLHttpRequest()
    if (httprequest.overrideMimeType)
      httprequest.overrideMimeType('text/xml')
  }
   else if (window.ActiveXObject)
   { 
     try {
       httprequest=new ActiveXObject("Msxml2.XMLHTTP");
     }
     catch (e){
       try{
          httprequest=new ActiveXObject("Microsoft.XMLHTTP");
       }
       catch (e){}
     }
   }
   return httprequest
}
var searchReq1;

function searchSuggest() {
searchReq = createAjaxObj();
document.getElementById('search_suggest').style.display='none';
var str = document.getElementById('txtSearch').value;
searchReq.open("GET", '../../search?search=' + encodeURI(str), true);
searchReq.onreadystatechange = handleSearchSuggest; 
searchReq.send(null);
}
var onee;
var ss;
var suggest_first="<div   class=\"suggest_link\">&nbsp;</div>";

function handleSearchSuggest() {
if (searchReq.readyState == 4) {
document.getElementById('search_suggest').style.display='block';
var cla=document.getElementById('search_suggest');
cla.innerHTML='';
cla.setAttribute("class","search_suggest");
cla.setAttribute("className","search_suggest");
var fore=document.getElementById("frmSearch");
var select=fore.fason;
fore.fason.innerHTML = '';
var options =searchReq.responseText.split("\n");
if(options[0]==""){document.getElementById('search_suggest').style.display='none';}
 conter='';
for (var i = 0, n = options.length; i < n-1; i++) {
var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += 'onclick=\"javascript:window.parent.setSearch(this.innerHTML);\" ';
suggest += 'class="suggest_link">' + options[i] + '</div>';
conter += suggest;
}
ss= document.getElementById('search_suggest');
ss.innerHTML = null;
ss.innerHTML = '';
ss.innerHTML = suggest_first+conter;
if (window.ActiveXObject)
{ 
onload();
}
}
}

function search(){
searchSuggest();
}

function suggestOver(div_value) {
	div_value.className = 'suggest_link_over';
}

function suggestOut(div_value) {
	div_value.className = 'suggest_link';
}

function setSearch(value) {    
	blurSuggest(value);
    document.getElementById('search_suggest').style.display='none';
	document.getElementById('search_suggest').innerHTML = '';
	var searchResult=document.getElementById('txtSearch').value;
}

function blurSuggest(value){




var op=document.getElementById('autosearch');

document.getElementById('txtSearch').value = value;

op.value= value;

}

function combox(obj,select){
this.obj=obj
this.name=select;
this.select=document.getElementsByName(select)[0];
}

combox.prototype.init=function(){
var inputbox="<input id=\"txtSearch\"  onkeyup=\"search();\"  name='combox_"+this.name+"' ochange='"+this.obj+".find()'"
inputbox+="style='position:absolute;width:"+(this.select.offsetWidth-16)+";height:"+this.select.offsetHeight+";left:"+getL(this.select)+";top:"+getT(this.select)+"'>"
document.write(inputbox)
with(this.select.style){
left=getL(this.select)
top=getT(this.select)
position="absolute"
clip="rect(0 "+(this.select.offsetWidth)+" "+this.select.offsetHeight+" "+(this.select.offsetWidth-18)+")"
}
this.select.onchange=new Function(this.obj+".change()")
this.change()
}

combox.prototype.find=function(){
var inputbox=document.getElementsByName("combox_"+this.name)[0]
with(this.select){
for(i=0;i<options.length;i++)
if(options[i].text.indexOf(inputbox.value)==0){
selectedIndex=i
this.change();
break;
}
}
}

combox.prototype.change=function(){
	
var inputbox=document.getElementsByName("combox_"+this.name)[0]
inputbox.value=this.select.options[this.select.selectedIndex].text;
//alert(this.select.options[this.select.selectedIndex].text);
with(inputbox){
select();focus()
};
}
function getL(e){
var l=e.offsetLeft;
while(e=e.offsetParent)l+=e.offsetLeft;
return l;
}
function getT(e){
var t=e.offsetTop;
while(e=e.offsetParent)t+=e.offsetTop;
return t;
}