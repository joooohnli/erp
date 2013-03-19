/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/
function DayAddDiff(year, month, day, diff){
var numDays = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
var isLeap = false;
var newyear = year;
var newmonth = month - 1;
var n = numDays[newmonth];
var newday = day;
var newdiff = diff;
var ln;
if (newmonth == 0)
    ln = 31;
else if(newmonth == 11)
    ln = 31;
else
    ln = numDays[newmonth + 1];
if (diff != 0){
    //判断是否润年
    if (year % 4 == 0){
        if (year % 100 != 0)
isLeap = true;
        else{
if (year % 400 == 0)
    isLeap = true;
        }
    }
    if (newmonth == 1 && isLeap)
        ++n;
        
    if (newmonth  == 0 && isLeap) 
        ++ln;
    var newday = day + newdiff;
    if (newday > 0){
        if (newday > n){
newday = newday - n;
if (newmonth == 11)
{
    newmonth = 0;
    newyear += 1;
    newdiff = newday - 1;
    return DayAddDiff(newyear, newmonth + 1, 1, newdiff);
}
else{
    newmonth += 1
    newdiff = newday - 1;
    return DayAddDiff(newyear, newmonth + 1, 1, newdiff);
}
        }
    }
    else if (newday == 0){
        if (newmonth == 0)
        {
newmonth = 11
newyear += -1;
newday = 31;
        }
        else{
newmonth += -1
newday = ln;
        }
    }
    else{
        if (newmonth == 0)
        {
newmonth = 11
newyear += -1;
newdiff = newday;
newday = 31;
return DayAddDiff(newyear, newmonth + 1, newday, newdiff);
        }
        else{
newmonth += -1;
newdiff = newday;
newday = ln;
return DayAddDiff(newyear, newmonth + 1, newday, newdiff);
        }
    }
}
var daystring = "";
daystring += year;
newmonth += 1;
if (newmonth < 10)
    daystring += "-0" + newmonth;
else
    daystring += "-" + newmonth;
if (newday < 10)
    daystring += "-0" + newday;
else
    daystring += "-" + newday;
return daystring;
        }
var time_m;
var time_m1;
var u=0;
var v=0;
var data_month=['01','02','03','04','05','06','07','08','09','10','11','12'];

function time_init(year,month){
for(var i=1;i<25;i++){
if(i%2==1){
time_m=data_month[u];
u++;
}
if(i%2==0){
if(i==4){
var sa=validation_year(year)==1?'-29':'-28'
document.getElementById(i+"").value=year+"-"+time_m+sa;
if(to_int(time_m)>=month&&to_int(time_m)<=11){
	document.getElementById(i+"").style.background='#66CCFF';
	document.getElementById(i+"").disabled=false;
}
}
else if(i==8||i==12||i==18||i==22){
document.getElementById(i+"").value=year+"-"+time_m+"-30";
if(to_int(time_m)>=month&&to_int(time_m)<=11){
	document.getElementById(i+"").style.background='#66CCFF';
	document.getElementById(i+"").disabled=false;
}
}else{
document.getElementById(i+"").value=year+"-"+time_m+"-31";
if(to_int(time_m)>=month&&to_int(time_m)<=11){
	document.getElementById(i+"").style.background='#66CCFF';
	document.getElementById(i+"").disabled=false;
}
}
}else{
document.getElementById(i+"").value=year+"-"+time_m+"-01";
}
}
u=0;
}

