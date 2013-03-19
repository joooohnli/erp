/*
 * JavaScript Validation Framework
 *
 * Author: Michael Chen(mechiland) on 2004/03
 * This software is on the http://www.cosoft.org.cn/projects/jsvalidation
 * for update, bugfix, etc, you can goto the homepage and submit your request 
 * and question.
 * Apache License 2.0
 * You should use this software under the terms.
 *
 * Please, please keep above words. At least ,please make a note that such as 
 * "This software developed by Michael Chen(http://www.jzchen.net)" .
 * $Id: validation-framework.js,v 1.2 2008/05/26 05:53:43 nseer Exp $
 */

/** Config Section, Config these fields to make this framework work. **/

// If there is only one config file in your system, use this property. otherwise, use
//     ValidationFramework.init("configfile")     
// instead.
var ValidationRoot = '';
var table_name = '';
var parent_node_id='';
var regOrChg_tag='0';
// the field style when validation fails. it aim to provide more beautiful UI and more good
// experience to the end-user. 
// NOTE: this will be buggy. Please report the error to me.
var ValidationFailCssStyle = "";//border:2px solid #FFCC88;
var bcg="white";
//Validation function. The entry point of the framework.
function setParentNodeId(parent_id){
	parent_node_id=parent_id;
}

function doValidate(path,obj,regOrChg_tag_temp){//path 对应xml配置文件路径及名称,obj 要验证的xml中table节点的name属性值,或直接传入input框等对象(this或其他)
	try{
//******************************************************************************************
    regOrChg_tag=regOrChg_tag_temp||'0';
	ValidationRoot=path;
	var showType="first";
	var showError="";
	/*alert(path);
	alert('type is '+typeof(obj));
	alert('id is '+obj.id);
	alert('name is '+obj.name);
	*/
	if(typeof(obj)=="object"){
	var retStr=ValidationFramework.validateField(obj);
	var errorStrArray = [];
	if (retStr != "OK"){
		errorStrArray[errorStrArray.length] = retStr;
	} else {
		/*var topp=document.getElementById(showError).style.top;
		if(parseInt(topp)>=-1){
			ValidationFramework.divHidden();
		}
		if(document.getElementById('invalid_line')!=null&&document.getElementById('invalid_line')!='undefined'){
		document.body.removeChild(document.getElementById('invalid_line'));}
		return true;*/
	}
	var br = null;
	if (showError != "alert"){
		br = "<br />";
	} else {
		br = "\n";
	}
	if (errorStrArray.length > 0){
		if (showError == "alert"){
			if (showType == "first"){
				alert(errorStrArray[0]);
			}else {
				alert(errorStrArray.join(br));
			}
			
		}else{


var u=window.location.href.split('://')[1].split('/');
var url='';
for(var i=0;i<u.length-3;i++){url+='../';}
			var errObj = document.getElementById(showError);
			if (showType == "first") {
				//alert(showError);
				//errObj.innerHTML ="<div style=\"position:absolute;right:100px;width:300px;height:80px;\"><TABLE width=\"100%\" height=\"100%\" border=\"0\" align=\"center\" cellPadding=\"0\" cellSpacing=\"0\"><TBODY><TR><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0ltop.gif\"></TD><TD width=\"100%\" background=\""+url+"images/bg_01.gif\"></TD><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0rtop.gif\"></TD>   </TR><TR><TD  background=\""+url+"images/bg_03.gif\"></TD><TD><div style=\"width:100%;height:100%;background:#E8E8E8\"><div style=\"height:50px;text-align:center;color:red;padding:10px 0px 0px 0px \">"+errorStrArray[0]+"</div><span style=\"position:absolute;top:10px;right:12px\" onclick=\"ValidationFramework.divHidden()\"><img src=\""+url+"images/gb.gif\" border=\"0\" width=17px;height=17px></span></div></div> </TD><TD  background=\""+url+"images/bg_04.gif\"></TD></TR><TR><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0lbottom.gif\" ></TD><TD background=\""+url+"images/bg_02.gif\"></TD><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0rbottom.gif\"></TD> </TR></TBODY></TABLE></div>";
				//n_A.divShow(errorStrArray[0]);
				//ValidationFramework.divShow(errorStrArray[0]);
				//eval('obj.onblur=function(){return doValidate(\''+path+'\',this);}');	
				var obj_old=obj;
				var w=obj.offsetWidth;
				var h=obj.offsetHeight;
				var x=obj.offsetLeft;
				var y=obj.offsetTop;
				while(obj=obj.offsetParent){
					x+=obj.offsetLeft;
					y+=obj.offsetTop;
				}

				var invalid_line=document.createElement('div');
				invalid_line.id='invalid_line';
				invalid_line.style.background='url(../../images/invalid_line.gif) repeat-x bottom';
				invalid_line.style.position='absolute';
				invalid_line.style.height='2px';
				invalid_line.style.top=y+h-11;
				invalid_line.style.left=x;
				invalid_line.style.width=w;
				var max;
				var divs=document.getElementsByTagName("div");
				for(var i=0,max=0;i<divs.length;i++){max=Math.max(max,divs[i].style.zIndex||0);}
				invalid_line.style.zIndex=(max+1)||10;
				if(document.getElementById('treeButton')==null||document.getElementById('treeButton')=='undefined'){
				if(document.getElementById('invalid_line')!=null&&document.getElementById('invalid_line')!='undefined'){
					document.body.removeChild(document.getElementById('invalid_line'));
				}
				document.body.appendChild(invalid_line);
				}				
				alert(errorStrArray[0]);
				if(document.getElementById('invalid_line')!=null&&document.getElementById('invalid_line')!='undefined'){
					document.body.removeChild(document.getElementById('invalid_line'));
				}
				obj_old.focus();
				return false;
			} 
		}
	}else{
	}
	}else{	
		table_name=obj;
		var reqs=ValidationFramework.getNames();
		if(reqs.length>0){
			for(var r=0;r<reqs.length;r++){
				if(typeof(document.getElementsByName(reqs[r].toLowerCase())[0])!="undefined"){
				var elms=document.getElementsByName(reqs[r].toLowerCase());
				for(var e=0;e<elms.length;e++){
					if(!doValidate(path,elms[e],regOrChg_tag)) return false;
				}
			}else if(typeof(document.getElementsByName(reqs[r])[0])!="undefined"){
				var elms=document.getElementsByName(reqs[r]);
				for(var e=0;e<elms.length;e++){
					if(!doValidate(path,elms[e]),regOrChg_tag) return false;
				}
			}
			}
		}
		else{
			return true;
		}		
	}
//******************************************************************************************

	} catch (e) {
		ValidationFramework.exception(e.name+":" +e.description);
		return false;
	}
	return true;
	
}
/**===================================================================**/
/*
 * JSValidation Framework Code Started 
 * 
 * Please do not modify the code unless you are very familiar with JavaScript.
 * The best way to solve problem is report the problem to our project page.
 * url: http://cosoft.org.cn/projects/jsvalidation
 */
