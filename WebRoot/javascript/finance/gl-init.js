/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function   formatCash(cash) 
{
var cash=cash+"";
var cash1=cash.substring(0,cash.indexOf('.'));
var cash2=cash.substring(cash.indexOf('.'),cash.length);
var   str_cash=cash1+"";
var   ret_cash=""; 
var   counter=   0; 
for(var   i=str_cash.length-1;i >=0;i--) 
{ 
ret_cash =str_cash.charAt(i)+ret_cash;
if(str_cash.charAt(i)== ".") 
{ 
counter=0; 
continue; 
} 
counter++; 
if(counter==3) 
{
counter=0; 
if(i!=0&&str_cash.charAt(i-1)!= ".") 
ret_cash =","+ret_cash; 
}
} 
ret_cash=ret_cash+cash2;
return   ret_cash; 
}
function   FormatNumberPoint(srcStr,nAfterDot)   
{   
var   srcStr;
var nAfterDot;   
var   resultStr,nTen;   
srcStr   =   ""+srcStr+"";   
strLen   =   srcStr.length;   
dotPos   =   srcStr.indexOf(".",0);   
if(dotPos   ==   -1){   
resultStr   =   srcStr+".";   
for(i=0;i<nAfterDot;i++){
resultStr = resultStr+"0";   
}   
return  resultStr;   
}   
else{   
if((strLen-dotPos-1)>=nAfterDot){   
nTen=1;   
for(j=0;j<nAfterDot;j++){   
nTen=nTen*10;   
}   
resultStr =Math.round(parseFloat(srcStr)*nTen)/nTen;
return   resultStr;   
}   
else{
resultStr=srcStr;   
for (i=0;i<(nAfterDot-strLen+dotPos+1);i++){   
resultStr=resultStr+"0";   
}   
return   resultStr;   
}   
}   
}

var data_all='';
function data_tr(data_array) {
if (navigator.userAgent.indexOf("MSIE")>0){
var tr_obj=data_array.parentElement.parentElement;
var tr_obj_id=data_array.parentElement.parentElement.id;
}else if (navigator.userAgent.indexOf("Firefox")>0){
var tr_obj=data_array.parentNode.parentNode;
var tr_obj_id=data_array.parentNode.parentNode.id;
}
data_all+=tr_obj_id+"㊣";
var tr_obj_input=tr_obj.getElementsByTagName("input");
for(var i=0;i<tr_obj_input.length;i++){
if(tr_obj_input[i].value==''){
data_all+="0◎";
}else{
data_all+=tr_obj_input[i].value+"◎";
}
}
data_all=data_all.substring(0,data_all.length-1)+"♀";
}

var aa=0;
function input_blur(obj){
if (navigator.userAgent.indexOf("MSIE")>0){
var obj_parent = obj.parentElement; 
}else if (navigator.userAgent.indexOf("Firefox")>0){
var obj_parent = obj.parentNode; 
}
obj_parent.className='tdclass';
if(obj.value!=''){
var in_data=obj.value.replace(/,/g,'');
if (navigator.userAgent.indexOf("Firefox")>0){
obj.value=formatCash(FormatNumberPoint(parseFloat(in_data),2));
}else if (navigator.userAgent.indexOf("MSIE")>0){
obj.value=formatCash(FormatNumberPoint(parseFloat(in_data),2));
}
}
obj.className='ok1';
var amount_tag=0;
data_tr(obj);
if(obj.name.indexOf('Amount')==-1){
if(obj.name.length!=7){
var data_array=document.getElementById(obj.name);
data_tr(data_array);
if(data_array.name.length!=7){
while(data_array.name!=null&&data_array.name!=''){
data_array=document.getElementById(data_array.name);
data_tr(data_array);
if(data_array.name.length==7)break;
}
}
}
data_all=data_all.replace(/,/g,'');
}else{
amount_tag=1;
if(obj.name.length!=13){
var data_array=document.getElementById(obj.name);
data_tr(data_array);
if(data_array.name.length!=13){
while(data_array.name!=null&&data_array.name!=''){
data_array=document.getElementById(data_array.name);
data_tr(data_array);
if(data_array.name.length==13)break;
}
}
}
data_all=data_all.replace(/,/g,'');
}
aa++;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../../finance_config_account_init_register_init_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('data='+encodeURI(data_all.substring(0,data_all.length-1))+'&amount_tag='+amount_tag+'&start_tag=1');
}
data_all='';


}