function to_string(str){
var str1=parseInt(str)+1000+"";
str1=str1.substring(str1.length-2,str1.length);
return str1;
}
function to_int(str_value){
var c;
if(str_value.substring(0,1).indexOf('0')==-1){
c=parseInt(str_value);
}else{
c=parseInt(str_value.substring(str_value.length-1,str_value.length));
}
return c;
}
function to_year(str){
var year=str.split("-");
return year[0];
}
function to_string(str){
var str1=parseInt(str)+1000+"";
str1=str1.substring(str1.length-2,str1.length);
return str1;
}
var mm=0;
function to1(str){
var str1=str.split("-");
var memp;
if(str1[1]=='13'){
memp=parseInt(str1[0])+1+"";
}else{
memp=str1[0];
}
if((parseInt(memp)%4==0&&parseInt(memp)%100!=0)||parseInt(memp)%400==0){
mm='29';
}else{
mm='28';
}
return memp;
}
function to2(str){
var str1=str.split("-");
var str2=str1[1].replace(/13/g,'01');
return str2;
}
function to3(str){
var str1=str.split("-");
return str1[2];
}
var input_init_value;
function focus_v(obj){
input_init_value=obj.value;
}
function   comptime(a,b,c)   
{   
var   dateA   =   new   Date(a);   
var   dateB   =   new   Date(b);
var   dateC   =   new   Date(c);
if(isNaN(dateA)   ||   isNaN(dateB)||   isNaN(dateC))   return   null;   
if(dateB  > dateA&&dateB<dateC) {return   1;   }else{return   0; }
}   
var tag_s;
function ok2(va){
var zz;
if(validation_year(to_year(va))==1){zz='29';}else{zz='28';}
var xxx;
if(to2(va)=='01'&&to3(va)=='31'||to2(va)=='03'&&to3(va)=='31'||to2(va)=='05'&&to3(va)=='31'||to2(va)=='07'&&to3(va)=='31'||to2(va)=='08'&&to3(va)=='31'||to2(va)=='10'&&to3(va)=='31'||to2(va)=='12'&&to3(va)=='31'){
tag_s=1;
}else if(to2(va)=='04'&&to3(va)=='30'||to2(va)=='06'&&to3(va)=='30'||to2(va)=='09'&&to3(va)=='30'||to2(va)=='11'&&to3(va)=='30'){
tag_s=2;
}
else if(to2(va)=='01'&&to3(va)=='30'||to2(va)=='03'&&to3(va)=='30'||to2(va)=='05'&&to3(va)=='30'||to2(va)=='07'&&to3(va)=='30'||to2(va)=='08'&&to3(va)=='30'||to2(va)=='10'&&to3(va)=='30'||to2(va)=='12'&&to3(va)=='30'){
tag_s=2;
}
else if(to2(va)=='04'&&to3(va)=='29'||to2(va)=='06'&&to3(va)=='29'||to2(va)=='09'&&to3(va)=='29'||to2(va)=='11'&&to3(va)=='29'){
tag_s=3;
}
else if(to2(va)=='01'&&to3(va)=='29'||to2(va)=='03'&&to3(va)=='29'||to2(va)=='05'&&to3(va)=='29'||to2(va)=='07'&&to3(va)=='29'||to2(va)=='08'&&to3(va)=='29'||to2(va)=='10'&&to3(va)=='29'||to2(va)=='12'&&to3(va)=='29'){
tag_s=3;
}
else if(to2(va)=='04'&&to3(va)=='28'||to2(va)=='06'&&to3(va)=='28'||to2(va)=='09'&&to3(va)=='28'||to2(va)=='11'&&to3(va)=='28'){
tag_s=4;
}
else if(to2(va)=='01'&&to3(va)=='28'||to2(va)=='03'&&to3(va)=='28'||to2(va)=='05'&&to3(va)=='28'||to2(va)=='07'&&to3(va)=='28'||to2(va)=='08'&&to3(va)=='28'||to2(va)=='10'&&to3(va)=='28'||to2(va)=='12'&&to3(va)=='28'){
tag_s=4;
}
else if(to2(va)=='02'&&to3(va)==zz){
tag_s=6;
}
else{
tag_s=0;
}
}   
function ok(va){
if(tag_s==1){
var xxx;
if(to2(va)=='01'&&to3(va)=='31'||to2(va)=='03'&&to3(va)=='31'||to2(va)=='05'&&to3(va)=='31'||to2(va)=='07'&&to3(va)=='31'||to2(va)=='08'&&to3(va)=='31'||to2(va)=='10'&&to3(va)=='31'||to2(va)=='12'&&to3(va)=='31'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}
else if(to2(va)=='02'&&to3(va)==mm||to2(va)=='04'&&to3(va)=='30'||to2(va)=='06'&&to3(va)=='30'||to2(va)=='09'&&to3(va)=='30'||to2(va)=='11'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}else{
//left
var ccc=to_string(to_int(to2(va))+1);
var ddd=to_string(to_int(to3(va))+1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
}
if(tag_s==2){
var xxx;
if(to2(va)=='01'&&to3(va)=='30'||to2(va)=='03'&&to3(va)=='30'||to2(va)=='05'&&to3(va)=='30'||to2(va)=='07'&&to3(va)=='30'||to2(va)=='08'&&to3(va)=='30'||to2(va)=='10'&&to3(va)=='30'||to2(va)=='12'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-31';
}else if(to2(va)=='02'&&to3(va)==mm||to2(va)=='04'&&to3(va)=='30'||to2(va)=='06'&&to3(va)=='30'||to2(va)=='09'&&to3(va)=='30'||to2(va)=='11'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}}
if(tag_s==3){
var xxx;
if(to2(va)=='01'&&to3(va)=='29'||to2(va)=='03'&&to3(va)=='29'||to2(va)=='05'&&to3(va)=='29'||to2(va)=='07'&&to3(va)=='29'||to2(va)=='08'&&to3(va)=='29'||to2(va)=='10'&&to3(va)=='29'||to2(va)=='12'&&to3(va)=='29'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-30';
}else if(to2(va)=='02'&&to3(va)==mm){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}else if(to2(va)=='04'&&to3(va)=='29'||to2(va)=='06'&&to3(va)=='29'||to2(va)=='09'&&to3(va)=='29'||to2(va)=='11'&&to3(va)=='29'){

var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-30';
}
}
if(tag_s==4){
var xxx;
if(to2(va)=='01'&&to3(va)=='28'||to2(va)=='03'&&to3(va)=='28'||to2(va)=='05'&&to3(va)=='28'||to2(va)=='07'&&to3(va)=='28'||to2(va)=='08'&&to3(va)=='28'||to2(va)=='10'&&to3(va)=='28'||to2(va)=='12'&&to3(va)=='28'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-29';
}else if(to2(va)=='02'&&to3(va)==mm){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}else if(to2(va)=='04'&&to3(va)=='28'||to2(va)=='06'&&to3(va)=='28'||to2(va)=='09'&&to3(va)=='28'||to2(va)=='11'&&to3(va)=='28'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-29';
}
else{
var ccc=to_string(to_int(to2(va)));
var ddd=to_string(to_int(to3(va))+1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
}
if(tag_s==6){
var nn;
if(validation_year(va.substring(0,4))==1){nn='29'}else{ nn='28'};
var xxx;
if(to2(va)=='02'&&to3(va)==nn){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}
else{
var ccc=to_string(to_int(to2(va)));
var ddd=to_string(to_int(to3(va))+1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
}
if(tag_s==0){
var xxx;
var ccc=to_string(to_int(to2(va)));
var ddd=to_string(to_int(to3(va))+1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
return xxx;
}   
function ok1(va){   
if(tag_s==1){
var xxx;
if(to2(va)=='01'&&to3(va)=='01'||to2(va)=='03'&&to3(va)=='01'||to2(va)=='05'&&to3(va)=='01'||to2(va)=='07'&&to3(va)=='01'||to2(va)=='08'&&to3(va)=='01'||to2(va)=='10'&&to3(va)=='01'||to2(va)=='12'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-31';
}
else if(to2(va)=='04'&&to3(va)=='01'||to2(va)=='06'&&to3(va)=='01'||to2(va)=='09'&&to3(va)=='01'||to2(va)=='11'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-30';
}
else if(to2(va)=='02'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-'+mm;
}
else{
var ccc=to_string(to_int(to2(va))+1);
var ddd=to_string(to_int(to3(va))-1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
}
if(tag_s==2){
var xxx;
if(to2(va)=='03'&&to3(va)=='31'||to2(va)=='05'&&to3(va)=='31'||to2(va)=='07'&&to3(va)=='31'||to2(va)=='08'&&to3(va)=='31'||to2(va)=='10'&&to3(va)=='31'||to2(va)=='12'&&to3(va)=='31'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-30';
}if(to2(va)=='01'&&to3(va)=='31'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-'+mm;
}else if(to2(va)=='01'&&to3(va)=='01'||to2(va)=='03'&&to3(va)=='01'||to2(va)=='05'&&to3(va)=='01'||to2(va)=='07'&&to3(va)=='01'||to2(va)=='08'&&to3(va)=='01'||to2(va)=='10'&&to3(va)=='01'||to2(va)=='12'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-30';
}
}
if(tag_s==3){
var xxx;
if(to2(va)=='03'&&to3(va)=='30'||to2(va)=='05'&&to3(va)=='30'||to2(va)=='07'&&to3(va)=='30'||to2(va)=='08'&&to3(va)=='30'||to2(va)=='10'&&to3(va)=='30'||to2(va)=='12'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-29';
}else if(to2(va)=='01'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-'+mm;
}else if(to2(va)=='01'&&to3(va)=='01'||to2(va)=='03'&&to3(va)=='01'||to2(va)=='05'&&to3(va)=='01'||to2(va)=='07'&&to3(va)=='01'||to2(va)=='08'&&to3(va)=='01'||to2(va)=='10'&&to3(va)=='01'||to2(va)=='12'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-29';
}else if(to2(va)=='04'&&to3(va)=='30'||to2(va)=='06'&&to3(va)=='30'||to2(va)=='09'&&to3(va)=='30'||to2(va)=='11'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-29';
}
}
if(tag_s==4){
if(mm=='28'){
if(to2(va)=='03'&&to3(va)=='29'||to2(va)=='05'&&to3(va)=='29'||to2(va)=='07'&&to3(va)=='29'||to2(va)=='08'&&to3(va)=='29'||to2(va)=='10'&&to3(va)=='29'||to2(va)=='12'&&to3(va)=='29'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-'+mm;
}else if(to2(va)=='01'&&to3(va)=='29'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-'+mm;
}else if(to2(va)=='01'&&to3(va)=='01'||to2(va)=='03'&&to3(va)=='01'||to2(va)=='05'&&to3(va)=='01'||to2(va)=='07'&&to3(va)=='01'||to2(va)=='08'&&to3(va)=='01'||to2(va)=='10'&&to3(va)=='01'||to2(va)=='12'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-'+mm;
}else if(to2(va)=='04'&&to3(va)=='29'||to2(va)=='06'&&to3(va)=='29'||to2(va)=='09'&&to3(va)=='29'||to2(va)=='11'&&to3(va)=='29'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-'+mm;
}
}else if(mm=='29'){
if(to3(va)=='29'){
var ccc=to_string(to_int(to2(va))+1);
var ddd=to_string(to_int(to3(va))-1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
}
}
if(tag_s==6){
var nn;
if(validation_year(va.substring(0,4))==1){nn='29'}else{ nn='28'};
if(to2(va)=='02'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-'+nn;
}
else if(to2(va)=='03'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-'+nn;
}
else{
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-'+nn;
}
}
if(tag_s==0){
var xxx;
var ccc=to_string(to_int(to2(va))+1);
var ddd=to_string(to_int(to3(va))-1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
return xxx;
}
var tag_n;
function ok8(va){   
var xxx;
if(to3(va)=='01'&&to2(va)!='02'){
tag_n=1;
}else if(to2(va)=='03'&&to3(va)=='31'||to2(va)=='05'&&to3(va)=='31'||to2(va)=='07'&&to3(va)=='31'||to2(va)=='08'&&to3(va)=='31'||to2(va)=='10'&&to3(va)=='31'||to2(va)=='12'&&to3(va)=='31'){
tag_n=2;
}
else if(to2(va)=='01'&&to3(va)=='31'){
tag_n=4;
}
else if(to2(va)=='01'&&to3(va)=='30'){
tag_n=5;
}
else if(to3(va)=='30'){
tag_n=3;
}
else if(to3(va)=='01'&&to2(va)=='02'){
tag_n=6;
}
else{
tag_n=0;
}
}
function ok3(va){ 
if(tag_n==1){
var xxx;
if(to2(va)=='01'&&to3(va)=='01'||to2(va)=='03'&&to3(va)=='01'||to2(va)=='05'&&to3(va)=='01'||to2(va)=='07'&&to3(va)=='01'||to2(va)=='08'&&to3(va)=='01'||to2(va)=='10'&&to3(va)=='01'||to2(va)=='12'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-31';
}
else if(to2(va)=='04'&&to3(va)=='01'||to2(va)=='06'&&to3(va)=='01'||to2(va)=='09'&&to3(va)=='01'||to2(va)=='11'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-30';
}
else if(to2(va)=='02'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-'+mm;
}
}
if(tag_n==2){
var xxx;
if(to2(va)=='03'&&to3(va)=='31'||to2(va)=='05'&&to3(va)=='31'||to2(va)=='07'&&to3(va)=='31'||to2(va)=='08'&&to3(va)=='31'||to2(va)=='10'&&to3(va)=='31'||to2(va)=='12'&&to3(va)=='31'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-30';
}if(to2(va)=='01'&&to3(va)=='31'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-'+mm;
}else if(to2(va)=='01'&&to3(va)=='01'||to2(va)=='03'&&to3(va)=='01'||to2(va)=='05'&&to3(va)=='01'||to2(va)=='07'&&to3(va)=='01'||to2(va)=='08'&&to3(va)=='01'||to2(va)=='10'&&to3(va)=='01'||to2(va)=='12'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-30';
}
}
if(tag_n==3){
//right
var xxx;
if(to2(va)=='01'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-'+mm;
}else if(to2(va)=='03'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-29';
}
else {
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-29';
}
}
if(tag_n==4){
var year=document.getElementById('1').value;
year=parseInt(year.substring(0,4));
if(validation_year(year)==2){eee='-02';}else{eee='-01';};
if(to2(va)=='01'&&to3(va)=='31'){
var ccc=to_string(to_int(to2(va))+2);
xxx=to1(va)+'-'+ccc+eee;
}else{
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+eee;
}
}
if(tag_n==5){
if((parseInt(to1(va))%4!=0&&parseInt(to1(va))%100==0)||parseInt(to1(va))%400!=0){
if(to2(va)=='01'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va))+2);
xxx=to1(va)+'-'+ccc+'-01';
}else{
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}}
if(mm=='29')
{
if(to2(va)=='01'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va))+1);
if((parseInt(to1(va))%4==0&&parseInt(to1(va))%100!=0)||parseInt(to1(va))%400==0){
xxx=to1(va)+'-'+ccc+'-29';}else{
xxx=to1(va)+'-'+ccc+'-01';
}
}else{
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-29';
}
}
}
if(tag_n==6){
var nn;
if(validation_year(va.substring(0,4))==1){nn='29'}else{ nn='28'};
if(to2(va)=='02'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-'+nn;
}
else if(to2(va)=='03'&&to3(va)=='01'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-'+nn;
}
else{
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-'+nn;
}
}
if(tag_n==0){
var ccc=to_string(to_int(to2(va))+1);
var ddd=to_string(to_int(to3(va))-1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
return xxx;
}  
function validation_year(s){
var year=s;
year=parseInt(year);
var isLeap;
 if (year % 4 == 0){
 if (year % 100 != 0)
  isLeap = 1;
  else{
  if (year % 400 == 0)
 isLeap = 1;
    }
  }
else{isLeap=2;
}
return isLeap;
}
function ok4(va){
if(tag_n==1){
var xxx;
if(to2(va)=='01'&&to3(va)=='31'||to2(va)=='03'&&to3(va)=='31'||to2(va)=='05'&&to3(va)=='31'||to2(va)=='07'&&to3(va)=='31'||to2(va)=='08'&&to3(va)=='31'||to2(va)=='10'&&to3(va)=='31'||to2(va)=='12'&&to3(va)=='31'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}
else if(to2(va)=='02'&&to3(va)==mm||to2(va)=='04'&&to3(va)=='30'||to2(va)=='06'&&to3(va)=='30'||to2(va)=='09'&&to3(va)=='30'||to2(va)=='11'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}else{
var ccc=to_string(to_int(to2(va))+1);
var ddd=to_string(to_int(to3(va))+1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
}
if(tag_n==2){
var xxx;
if(to2(va)=='02'&&to3(va)==mm||to2(va)=='04'&&to3(va)=='30'||to2(va)=='06'&&to3(va)=='30'||to2(va)=='09'&&to3(va)=='30'||to2(va)=='11'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}
else if(to2(va)=='01'&&to3(va)=='30'||to2(va)=='03'&&to3(va)=='30'||to2(va)=='05'&&to3(va)=='30'||to2(va)=='07'&&to3(va)=='30'||to2(va)=='08'&&to3(va)=='30'||to2(va)=='10'&&to3(va)=='30'||to2(va)=='12'&&to3(va)=='30'){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-31';
}
}
if(tag_n==3){
var xxx;
if(to2(va)=='02'&&to3(va)==mm){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}else{
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-30';
}
}
if(tag_n==4){
var year=document.getElementById('1').value;
year=parseInt(year.substring(0,4));

if(validation_year(year)==2){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-03';}
if(validation_year(year)==1){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-02';}
}
if(tag_n==5){
var year=document.getElementById('1').value;
year=parseInt(year.substring(0,4));

if(validation_year(year)==1){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';

}if(validation_year(year)==2){
var ccc=to_string(to_int(to2(va)));
xxx=to1(va)+'-'+ccc+'-02';

}
}
if(tag_n==6){
var nn;
if(validation_year(va.substring(0,4))==1){nn='29'}else{ nn='28'};
var xxx;
if(to2(va)=='02'&&to3(va)==nn){
var ccc=to_string(to_int(to2(va))+1);
xxx=to1(va)+'-'+ccc+'-01';
}
else{
var ccc=to_string(to_int(to2(va)));
var ddd=to_string(to_int(to3(va))+1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
}
if(tag_n==0){
var ccc=to_string(to_int(to2(va)));
var ddd=to_string(to_int(to3(va))+1);
xxx=to1(va)+'-'+ccc+'-'+ddd;
}
return xxx;
}
function oo_m(){
var data_input=document.getElementById('1').value;
var args = data_input.split("-");
var ddd;
if(data_input.substring(data_input.length-5,data_input.length)=='01-01'){
ddd=DayAddDiff(parseInt(args[0]),to_int(args[1]),to_int(args[2]), -1);
}else{
ddd=DayAddDiff(parseInt(args[0])+1,to_int(args[1]),to_int(args[2]), -1);
}
return ddd;
}
function oo_obj(s,k){
var data_input=document.getElementById(s-1+"").value;
var args = data_input.split("-");
var  d=new   Date(args[0],args[1],args[2]);
var  d1=new   Date(args[0],args[1],args[2]);
if(args[1]=='01'||args[1]=='03'||args[1]=='05'||args[1]=='07'||args[1]=='08'||args[1]=='10'||args[1]=='12')
{
d.setDate(d.getDate()+18);
d1.setDate(d1.getDate()+39);
}else if(args[1]=='02'){
d.setDate(d.getDate()+18);
d1.setDate(d1.getDate()+43);
}else{
d.setDate(d.getDate()+18);
d1.setDate(d1.getDate()+41);
}
var val=comptime(d.getFullYear()+'/'+d.getMonth()+'/'+d.getDate(),k.value.replace(/-/g,'/'),d1.getFullYear()+'/'+d1.getMonth()+'/'+d1.getDate())
if(val!=1){
document.getElementById(s+"").value=input_init_value;
alert("会计区间必须在20~~~40天之间");
return false;
}
}
function time_obj(str){
var str1=str.split("-");
var memp;
if(str1[1]=='13'){
memp=parseInt(str1[0])+1+"-01-"+str1[2];
}else{
memp=str;
}
return memp;
}
function time_change(s,k){

if(input_init_value!=k.value){
if(s!=1){
oo_obj(s,k);
ok2(k.value);
for(var i=s+1;i<24;i++){
if(i%2==1)
{
document.getElementById(i).value=time_obj(ok(document.getElementById(i-1).value));
}else{
document.getElementById(i).value=time_obj(ok1(document.getElementById(i-1).value));
}
}
}else{
//oo_obj(s,k);
ok8(k.value);
for(var i=s+1;i<24;i++){
if(i%2==1)
{
document.getElementById(i).value=time_obj(ok4(document.getElementById(i-1).value));
}else{
document.getElementById(i).value=time_obj(ok3(document.getElementById(i-1).value));
}
}
document.getElementById('24').value=to_sky(oo_m());
}
}
}
function to_sky(s){
var r;
if(validation_year(s.substring(0,4))==1){
r=s.replace(/02-30/g,'02-29');
}else{
r=s.replace(/02-30/g,'02-28');
}
return r;
}

function change_year(y){
var va=document.getElementById('year').value;
if(y==1){
document.getElementById('year').value=parseInt(va)+1;
time_init(parseInt(va)+1);

}else{
document.getElementById('year').value=parseInt(va)-1;
time_init(parseInt(va)-1);

}

}


function change_month(y){
var va=document.getElementById('month').value;
if(y==1){
if(parseInt(va)<=11){
if(parseInt(va)==1){
document.getElementById('2').style.background='#33FFFF';
document.getElementById('1').style.background='#33FFFF';
document.getElementById('1').disabled=true;
document.getElementById('2').disabled=true;
document.getElementById('month').value=parseInt(va)+1;
}
else{
document.getElementById('month').value=parseInt(va)+1;
document.getElementById((va)*2+"").style.background='#33FFFF';
document.getElementById((va)*2+"").disabled=true;}
}
}else{
if(parseInt(va)>1){
if((va-1)*2==2){
document.getElementById((va-1)*2+"").style.background='#66CCFF';
document.getElementById('1').style.background='#66CCFF';
document.getElementById('1').disabled=false;
}else{
document.getElementById((va-1)*2+"").style.background='#66CCFF';
}
document.getElementById((va-1)*2+"").disabled=false;
document.getElementById('month').value=parseInt(va)-1;
}
}
}