// The Xml document. To process cross-browser. Thanks Eric.
function XmlDocument() {}
XmlDocument.create = function () {
	if (document.implementation && document.implementation.createDocument) {
		return document.implementation.createDocument("", "", null);
	} 
}

function ValidationFramework() {}
ValidationFramework._validationCache = null;
ValidationFramework._currentForm = null;
ValidationFramework._userLanguage="auto";
/**
 * Validate a form.
 * NOTE: the form is Framework virture form, not the HTML Form. 
 * Html Form can be transform to Virture form by 
 *     FormFactory.getFormFromId(htmlFormId);
 * See the doc for more information.
 * @param form the virtual form.
 */
 
/**
 * Validation the field
 * @param filed the field you want to validate.
 */
 //FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
ValidationFramework.validateField = function(field) {
	var fname=field.name;
	var retStr = "OK";
	if(fname!=null&&fname!=""&&typeof(fname)!="undefined"){
		var depends = ValidationFramework.getDeps(fname);
		for (var i = 0; i < depends.length; i++) {
			//alert(depends[i].getName());
			if (!ValidationFramework.validateDepend(field, depends[i])) {
				retStr = ValidationFramework.getErrorString(field, depends[i]);
				return retStr; //Break;
			}
		}	
	}
	else{
		alert('元素未定义name属性');
	}
	return retStr;

}

/**
 * Validate the field depend.
 * This function dispatch the various depends into ValidateMethodFactory.validateXXX
 */
ValidationFramework.validateDepend = function(field, depend) {
	if (depend.getName() == "required") {
		return ValidateMethodFactory.validateRequired(field, depend.getParams());
	} else if (depend.getName() == "integer") {
		return ValidateMethodFactory.validateInteger(field, depend.getParams());
	} else if (depend.getName() == "double") {
		return ValidateMethodFactory.validateDouble(field, depend.getParams());
	} else if (depend.getName() == "commonChar") {
		return ValidateMethodFactory.validateCommonChar(field, depend.getParams());
	} else if (depend.getName() == "chineseChar") {
		return ValidateMethodFactory.validateChineseChar(field, depend.getParams());
	} else if (depend.getName() == "minLength") {
		return ValidateMethodFactory.validateMinLength(field, depend.getParams());
	} else if (depend.getName() == "maxLength") {
		return ValidateMethodFactory.validateMaxLength(field, depend.getParams());
	} else if (depend.getName() == "email") {
		return ValidateMethodFactory.validateEmail(field, depend.getParams());
	} else if (depend.getName() == "date") {
		return ValidateMethodFactory.validateDate(field, depend.getParams());
	} else if (depend.getName() == "time") {
		return ValidateMethodFactory.validateTime(field, depend.getParams());
	} else if (depend.getName() == "mask") {
		return ValidateMethodFactory.validateMask(field, depend.getParams());
	} else if (depend.getName() == "integerRange") {
		return ValidateMethodFactory.validateIntegerRange(field, depend.getParams());
	} else if (depend.getName() == "doubleRange") {
		return ValidateMethodFactory.validateDoubleRange(field, depend.getParams());
	} else if (depend.getName() == "equalsField") {
		return ValidateMethodFactory.validateEqualsField(field, depend.getParams());
	} else if (depend.getName() == "common") {
		return ValidateMethodFactory.validateCommon(field, depend.getParams());
	}else if (depend.getName() == "decimal") {
		return ValidateMethodFactory.validateDecimal(field, depend.getParams());
	}else if (depend.getName() == "duplicate") {
		return ValidateMethodFactory.validateDuplicate(field, depend.getParams());
	}else if (depend.getName() == "chief") {
		return ValidateMethodFactory.validateChief(field, depend.getParams());
	}else if (depend.getName() == "stepNum") {
		return ValidateMethodFactory.validateStepNum(field, depend.getParams());
	}else if (depend.getName() == "n") {
		return true;
	}else {
		ValidationFramework.exception("还未实现该依赖： " + depend.getName());
		return false;
	}
}


