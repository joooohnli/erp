/*
 * 
 */
function serverValidate(parent_node_id1){
try{
var xmlHttp; 
if(window.ActiveXObject){
xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
} else if(window.XMLHttpRequest){ 
xmlHttp = new XMLHttpRequest(); }
xmlHttp.open("GET", "/erp/Interface/design/input_control/validation-nseer.xml?"+ Math.random(), true);
xmlHttp.send(null);
xmlHttp.onreadystatechange =function (){ 
if(xmlHttp.readyState == 4){ 
if(xmlHttp.status == 200 || xmlHttp.status == 0){
var xmlDOM = xmlHttp.responseXML; 
var root = xmlDOM.documentElement; 
var root_tag=root.getElementsByTagName('form');
for(var t=0;t<root_tag.length;t++){
if(document.getElementById(root_tag[t].getAttribute('id')).style.display=='block'){
root=root_tag[t];
}
}
var fields=new Array();
try { 
var field_tag = root.getElementsByTagName('field');
for(var i=0;i<field_tag.length;i++){
fields[i]=new ValidateField();
fields[i].setName(field_tag[i].getAttribute('name'));
fields[i].setDisplay_name(field_tag[i].getAttribute('display-name'));

var depends_array=new Array();
var depend_tag=field_tag[i].getElementsByTagName('depend');
for(var j=0;j<depend_tag.length;j++){
depends_array[j]=new ValidateDepend();
depends_array[j].setName(depend_tag[j].getAttribute('name'));
if(depend_tag[j].getAttribute('param0')!=null&&depend_tag[j].getAttribute('param0')!=''){
depends_array[j].setParam(depend_tag[j].getAttribute('param0'));
}
}
fields[i].setDepends(depends_array);
}
endValidate1(fields,parent_node_id1);
}catch(exception) { 
} } } } 
}catch(exception){ 
alert("您要访问的资源不存在!");
} 
} 


function endValidate1(fields_obj,parent_node_id1){
for(var m=0;m<fields_obj.length;m++){
DWREngine.setAsync(false);
var depends_obj_array=new Array();
depends_obj_array=fields_obj[m].depends;
for(var n=0;n<depends_obj_array.length;n++){
var depends_obj=depends_obj_array[n].name;
//if(depends_obj_array[n].getParam()!=null&&depends_obj_array[n].getParam()!=''){
var param_value=depends_obj_array[n].param;
//}
var multiLanguage_display_name;
multiLangValidate.dwrGetLang("erp",fields_obj[m].display_name,{callback:function(msg){multiLanguage_display_name=msg;}});
var data_value=document.getElementById(fields_obj[m].name).value;
switch(depends_obj){
case 'required'://required验证：验证是否为为空
validateV7.validateNull(data_value,multiLanguage_display_name,{callback:function(msg){if(msg=="OK"){}else{alert(msg);m=fields_obj.length;n=depends_obj_array.length;}}});
break;
case 'int_num'://int_num验证：验证是否为合法数字
validateV7.validateNumber(data_value,parseInt(param_value),multiLanguage_display_name,{callback:function(msg){if(msg=="OK"){}else{alert(msg);m=fields_obj.length;n=depends_obj_array.length;}}});
break;
case 'duplicate'://duplicate验证：验证是否重复
validateV7.validateDuplicateCode(param_value.split('@')[0],param_value.split('@')[1],param_value.split('@')[2],data_value,parent_node_id1,multiLanguage_display_name,{callback:function(msg){if(msg=="OK"){}else{alert(msg);m=fields_obj.length;n=depends_obj_array.length;}}});
break;
case 'chief'://验证责任人编号是否合法
validateV7.validateDescribe(data_value,param_value.split('@')[2],[param_value.split('@')[0],param_value.split('@')[1]],multiLanguage_display_name,{callback:function(msg){if(msg=="OK"){}else{alert(msg);m=fields_obj.length;n=depends_obj_array.length;}}});
break;
}
}
DWREngine.setAsync(true);
}
}

function ValidateField(){
this.name = "";
this.display_name = "";
this.depends = new Array();
this.setName=function(name){
this.name=name;
}
this.getName=function(){
return this.name;
}
this.setDisplay_name=function(display_name){
this.display_name=display_name;
}
this.getDisplay_name=function(){
return this.display_name;
}
this.setDepends=function(depends){
this.depends=depends;
}
this.getDepends=function(){
return this.depends;
}
}
function ValidateDepend(){
this.name = "";
this.param = "";
this.setName=function(name){
this.name=name;
}
this.getName=function(){
return this.name;
}
this.setParam=function(param){
this.param=param;
}
this.getParam=function(){
return this.param;
}
}