function borrow(obj,input_tag){
if (navigator.userAgent.indexOf("MSIE")>0){
var tr_input_obj=obj.parentElement.parentElement.getElementsByTagName("input");
}else if (navigator.userAgent.indexOf("Firefox")>0){
var tr_input_obj=obj.parentNode.parentNode.getElementsByTagName("input");
}
var tr_value1=tr_input_obj[1].value.replace(/,/g,'')==''?0:tr_input_obj[1].value.replace(/,/g,'');
var tr_value2=tr_input_obj[2].value.replace(/,/g,'')==''?0:tr_input_obj[2].value.replace(/,/g,'');
var tr_value3=tr_input_obj[3].value.replace(/,/g,'')==''?0:tr_input_obj[3].value.replace(/,/g,'');
if(input_tag!='2'){
tr_input_obj[0].value=tr_value3-(tr_value1-tr_value2);
}else{
tr_input_obj[0].value=tr_value3-(tr_value2-tr_value1);
}
}

function input_keyup(obj,input_tag,firstName){
if(obj.value!='-'){
borrow(obj,input_tag);
obj.value=obj.value.replace(/[^\'-0123456789.']/g,'');
var data_array=document.getElementsByName(firstName);
for(var i=0;i<data_array.length;i++){
var value0=0;
var data_array_one=document.getElementsByName(data_array[i].id);
for(var j=navigator.userAgent.indexOf("MSIE")>0?1:0;j<data_array_one.length;j++){
var value=0;
var data_array_two=document.getElementsByName(data_array_one[j].id);
for(var w=navigator.userAgent.indexOf("MSIE")>0?1:0;w<data_array_two.length;w++){
var value2=0;
var data_array_three=document.getElementsByName(data_array_two[w].id);
for(var m=navigator.userAgent.indexOf("MSIE")>0?1:0;m<data_array_three.length;m++){
var value3=0;
var data_array_four=document.getElementsByName(data_array_three[m].id);
for(var n=navigator.userAgent.indexOf("MSIE")>0?1:0;n<data_array_four.length;n++){
var value4=0;
var data_array_five=document.getElementsByName(data_array_four[n].id);
for(var u=navigator.userAgent.indexOf("MSIE")>0?1:0;u<data_array_five.length;u++){
var value5=0;
var data_array_six=document.getElementsByName(data_array_five[u].id);
for(var f=navigator.userAgent.indexOf("MSIE")>0?1:0;f<data_array_six.length;f++){
var value6=0;
var data_array_seven=document.getElementsByName(data_array_six[f].id);
for(var h=navigator.userAgent.indexOf("MSIE")>0?1:0;h<data_array_seven.length;h++){
var value7=0;
var data_array_eight=document.getElementsByName(data_array_seven[h].id);
for(var p=navigator.userAgent.indexOf("MSIE")>0?1:0;p<data_array_eight.length;p++){
var value8=0;
var data_array_nine=document.getElementsByName(data_array_eight[p].id);
for(var t=navigator.userAgent.indexOf("MSIE")>0?1:0;t<data_array_nine.length;t++){
if(data_array_nine[t].value!=''){
var in_data9=(data_array_nine[t].value.replace(/,/g,''));
value8+=parseFloat(in_data9);
}
if(value8!=0)document.getElementById(data_array_eight[p].id).value=formatCash(FormatNumberPoint(value8,2));
if(value8==0&&data_array_eight[p].onchange==null)document.getElementById(data_array_eight[p].id).value='';
borrow(document.getElementById(data_array_eight[p].id),input_tag);
}
if(data_array_eight[p].value!=''){
var in_data8=(data_array_eight[p].value.replace(/,/g,''));
value7+=parseFloat(in_data8);
}
if(value7!=0)document.getElementById(data_array_seven[h].id).value=formatCash(FormatNumberPoint(value7,2));
if(value7==0&&data_array_seven[h].onchange==null)document.getElementById(data_array_seven[h].id).value='';
borrow(document.getElementById(data_array_seven[h].id),input_tag);
}
if(data_array_seven[h].value!=''){
var in_data7=(data_array_seven[h].value.replace(/,/g,''));
value6+=parseFloat(in_data7);
}
if(value6!=0)document.getElementById(data_array_six[f].id).value=formatCash(FormatNumberPoint(value6,2));
if(value6==0&&data_array_six[f].onchange==null)document.getElementById(data_array_six[f].id).value='';
borrow(document.getElementById(data_array_six[f].id),input_tag);
}
if(data_array_six[f].value!=''){
var in_data6=(data_array_six[f].value.replace(/,/g,''));
value5+=parseFloat(in_data6);
}
if(value5!=0)document.getElementById(data_array_five[u].id).value=formatCash(FormatNumberPoint(value5,2));
if(value5==0&&data_array_five[u].onchange==null)document.getElementById(data_array_five[u].id).value='';
borrow(document.getElementById(data_array_five[u].id),input_tag);
}
if(data_array_five[u].value!=''){
var in_data5=(data_array_five[u].value.replace(/,/g,''));
value4+=parseFloat(in_data5);
}
if(value4!=0)document.getElementById(data_array_four[n].id).value=formatCash(FormatNumberPoint(value4,2));
if(value4==0&&data_array_four[n].onchange==null)document.getElementById(data_array_four[n].id).value='';
borrow(document.getElementById(data_array_four[n].id),input_tag);
}
if(data_array_four[n].value!=''){
var in_data4=(data_array_four[n].value.replace(/,/g,''));
value3+=parseFloat(in_data4);
}
if(value3!=0)document.getElementById(data_array_three[m].id).value=formatCash(FormatNumberPoint(value3,2));
if(value3==0&&data_array_three[m].onchange==null)document.getElementById(data_array_three[m].id).value='';
borrow(document.getElementById(data_array_three[m].id),input_tag);
}
if(data_array_three[m].value!=''){
var in_data3=(data_array_three[m].value.replace(/,/g,''));
value2+=parseFloat(in_data3);
}
if(value2!=0)document.getElementById(data_array_two[w].id).value=formatCash(FormatNumberPoint(value2,2));
if(value2==0&&data_array_two[w].onchange==null)document.getElementById(data_array_two[w].id).value='';
borrow(document.getElementById(data_array_two[w].id),input_tag);
}
if(data_array_two[w].value!=''){
var in_data=(data_array_two[w].value.replace(/,/g,''));
value+=parseFloat(in_data);
}
}
if(value!=0)document.getElementById(data_array_one[j].id).value=formatCash(FormatNumberPoint(value,2));
if(value==0&&data_array_one[j].onchange==null)document.getElementById(data_array_one[j].id).value='';
borrow(document.getElementById(data_array_one[j].id),input_tag);
if(data_array_one[j].value!=''){
var in_data0=(data_array_one[j].value.replace(/,/g,''));
value0+=parseFloat(in_data0);
}
}
if(value0!=0)document.getElementById(data_array[i].id).value=formatCash(FormatNumberPoint(value0,2));
if(value0==0&&data_array[i].onchange==null)document.getElementById(data_array[i].id).value='';
borrow(document.getElementById(data_array[i].id),input_tag);
}
}
}

function input_focus(obj){
if (navigator.userAgent.indexOf("MSIE")>0){
var obj_parent = obj.parentElement; 
}else if (navigator.userAgent.indexOf("Firefox")>0){
var obj_parent = obj.parentNode; 
}
obj_parent.className='td';
obj.className='ok';
if(obj.value!=''){
var input_data=obj.value.replace(/,/g,'');
obj.value=input_data;
var len=input_data.lastIndexOf('.');
if(parseInt(input_data.substring(len+1,input_data.length))!=0){
obj.value=input_data;
}else{
obj.value=input_data.substring(0,len);
}
}
if (navigator.userAgent.indexOf("MSIE")>0){
focus_last(obj);
}
}
function   focus_last(obj){   
var   text   =   obj.createTextRange();   
text.collapse(false);   
text.select();   
}