// hold the current config file
var _validationConfigFile = "";
ValidationFramework.getDocumentElement = function() {
	if (ValidationFramework._validationCache != null&&file==ValidationRoot) {
		return ValidationFramework._validationCache;
	}
	var file = "";
	if (_validationConfigFile != "") {
		file = _validationConfigFile;
	} else {
		file = ValidationRoot;
	}
/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
if (window.ActiveXObject) {
var http_request = false;
 function send_request() {
  http_request = false;
  if(window.XMLHttpRequest) { 
   http_request = new XMLHttpRequest();
   
  }
  else if (window.ActiveXObject) { 
   try {
    http_request = new ActiveXObject("Msxml2.XMLHTTP");
   } catch (e) {
    try {
     http_request = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (e) {}
   }
  }
  
  http_request.onreadystatechange = processRequest;
  http_request.open("GET", file+"?"+Math.random(), false);
  http_request.send(null);
 }

var root;
var boot;
function processRequest() {
if (http_request.readyState == 4) { 
if (http_request.status == 200) { 
var returnObj = http_request.responseXML;
var xmlobj = http_request.responseXML;
root = xmlobj.documentElement;
boot =returnObj.documentElement;
if (root != null) {
	var fs = root.childNodes;
	for (var i = 0;i < fs.length ;i++ )	{
		if(fs.item(i).getAttribute('name')==table_name){
			root=fs.item(i);
			i = fs.length+1;
		}else if(fs.item(i).tagName=='table'||fs.item(i).tagName=='form'){
			root=fs.item(i);
			i = fs.length+1;
		}
	}
}
}
} 
}
    
send_request();
if (root== null) {
ValidationFramework._validationCache =boot;
}else{
ValidationFramework._validationCache = root;
}
}else{
   var xmlDoc = XmlDocument.create();
	xmlDoc.async = false; 
	xmlDoc.load(file);
	if (xmlDoc.documentElement == null) {
		ValidationFramework.exception("配置文件读取错误，请检查。");
		return null;
	}else{
		var cache_temp=xmlDoc.documentElement;
		var fs = cache_temp.getElementsByTagName('table');
		var fs1 = cache_temp.getElementsByTagName('form');
		if(fs!=null){
		for(var i = 0;i < fs.length ;i++ ){
			if(fs[i].getAttribute('name')==table_name){
				cache_temp=fs[i];
				i = fs.length+1;
			}else if(fs[i].tagName=='table'||fs[i].tagName=='form'){
				cache_temp=fs[i];
				i = fs.length+1;
			}
		}
		}
	if(fs1!=null){
		for(var i = 0;i < fs1.length ;i++ ){
			if(fs1[i].getAttribute('name')==table_name){
				cache_temp=fs1[i];
				i = fs1.length+1;
			}else if(fs1[i].tagName=='table'||fs1[i].tagName=='form'){
				cache_temp=fs1[i];
				i = fs1.length+1;
			}
		}
		}
	}
	ValidationFramework._validationCache = cache_temp;
	}

/*
 * JavaScript Validation Framework
 *
 * Author: Michael Chen(mechiland) on 2004/03
 * This software is on the http://www.cosoft.org.cn/projects/jsvalidation
 * for update, bugfix, etc, you can goto the homepage and submit your request 
 * and question.
 * Apache License 2.0
 * You should use this software under the terms.
 *
 * Please, please keep above words. At least ,please make a note that such as 
 * "This software developed by Michael Chen(http://www.jzchen.net)" .
 * $Id: validation-framework.js,v 1.2 2008/05/26 05:53:43 nseer Exp $
 */	
	
	var lang=ValidationFramework._validationCache.getAttribute("lang");
	ValidationFramework._userLanguage = (lang==null) ? "auto" : lang;
	return ValidationFramework._validationCache;
}

ValidationFramework.init = function(configFile) {
	_validationConfigFile = configFile;
	ValidationFramework.getDocumentElement();
}

ValidationFramework.getErrorString = function(field, depend) {
	var stringResource = null;
	var lang = ValidationFramework._userLanguage.toLowerCase();
	//if lang == auto, get the user's browser language.
	if (lang == "auto") {
		// different browser has the different method the get the 
		// user's language. so this is a stupid way to detect the 
		// most common browser IE and Mozilla.
		if (typeof navigator.userLanguage == 'undefined')
			lang = navigator.language.toLowerCase();
		else
			lang = navigator.userLanguage.toLowerCase();
	}
	// get the language
	if (typeof ValidationErrorString[lang] != 'object') {
		stringResource = ValidationErrorString['zh-cn'];
	} else {
		stringResource = ValidationErrorString[lang];
	}
	var dep = depend.getName().toLowerCase();
	var retStr = stringResource[dep];
	//If the specified depend not defined, use the default error string.
	if (typeof retStr != 'string') {
		retStr = stringResource["default"];
		retStr = retStr.replace("{0}", ValidationFramework.getDisName(field.name));
		return retStr;
	}
	//多语种
	retStr = retStr.replace("{0}", ValidationFramework.getDisName(field.name));
	var alert_sentence0;
	DWREngine.setAsync(false);
	multiLangValidate.dwrGetLang("erp",retStr,{callback:function(msg){alert_sentence0=msg;}});
	DWREngine.setAsync(true);
	retStr=alert_sentence0;
	if (dep == "minlength" || dep == "maxlength" || dep == "date" ) {
		retStr = retStr.replace("{1}", depend.getParams()[0]);
	} else if ( dep == "equalsfield") {
		
		//var eqField = field.getForm().findField(depend.getParams()[0]);
		var eqField = depend.getParams()[0];
		if (eqField == null) {
			ValidationFramework.exception("找不到名称为[" + depend.getParams()[0]+"]的域，请检查xml配置文件。");
			retStr = "<<配置错误>>";
		} else {
			retStr = retStr.replace("{1}", ValidationFramework.getDisName(eqField));
		}
		
	
	} else if (dep == "integerrange" || dep == "doublerange") {
		retStr = retStr.replace("{1}", depend.getParams()[0]);
		retStr = retStr.replace("{2}", depend.getParams()[1]);
	}

	return retStr;
}

ValidationFramework.getWebFormFieldObj = function(field) {
	var obj = null;
	if(typeof(field) == "object"){
		//如果传进来一个对象
		obj=field;
	}
	
	if (obj == null) {
	}
	return obj;
}

ValidationFramework.exception = function(str) {
	var ex = "JavaScript Validation Framework 运行时错误:\n\n";
	ex += str;
	ex += "\n\n\n任何运行错误都会导致该域验证失败。";
	alert(ex);
}
ValidationFramework.getIntegerValue = function(val) {
	var intvalue = parseInt(val);
	if (isNaN(intvalue)) {
		ValidationFramework.exception("期待一个整型参数。");
	}
	return intvalue;
}
ValidationFramework.getFloatValue = function(val) {
	var floatvalue = parseFloat(val);
	if (isNaN(floatvalue)) {
		ValidationFramework.exception("期待一个浮点型参数。");
	}
	return floatvalue;
}
//创建form
/**
 * FormFactory
 * Build virture form from Html Form.
 */
 
/**
 * A form filed. virtual.
 */
function ValidationField() {
	this._name = null;
	this._depends = [];
	this._displayName = null;
	this._onFail = null;
	this._form = null;

	this.getName = function() { return this._name; }
	this.setName = function(p0) { this._name = p0; }

	this.getDepends = function() { return this._depends; }
	this.setDepends = function(p0) { this._depends = p0; }

	this.getDisplayName = function() { return this._displayName; }
	this.setDisplayName = function(p0) { this._displayName = p0; }

	this.getOnFail = function() { return this._onFail; }
	this.setOnFail = function(p0) { this._onFail = p0; }
	
	this.getForm = function() { return this._form; }
	this.setForm = function(p0) { this._form = p0; }

	this.addDepend = function(p0) {
		this._depends[this._depends.length] = p0;
	}
}
//创建form表单下的节点元素
///Factory methods for create Field

/**
 * A validaton depend.
 */
function ValidationDepend() {
	this._name = null;
	this._params = [];

	this.getName = function() { return this._name; }
	this.setName = function(p0) { this._name = p0; }

	this.getParams = function() { return this._params; }
	this.setParams = function(p0) { this.params = p0; }

	this.addParam = function(p0) {
		this._params[this._params.length] = p0;
	}
}

function ValidateMethodFactory() {}
ValidateMethodFactory._methods = [];
//验证是否重复
ValidateMethodFactory.validateDuplicate = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	var flag=true;
	DWREngine.setAsync(false);
	if(regOrChg_tag=='1'){
		if(obj.id.toLowerCase()=='file_id'||obj.name.toLowerCase()=='file_id'){return true;}
		if(document.getElementById('file_id')!=null&&document.getElementById('file_id')!='undefined'){
		var file_id=document.getElementById('file_id').value;
		validateV7.validateDupChange(params[0].split('@')[0],params[0].split('@')[1],params[0].split('@')[2],'file_id',field.value,file_id,parent_node_id,{callback:function(msg){if(msg=="OK"){flag=true;}else{flag=false;}}});
		}
	}else{
	validateV7.validateDuplicateCode(params[0].split('@')[0],params[0].split('@')[1],params[0].split('@')[2],field.value,parent_node_id,{callback:function(msg){if(msg=="OK"){flag=true;}else{flag=false;}}});
	}
	DWREngine.setAsync(true);
	return flag;
}
//验证责任人编号
ValidateMethodFactory.validateChief = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	var flag;
	DWREngine.setAsync(false);
	validateV7.validateDescribe(params[0].split('@')[0],field.value,{callback:function(msg){if(msg=="OK"){flag=true;}else{flag=false;}}});
	DWREngine.setAsync(true);
	return flag;
}
//验证分类编号是否按步长
ValidateMethodFactory.validateStepNum = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	var flag;
	if(regOrChg_tag=='1'){
		if(obj.id.toLowerCase()=='file_id'||obj.name.toLowerCase()=='file_id'){return true;}
	}
	DWREngine.setAsync(false);
	validateV7.validateNumber(parseInt(params[0].split('@')[0]),field.value,{callback:function(msg){if(msg=="OK"){flag=true;}else{flag=false;ValidationErrorString["zh-cn"]["stepnum"]="{0}"+msg;}}});
	DWREngine.setAsync(true);
	return flag;
}
//验证取值非空
ValidateMethodFactory.validateRequired = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);	
	if (obj == null) return true;
	if (typeof(obj.type) == "undefined") {
		var tmp = 0;
		for (var i = 0; i < obj.length; i++) {
			if (obj[i].checked) {
				return true;
			}
		}
		return false;
	}

	if (obj.type == "checkbox" || obj.type == "radio") {
		return (obj.checked);
	} else {
		return !(obj.value.replace(/(^\s*)|(\s*$)/g,"") == "");
	}
}
//验证是否为整数
ValidateMethodFactory.validateInteger = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp = new RegExp("^-?\\d+$");
	return exp.test(obj.value);
}
//验证是否为双精度数
ValidateMethodFactory.validateDouble = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
        var str = new String(obj.value);
        if (str.indexOf(".")==-1) return false;
	var exp = new RegExp("^-?\\d+\.\\d+$");
	return exp.test(obj.value);
}
//验证是否 decimal 类型
ValidateMethodFactory.validateDecimal = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp = new RegExp("^[0-9,.+-]*$");
	return exp.test(obj.value);
}
//验证是否非法字符，长度小于30
ValidateMethodFactory.validateCommon = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp1 = new RegExp("^[\u4E00-\u9FA5\uF900-\uFA2D\u0020\u000D]*$");
	var j=0;
	var n=0;
	for (var i = 0; i < obj.value.length; i++) {
		if(!exp1.test(obj.value.charAt(i))){
			j++;
			if(j>30) n++;
		}else{
			j=0;
		}
	}
	if(n!=0) return false;
	var exp = new RegExp("^[^'\"]*$");
	return exp.test(obj.value);
}
//验证是否为普通英文字符(字母，数字，下划线)
ValidateMethodFactory.validateCommonChar = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp = new RegExp("^[A-Za-z0-9_]*$");
	return exp.test(obj.value);
}
//验证是否为中文字符 
ValidateMethodFactory.validateChineseChar = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp = new RegExp("^[\u4E00-\u9FA5\uF900-\uFA2D]*$");
	return exp.test(obj.value);
}
//验证是否小于最小长度
ValidateMethodFactory.validateMinLength = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	var v = ValidationFramework.getIntegerValue(params[0]);
	return (obj.value.length >= v);
}
//验证是否大于最大长度
ValidateMethodFactory.validateMaxLength = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	var v = ValidationFramework.getIntegerValue(params[0]);
	return (obj.value.length <= v);
}
//验证是否为Email格式
ValidateMethodFactory.validateEmail = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	return ValidateMethodFactory.__checkEmail(obj.value);
}
//验证是否为日期格式
ValidateMethodFactory.validateDate = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return true;
	if (obj.value == "") return true;
	
	var value = obj.value;
	var datePattern = params[0];
	var MONTH = "mm";
	var DAY = "dd";
	var YEAR = "yyyy";
	var orderMonth = datePattern.indexOf(MONTH);
    var orderDay = datePattern.indexOf(DAY);
    var orderYear = datePattern.indexOf(YEAR);
	var bValid = true;
	var dateRegexp = null;

	if ((orderDay < orderYear && orderDay > orderMonth)) {
		var iDelim1 = orderMonth + MONTH.length;
        var iDelim2 = orderDay + DAY.length;
        var delim1 = datePattern.substring(iDelim1, iDelim1 + 1);
        var delim2 = datePattern.substring(iDelim2, iDelim2 + 1);
        if (iDelim1 == orderDay && iDelim2 == orderYear) {
			dateRegexp = new RegExp("^(\\d{1,2})(\\d{1,2})(\\d{4})$");
        } else if (iDelim1 == orderDay) {
			dateRegexp = new RegExp("^(\\d{1,2})(\\d{1,2})[" + delim2 + "](\\d{4})$");
        } else if (iDelim2 == orderYear) {
			dateRegexp = new RegExp("^(\\d{1,2})[" + delim1 + "](\\d{1,2})(\\d{4})$");
        } else {
			dateRegexp = new RegExp("^(\\d{1,2})[" + delim1 + "](\\d{1,2})[" + delim2 + "](\\d{4})$");
        }

        var matched = dateRegexp.exec(value);
        if(matched != null) {
			if (!ValidateMethodFactory.__isValidDate(matched[2], matched[1], matched[3])) {
                bValid =  false;
			}
        } else {
            bValid =  false;
        }
    } else if ((orderMonth < orderYear && orderMonth > orderDay)) { 
		var iDelim1 = orderDay + DAY.length;
        var iDelim2 = orderMonth + MONTH.length;
        var delim1 = datePattern.substring(iDelim1, iDelim1 + 1);
        var delim2 = datePattern.substring(iDelim2, iDelim2 + 1);
        if (iDelim1 == orderMonth && iDelim2 == orderYear) {
			dateRegexp = new RegExp("^(\\d{1,2})(\\d{1,2})(\\d{4})$");
        } else if (iDelim1 == orderMonth) {
			dateRegexp = new RegExp("^(\\d{1,2})(\\d{1,2})[" + delim2 + "](\\d{4})$");
        } else if (iDelim2 == orderYear) {
			dateRegexp = new RegExp("^(\\d{1,2})[" + delim1 + "](\\d{1,2})(\\d{4})$");
        } else {
			dateRegexp = new RegExp("^(\\d{1,2})[" + delim1 + "](\\d{1,2})[" + delim2 + "](\\d{4})$");
        }
        var matched = dateRegexp.exec(value);
		if(matched != null) {
			if (!ValidateMethodFactory.__isValidDate(matched[1], matched[2], matched[3])) {
				bValid = false;
            }
        } else {
			bValid = false;
        }
    } else if ((orderMonth > orderYear && orderMonth < orderDay)) {
		var iDelim1 = orderYear + YEAR.length;
        var iDelim2 = orderMonth + MONTH.length;
        var delim1 = datePattern.substring(iDelim1, iDelim1 + 1);

        var delim2 = datePattern.substring(iDelim2, iDelim2 + 1);
        if (iDelim1 == orderMonth && iDelim2 == orderDay) {
			dateRegexp = new RegExp("^(\\d{4})(\\d{1,2})(\\d{1,2})$");
        } else if (iDelim1 == orderMonth) {
			dateRegexp = new RegExp("^(\\d{4})(\\d{1,2})[" + delim2 + "](\\d{1,2})$");
        } else if (iDelim2 == orderDay) {
			dateRegexp = new RegExp("^(\\d{4})[" + delim1 + "](\\d{1,2})(\\d{1,2})$");
        } else {
			dateRegexp = new RegExp("^(\\d{4})[" + delim1 + "](\\d{1,2})[" + delim2 + "](\\d{1,2})$");
        }
		var matched = dateRegexp.exec(value);
        if(matched != null) {
			if (!ValidateMethodFactory.__isValidDate(matched[3], matched[2], matched[1])) {
                bValid =  false;
            }
        } else {
            bValid =  false;
        }
    } else {
        bValid =  false;
    }
	return bValid;
}
//验证是否为时间格式，未实现
ValidateMethodFactory.validateTime = function(field, params) {
	////NOT IMPLEMENT YET SINCE IT'S NOT USEFUL.
	return true;
}
//验证是否为系统保留字符，(经过更改)
ValidateMethodFactory.validateMask = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return false;
	if (obj.value == "") return true;
	//var exp = new RegExp(params[0]);
	var exp = new RegExp("[⊙◎㊣■◆◇☆★♀]");//把保留字符输入到[]内
	return !exp.test(obj.value);
}
//验证整数范围（大于某数小于某数）
ValidateMethodFactory.validateIntegerRange = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return false;
	if (obj.value == "") return true;
	var p0 = ValidationFramework.getIntegerValue(params[0]);
	var p1 = ValidationFramework.getIntegerValue(params[1]);
	if (ValidateMethodFactory.validateInteger(field)) {
		var v = parseInt(obj.value);
		return (v >= p0 && v <= p1);
	} else {
		return false;
	}
	return true;
}
//验证双精度数范围（大于某数小于某数）
ValidateMethodFactory.validateDoubleRange = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return false;
	if (obj.value == "") return true;
	var p0 = ValidationFramework.getFloatValue(params[0]);
	var p1 = ValidationFramework.getFloatValue(params[1]);
	if (ValidateMethodFactory.validateInteger(field) || ValidateMethodFactory.validateDouble(field)) {
		var v = parseFloat(obj.value);
		return (v >= p0 && v <= p1);
	} else {
		return false;
	}
	return true;
}
//验证当前元素与指定元素的值是否相等，(经过更改)
ValidateMethodFactory.validateEqualsField = function(field, params) {
	var obj = ValidationFramework.getWebFormFieldObj(field);
	if (obj == null) return false;
	//var formObj = document.getElementById(ValidationFramework._currentForm.getId());
	for (var i=0;i<params.length ;i++ )	{
		var fieldObj = document.getElementsByName(params[i]);
		for (var j=0;j<fieldObj.length;j++){
			var eqField = fieldObj[j];
			if (eqField != null) {
				return (obj.value == eqField.value)
			} else {
			return false;	
			}
		}
	}
}

