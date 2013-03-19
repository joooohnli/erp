/*
 *
 */
function XmlDocument() {}
XmlDocument.create = function () {
	if (document.implementation && document.implementation.createDocument) {
		return document.implementation.createDocument("", "", null);
	} 
}

function serverTree(module_name,tableName){//读取tree-config.xml文件,返回一个table对象
var url=module_name+'/';
var table_obj=new NseerTreeTable();
if (window.ActiveXObject){
var xmlHttp;
xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
try{
xmlHttp.onreadystatechange = function (){
if(xmlHttp.readyState == 4){
if(xmlHttp.status == 200 || xmlHttp.status == 0){

var xmlDOM = xmlHttp.responseXML; 
var treeToot = xmlDOM.documentElement;
var tree_root_tagName=treeToot.getElementsByTagName('table');
for(var i=0;i<tree_root_tagName.length;i++){	
	if(tree_root_tagName[i].getAttribute('name')==tableName){
		table_obj.setName(tree_root_tagName[i].getAttribute('name'));
		table_obj.setDisplayName(tree_root_tagName[i].getAttribute('display-name'));
		table_obj.setStepLength(parseInt(tree_root_tagName[i].getAttribute('step-length')));
		var column_tagName=tree_root_tagName[i].getElementsByTagName('field');
		var column_array=new Array();
			
		for (var i = 0; i < column_tagName.length; i++) {
			var column_obj=new NseerTreeField();	
			column_obj.setName(column_tagName[i].getAttribute('name'));
			column_obj.setDisplayName(column_tagName[i].getAttribute('display-name'));
			if (column_tagName[i].getAttribute('depend') != null) {
				column_obj.setDepend(column_tagName[i].getAttribute('depend'));
			}
			column_array[i]=column_obj;
		}		
		table_obj.setColumnArray(column_array);
	}
}
}
}
};
xmlHttp.open("GET", url+"tree-config.xml", false);
xmlHttp.send(null);
}catch(exception){
alert(exception);
} 
}else{
   var xmlDoc = XmlDocument.create();
	xmlDoc.async = false; 
	xmlDoc.load(url+"tree-config.xml?"+ Math.random());
	if (xmlDoc.documentElement == null) {
		alert("配置文件读取错误，请检查。");
		return null;
	}
	
	var treeToot = xmlDoc.documentElement; 
	var tree_root_tagName=treeToot.getElementsByTagName('table');
for(var i=0;i<tree_root_tagName.length;i++){	
	if(tree_root_tagName[i].getAttribute('name')==tableName){
		table_obj.setName(tree_root_tagName[i].getAttribute('name'));
		table_obj.setDisplayName(tree_root_tagName[i].getAttribute('display-name'));
		table_obj.setStepLength(parseInt(tree_root_tagName[i].getAttribute('step-length')));
		var column_tagName=tree_root_tagName[i].getElementsByTagName('field');
		var column_array=new Array();
			
		for (var i = 0; i < column_tagName.length; i++) {
			var column_obj=new NseerTreeField();	
			column_obj.setName(column_tagName[i].getAttribute('name'));
			column_obj.setDisplayName(column_tagName[i].getAttribute('display-name'));
			if (column_tagName[i].getAttribute('depend') != null) {
				column_obj.setDepend(column_tagName[i].getAttribute('depend'));
			}
			column_array[i]=column_obj;
		}		
		table_obj.setColumnArray(column_array);
	}
}
}
return table_obj;
}

function NseerTreeTable(){
this.name = '';
this.display_name = '';
this.step_length=0;
this.column_array =new Array()||[];
this.setName=function(name){
this.name=name;
}
this.getName=function(){
return this.name;
}
this.setDisplayName=function(display_name){
this.display_name=display_name;
}
this.getDisplayName=function(){
return this.display_name;
}
this.setStepLength=function(step){
this.step_length=step;
}
this.getStepLength=function(){
return this.step_length;
}
this.setColumnArray=function(column_array){
this.column_array=column_array;
}
this.getColumnArray=function(){
return this.column_array;
}
}

function NseerTreeField(){
this.name = '';
this.display_name = '';
this.depend ='';
this.setName=function(name){
this.name=name;
}
this.getName=function(){
return this.name;
}
this.setDisplayName=function(display_name){
this.display_name=display_name;
}
this.getDisplayName=function(){
return this.display_name;
}
this.setDepend=function(depend){
this.depend=depend;
}
this.getDepend=function(){
return this.depend;
}
}