ValidateMethodFactory.__isValidDate = function(day, month, year) {
	if (month < 1 || month > 12) return false;
	if (day < 1 || day > 31) return false;
	if ((month == 4 || month == 6 || month == 9 || month == 11) &&(day == 31)) 
		return false;
    
	if (month == 2) {
		var leap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day == 29 && !leap)) return false;
    }
    
	return true;
}

/**
 * Reference: Sandeep V. Tamhankar (stamhankar@hotmail.com),
 * http://javascript.internet.com
 */
ValidateMethodFactory.__checkEmail = function(emailStr) {                                                  
   if (emailStr.length == 0) {                                                              
       return true;                                                                          
   }                                                                                         
   var emailPat=/^(.+)@(.+)$/;                                                               
   var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]";                                         
   var validChars="\[^\\s" + specialChars + "\]";                                            
   var quotedUser="(\"[^\"]*\")";                                                            
   var ipDomainPat=/^(\d{1,3})[.](\d{1,3})[.](\d{1,3})[.](\d{1,3})$/;                        
   var atom=validChars + '+';                                                                
   var word="(" + atom + "|" + quotedUser + ")";                                             
   var userPat=new RegExp("^" + word + "(\\." + word + ")*$");                               
   var domainPat=new RegExp("^" + atom + "(\\." + atom + ")*$");                             
   var matchArray=emailStr.match(emailPat);                                                  
   if (matchArray == null) {                                                                 
       return false;                                                                         
   }                                                                                         
   var user=matchArray[1];                                                                   
   var domain=matchArray[2];                                                                 
   if (user.match(userPat) == null) {                                                        
       return false;                                                                         
   }                                                                                         
   var IPArray = domain.match(ipDomainPat);                                                  
   if (IPArray != null) {                                                                    
       for (var i = 1; i <= 4; i++) {                                                        
          if (IPArray[i] > 255) {                                                            
             return false;                                                                   
          }                                                                                  
       }                                                                                     
       return true;                                                                          
   }                                                                                         
   var domainArray=domain.match(domainPat);                                                  
   if (domainArray == null) {                                                                
       return false;                                                                         
   }                                                                                         
   var atomPat=new RegExp(atom,"g");                                                         
   var domArr=domain.match(atomPat);                                                         
   var len=domArr.length;                                                                    
   if ((domArr[domArr.length-1].length < 2) ||                                               
       (domArr[domArr.length-1].length > 3)) {                                               
       return false;                                                                         
   }                                                                                         
   if (len < 2) {                                                                            
       return false;                                                                         
   }                                                                                         
   return true;                                                                              
}                                                                                            




//**************************************
//
//以下代码新加入的
//
//**************************************
ValidationFramework.EndV=1;
ValidationFramework.StartV=1;
ValidationFramework.Inc=0.1;
ValidationFramework.timer;
ValidationFramework.timer1=0;
ValidationFramework.timeout=null;
ValidationFramework.divShow=function(a,b){
	if(b!=1){
		if(document.getElementById('nseer_note_div')!=null&&document.getElementById('nseer_note_div')!='undefined'){
			var div1=document.getElementById('nseer_note_div');
			document.body.removeChild(div1);
		}
		ValidationFramework.EndV=1;
		ValidationFramework.StartV=1;
		ValidationFramework.Inc=0.1;
		window.clearTimeout(ValidationFramework.timeout);
	}
	var note_div1=null;
	var u=window.location.href.split('://')[1].split('/');
	var url='';
	for(var i=0;i<u.length-3;i++){url+='../';}
	if(document.getElementById('nseer_note_div')==null||document.getElementById('nseer_note_div')=='undefined'){
	var note_div=document.createElement('div');
	note_div.id='nseer_note_div';
	note_div.style.position='absolute';
	note_div.style.top='-100px';
	note_div.style.left='45%';
	note_div.style.width='350px';
	note_div.innerHTML="<div style=\"position:absolute;right:100px;width:300px;height:80px;background:#F0F3F5\"><TABLE width=\"100%\" height=\"100%\" border=\"0\" align=\"center\" cellPadding=\"0\" cellSpacing=\"0\"><TBODY><TR><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0ltop.gif\"></TD><TD width=\"100%\" background=\""+url+"images/bg_01.gif\"></TD><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0rtop.gif\"></TD>   </TR><TR><TD  background=\""+url+"images/bg_03.gif\"></TD><TD><div style=\"height:50px;text-align:center;color:red;\">"+a+"</div><span style=\"position:absolute;top:2px;right:7px;width:18px;height:18px;cursor:hand;\" onclick=\"ValidationFramework.divHidden()\"><img src=\""+url+"images/gb.gif\" border=\"0\" width=17px;height=17px></span></div></div> </TD><TD  background=\""+url+"images/bg_04.gif\"></TD></TR><TR><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0lbottom.gif\" ></TD><TD background=\""+url+"images/bg_02.gif\"></TD><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0rbottom.gif\"></TD> </TR></TBODY></TABLE></div>";
	document.body.appendChild(note_div);
	note_div1=note_div;
	}
	note_div1=document.getElementById('nseer_note_div');
	if(note_div1.style.top=="") {note_div1.style.top="-100px";}
	if (parseInt(note_div1.style.top)<0) {
		ValidationFramework.StartV = ValidationFramework.StartV + ValidationFramework.Inc;
		MidV = Math.sin(ValidationFramework.StartV) + 1;
		ValidationFramework.EndV = Math.pow(MidV,5);
		var top=parseInt(note_div1.style.top)+ValidationFramework.EndV;
		note_div1.style.top = top +"px";
		ValidationFramework.timeout=window.setTimeout("eval(ValidationFramework.divShow('"+a+"',1))",70);
	} else {
		ValidationFramework.timeout=window.setTimeout("eval(ValidationFramework.divHidden())",3000);
		ValidationFramework.StartV =1;
		ValidationFramework.EndV = 1;
		ValidationFramework.Inc = 0.1;
		a=null;
	}
}
ValidationFramework.divHidden=function() {
	if(document.getElementById('nseer_note_div')!=null&&document.getElementById('nseer_note_div')!='undefined'){
	var note_div2=document.getElementById('nseer_note_div');
	if (parseInt(note_div2.style.top)>-100) {
			ValidationFramework.StartV = ValidationFramework.StartV + ValidationFramework.Inc;
			MidV = Math.sin(ValidationFramework.StartV) + 1;
			ValidationFramework.EndV = Math.pow(MidV,5);
			var top=parseInt(note_div2.style.top)-ValidationFramework.EndV;
			note_div2.style.top = top +"px";
			ValidationFramework.timeout=window.setTimeout("eval(ValidationFramework.divHidden())",50);
	}else{
		document.body.removeChild(note_div2);
		ValidationFramework.StartV =1;
		ValidationFramework.EndV = 1;
		ValidationFramework.Inc = 0.1;
		window.clearTimeout(ValidationFramework.timeout);
		if(document.getElementById('invalid_line')!=null&&document.getElementById('invalid_line')!='undefined'){
			document.body.removeChild(document.getElementById('invalid_line'));
		}
	}
	}
}
//根据传入的field的name，返回ValidationDepend对象数组
ValidationFramework.getDeps=function (name){
	var fields=ValidationFramework.getDocumentElement();
	var f=fields.childNodes;
	var dependss;
	var deps=new Array();
	for (var i=0;i<f.length ;i++ )
	{
		if (f.item(i) == null||typeof(f.item(i).tagName) == 'undefined' ||(f.item(i).tagName != 'column'&&f.item(i).tagName != 'field')||f.item(i).getAttribute('validate')=='n') {
			continue;
		}
		var field=f.item(i);
		//alert(name);
		//alert(field.getAttribute('name'));
		if(name==field.getAttribute('name')||name==field.getAttribute('name').toLowerCase()){
			//alert(name+"  gg  "+field.childNodes.length);
			dependss=field.childNodes;
			i=f.length;
		}		
	}
	if(dependss!=null){
		var bb=0;
		//alert(name+"   aaa  "+dependss.length);
	for (var ii = 0; ii < dependss.length; ii++) {
			var item = dependss.item(ii);
			if (typeof(item.tagName) == 'undefined' || item.tagName != 'depend') {
				continue;
			}
			//alert(name+"       "+item.getAttribute("name"));
			var dp = new ValidationDepend();
			dp.setName(item.getAttribute("name"));
			dp.addParam(item.getAttribute("param0"));
			dp.addParam(item.getAttribute("param1"));
			dp.addParam(item.getAttribute("param2"));
			dp.addParam(item.getAttribute("param3"));
			dp.addParam(item.getAttribute("param4"));
			deps[bb]=dp;
			bb++;
		}	
	}	
	return deps;
}


//根据传入的field的name，返回field的display-name
ValidationFramework.getDisName=function (name){
	var fields=ValidationFramework.getDocumentElement();
	var f=fields.childNodes;
	var display_name='';
	for (var i=0;i<f.length ;i++ )
	{
		if (f.item(i) == null||typeof(f.item(i).tagName) == 'undefined' || (f.item(i).tagName != 'column'&&f.item(i).tagName != 'field')||f.item(i).getAttribute('validate')=='n') {
			continue;
		}
		var field=f.item(i);
		if(name==field.getAttribute('name')||name==field.getAttribute('name').toLowerCase()){
			display_name=field.getAttribute('nick')!=null?field.getAttribute('nick'):field.getAttribute('display-name');
			return display_name;
		}
	}	
}
//得到所有field的name
ValidationFramework.getParentDiv=function (object){
	if(object.tagName!='div'&&object.tagName!='body'){
		ValidationFramework.getParentDiv(object.parenNode);
	}
	return object;
}

ValidationFramework.getNames=function (){
	var fields=ValidationFramework.getDocumentElement();
	//alert(fields.tagName);
	var f=fields.childNodes;
	var names=new Array();
	var a=0;
	for (var i=0;i<f.length ;i++ )
	{
		if (f.item(i) == null||typeof(f.item(i).tagName) == 'undefined' || (f.item(i).tagName != 'column'&&f.item(i).tagName != 'field')||f.item(i).getAttribute('validate')=='n') {
			continue;
		}
		var field=f.item(i);
		names[a]=field.getAttribute('name')!=null?field.getAttribute('name'):field.getAttribute('id');
		a++;
	}	
	return names;
}



////Language Definitions
var ValidationErrorString = new Object();
////Simplified Chinese(zh-ch)
ValidationErrorString["zh-cn"] = new Object();
ValidationErrorString["zh-cn"]["default"]="域{0}校验失败。";
ValidationErrorString["zh-cn"]["required"]="{0}不能为空。";
ValidationErrorString["zh-cn"]["integer"]="{0}必须是一个整数。";
ValidationErrorString["zh-cn"]["double"]="{0}必须是一个浮点数（带小数点）。";
ValidationErrorString["zh-cn"]["commonchar"] = "{0}必须是普通英文字符：字母，数字和下划线。";
ValidationErrorString["zh-cn"]["chinesechar"] = "{0}必须是中文字符。";
ValidationErrorString["zh-cn"]["minlength"]="{0}长度不能小于{1}个字符。";
ValidationErrorString["zh-cn"]["maxlength"]="{0}长度不能大于{1}个字符。" ;
ValidationErrorString["zh-cn"]["invalid"]="{0}无效。";                                                             
ValidationErrorString["zh-cn"]["date"]="{0}不是一个有效日期，期待格式：{1}。";
ValidationErrorString["zh-cn"]["integerrange"]="{0}必须在整数{1}和{2}之间。";
ValidationErrorString["zh-cn"]["doublerange"]="{0}必须在浮点数{1}和{2}之间。";
ValidationErrorString["zh-cn"]["pid"]="{0}不是一个有效身份证号。";
ValidationErrorString["zh-cn"]["email"]="{0}不是一个有效的Email。";
ValidationErrorString["zh-cn"]["equalsfield"]="{0}必须和{1}一致。";
ValidationErrorString["zh-cn"]["decimal"]="{0}必须为数字。";
ValidationErrorString["zh-cn"]["common"]="{0}含有非法字符或字符串超长（汉字除外），请用空格间隔。";
ValidationErrorString["zh-cn"]["duplicate"]="{0}重复，请您重新输入。";
ValidationErrorString["zh-cn"]["chief"]="{0}有误，责任人必须是本系统用户，请返回确认！";
ValidationErrorString["zh-cn"]["stepnum"]="{0}有误，请您重新输入。";
