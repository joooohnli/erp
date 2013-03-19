var n_S=new NseerSearch('n_S');
function NseerSearch(name){
    this.Version = "NSEER ERP V7.0-js1.0";
	this.name=name||'n_S';

	this.loadAjaxDiv=function (obj1_id,e){//弹出ajax动态查询数据库层
		if(document.getElementById('s_result_div')!=null){document.body.removeChild(document.getElementById('s_result_div'));}
		var obj1=document.getElementById(obj1_id);
		if(obj1.value!=''){
			var obj_value=obj1.value;
			var w = obj1.offsetWidth;
			var h = obj1.offsetHeight;
			var x =obj1.offsetLeft;
			var y=obj1.offsetTop;
			while(obj1=obj1.offsetParent){
				x+=obj1.offsetLeft;
				y+=obj1.offsetTop;
			}
			var s_result_div=document.createElement('div');
			s_result_div.id='s_result_div';
			s_result_div.style.cssText='position:absolute;background:yellow;height:80px; filter:alpha(opacity=80); overflow-y: auto; overflow-x: hidden;z-index:100;border:1px solid #666;';
			s_result_div.style.left=x;
			s_result_div.style.width=w;	
			s_result_div.style.top=y+h;
			document.body.appendChild(s_result_div);
			this.search_suggest(obj_value,obj1_id,s_result_div,this.name);
			if(document.attachEvent) document.attachEvent('onmousedown',this.closeResult,e);
			if(document.addEventListener) document.addEventListener('mousedown',this.closeResult,e);
		}
	}
	
	this.closeResult=function (e){
		e=e||window.event;
		var scrollTop=0;
		if(document.documentElement&&document.documentElement.scrollTop){
			scrollTop=document.documentElement.scrollTop;
		}else if(document.body){
			scrollTop=document.body.scrollTop;
		}
		var port_X=parseInt(e.clientX);
		var port_Y=parseInt(e.clientY)+scrollTop;
		if(document.getElementById('s_result_div')!='undefined'&&document.getElementById('s_result_div')!=null){
			var div=document.getElementById('s_result_div');
			var div_w=parseInt(navigator.appName=="Microsoft Internet Explorer"?div.currentStyle['width']:document.defaultView.getComputedStyle(div, "").getPropertyValue('width'));
			var div_h=parseInt(navigator.appName=="Microsoft Internet Explorer"?div.currentStyle['height']:document.defaultView.getComputedStyle(div, "").getPropertyValue('height'));
			var div_l=parseInt(navigator.appName=="Microsoft Internet Explorer"?div.currentStyle['left']:document.defaultView.getComputedStyle(div, "").getPropertyValue('left'));
			var div_t=parseInt(navigator.appName=="Microsoft Internet Explorer"?div.currentStyle['top']:document.defaultView.getComputedStyle(div, "").getPropertyValue('top'));
			if(port_X<div_l||port_X>(div_l+div_w)||port_Y<div_t||port_Y>(div_t+div_h)){
				document.body.removeChild(document.getElementById('s_result_div'));
			}
		}
	}

	this.getRStyle=function (elem,IE,FF){//获取定义在css文件里的样式属性值
		try{
			return navigator.appName=="Microsoft Internet Explorer"?elem.currentStyle[IE]:document.defaultView.getComputedStyle(elem, "").getPropertyValue(FF);
		}catch(e){}
	}

	this.search_suggest=function (keyword,obj_id,div_obj,obj_name){//根据输入内容快速查询下拉层
		var search_tag=0;
		var u=window.location.href.split('://')[1].split('?')[0].split('/');
		var url='';
		for(var i=0;i<u.length-3;i++){url+='../';}
		var xmlhttp;
		if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState==4){try {if(xmlhttp.status==200){
				//alert(xmlhttp.responseText);
				var res=xmlhttp.responseText.split("◎");
			if(res.length!=0){
				var div_options =res;
				var conter='';
				for (var i = 1; i < div_options.length; i++) {
					var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
					suggest += 'onclick=\"javascript:eval('+obj_name+').setSearch(\''+div_options[i].split('⊙')[0]+'\',\''+obj_id+'\',\''+div_obj.id+'\');\" ';
					suggest += '><table width="100%"><tr><td align="left">' + div_options[i].split('⊙')[0] + '</td><td align="right">' + div_options[i].split('⊙')[1] + '</td></tr></table></div>';
					conter += suggest;
				}
				div_obj.innerHTML = '';
				div_obj.innerHTML = conter;
			}else{
				document.body.removeChild(document.getElementById(div_obj.id));
			}
			}else {alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
			xmlhttp.open("POST", url+"include/search_ajax.jsp", true);
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send('search_tag=0&&keyword='+encodeURI(keyword));
		}
	}

	this.setSearch=function (input_value,input_id,div_id){
		document.getElementById(input_id).value = input_value;
		document.body.removeChild(document.getElementById(div_id));
	}
	this.resultFormSubmit=function (url,inputTextId1,inputTextId2,validationXml,sub_tag){
		var keyword=document.getElementById(inputTextId1).value;
		var u=window.location.href.split('://')[1].split('?')[0].split('/');
		var url1='';
		for(var i=0;i<u.length-3;i++){url1+='../';}
		var xmlhttp;
		if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState==4){try {if(xmlhttp.status==200){
			}else {alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
			xmlhttp.open("POST", url1+"include/search_ajax.jsp", true);
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send('search_tag=1&&keyword='+encodeURI(keyword));
		}
		if(sub_tag=='0'){//直接搜索
			document.getElementById(inputTextId2).value=keyword;
		}else if(sub_tag=='1'){//在结果中搜索
			document.getElementById(inputTextId2).value=document.getElementById(inputTextId2).value+'⊙'+keyword;
		}else if(sub_tag=='2'){//高级搜索
		}
		keyword=document.getElementById(inputTextId2).value;
		window.location.href=url+'?readXml=n&'+inputTextId2+'='+encodeURI(keyword);
		
	}

	this.advanceSubmit=function (xml,form_id){
		if(document.getElementById('time_select').value!=''){
			var inputa=document.getElementById(document.getElementById('time_select').value+'a');
			var inputb=document.getElementById(document.getElementById('time_select').value+'b');
			if(inputa.value!=''){
				if(!this.searchValidateDate(inputa,['yyyy-mm-dd'])){
					multiLangValidate.dwrGetLang("erp","日期格式不正确",{callback:function(msg){n_A.divShow(msg);}});
					return false;
				}
			}
			if(inputb.value!=''){
				if(!this.searchValidateDate(inputb,['yyyy-mm-dd'])){
					multiLangValidate.dwrGetLang("erp","日期格式不正确",{callback:function(msg){n_A.divShow(msg);}});
					return false;
				}
			}
		}
		if(document.getElementById('num_select').value!=''){
			var inputa=document.getElementById(document.getElementById('num_select').value+'a');
			var inputb=document.getElementById(document.getElementById('num_select').value+'b');
			if(inputa.value!=''){
				if(!this.searchValidateInteger(inputa)){
					multiLangValidate.dwrGetLang("erp","所填数值格式不正确",{callback:function(msg){n_A.divShow(msg);}});
					return false;
				}
			}
			if(inputb.value!=''){
				if(!this.searchValidateInteger(inputb)){
					multiLangValidate.dwrGetLang("erp","所填数值格式不正确",{callback:function(msg){n_A.divShow(msg);}});
					return false;
				}
			}	
		}
		if(!doValidate(xml,form_id)){
			return false;
		}
		document.getElementById(form_id).submit();
	}

	this.showResultDiv=function (div_id){
		if(document.getElementById(div_id)!=null&&document.getElementById(div_id)!='undefined'){
		loadCover(div_id);
		document.getElementById(div_id).style.display='block';
		}else{
		alert('该页面暂不支持该功能!');
		}
	}

	this.addRow=function (table_id,img_id,option) {//动态添加行
		var table_obj = document.getElementById(table_id);
	var option_chain='';
	var option_array=new Array();
	if(option!=''){
	option_array=option.substring(1).split('⊙');
	for(var i=0;i<option_array.length;i++){
	option_chain+='<option value="'+option_array[i].split('◎')[0]+'">'+option_array[i].split('◎')[1]+'</option>';
	}
	}
	if(img_id.split('_')[1]=='str'){
	var row_current=parseInt(img_id.split('_')[0].substring(3))+1;
    var tr = table_obj.insertRow(row_current);
	var td=tr.insertCell(-1);
	td.className='TD_STYLE1';
	td.style.width='15%';
	td.style.textAlign='center';
	td.innerHTML='字符条件';
	var td1=tr.insertCell(-1);
	td1.style.width='35%';
	td1.innerHTML='<select type="text" class="INPUT_STYLE1" id="str_select" name="str_select" style="width: 90%" onchange="'+this.name+'.selectChange(this.id);">'+option_chain+'</select>';
	var td2=tr.insertCell(-1);
	td2.colSpan='3';
	td2.style.width='45%';
	td2.innerHTML='<input type="text"  style="background-color:#FFFFCC;width:100%;BORDER: 1px #C9E1FA solid;" name="keyword1" onfocus="this.blur();">';
	var td3=tr.insertCell(-1);
	td3.style.width='5%';
	td3.innerHTML='<img src="../../images/add_blue.png"  id="add0_str" onclick="'+this.name+'.addRow(\'table_advance\',this.id,\''+option+'\');">&nbsp;<img src="../../images/remove_blue.png" id="remove0_str" onclick="'+this.name+'.delRow(\'table_advance\',this.id);">';	
	}else if(img_id.split('_')[1]=='time'){
	var row_current=parseInt(img_id.split('_')[0].substring(3))+1;
    var tr = table_obj.insertRow(row_current);
	var td=tr.insertCell(-1);
	td.className='TD_STYLE1';
	td.style.width='15%';
	td.style.textAlign='center';
	td.innerHTML='时间区间';
	var td1=tr.insertCell(-1);
	td1.style.width='35%';
	td1.innerHTML='<select type="text" class="INPUT_STYLE1" id="time_select" name="time_select" style="width: 90%" onchange="'+this.name+'.selectChange(this.id);">'+option_chain+'</select>';
	var td2=tr.insertCell(-1);
	td2.style.width='20%';
	td2.innerHTML='<input type="text" style="background-color:#DDFCB4;width:100%;BORDER: 1px #C9E1FA solid;" name="timea" onfocus="this.blur();">';
	var td3=tr.insertCell(-1);
	td3.className='TD_STYLE1';
	td3.style.width='5%';
	td3.align='center';
	td3.innerHTML='至';
	var td4=tr.insertCell(-1);
	td4.style.width='20%';
	td4.innerHTML='<input type="text" style="background-color:#DDFCB4;width:100%;BORDER: 1px #C9E1FA solid;" name="timeb" onfocus="this.blur();">';
	var td5=tr.insertCell(-1);
	td5.style.width='5%';
	td5.innerHTML='<img src="../../images/add_blue.png"  id="add0_time" onclick="'+this.name+'.addRow(\'table_advance\',this.id,\''+option+'\');">&nbsp;<img src="../../images/remove_blue.png" id="remove0_time" onclick="'+this.name+'.delRow(\'table_advance\',this.id);">';	
	}else if(img_id.split('_')[1]=='num'){
	var row_current=parseInt(img_id.split('_')[0].substring(3))+1;
    var tr = table_obj.insertRow(row_current);
	var td=tr.insertCell(-1);
	td.className='TD_STYLE1';
	td.style.width='15%';
	td.style.textAlign='center';
	td.innerHTML='数值区间';
	var td1=tr.insertCell(-1);
	td1.style.width='35%';
	td1.innerHTML='<select type="text" class="INPUT_STYLE1" id="num_select" name="num_select" style="width: 90%" onchange="'+this.name+'.selectChange(this.id);">'+option_chain+'</select>';
	var td2=tr.insertCell(-1);
	td2.style.width='20%';
	td2.innerHTML='<input type="text" style="background-color:#FFC993;width:100%;BORDER: 1px #C9E1FA solid;" name="numa" onfocus="this.blur();">';
	var td3=tr.insertCell(-1);
	td3.className='TD_STYLE1';
	td3.style.width='5%';
	td3.align='center';
	td3.innerHTML='至';
	var td4=tr.insertCell(-1);
	td4.style.width='20%';
	td4.innerHTML='<input type="text" style="background-color:#FFC993;width:100%;BORDER: 1px #C9E1FA solid;" name="numb" onfocus="this.blur();">';
	var td5=tr.insertCell(-1);
	td5.style.width='5%';
	td5.innerHTML='<img src="../../images/add_blue.png"  id="add0_num" onclick="'+this.name+'.addRow(\'table_advance\',this.id,\''+option+'\');">&nbsp;<img src="../../images/remove_blue.png" id="remove0_num" onclick="'+this.name+'.delRow(\'table_advance\',this.id);">';	
	}
	var row_num = table_obj.rows.length;
     	for(var i=0;i<row_num;i++){
     		var img_array=table_obj.rows[i].getElementsByTagName('img');     		
			var a=img_array[0].id.split('_');
			var b=img_array[1].id.split('_');
			img_array[0].id=a[0].substring(0,3)+i+'_'+a[1];
			img_array[1].id=b[0].substring(0,6)+i+'_'+b[1];
			table_obj.rows[i].id='tr'+i;
			var select=table_obj.rows[i].getElementsByTagName('select');
			if(img_array[0].id.split('_')[1]=='str'){
				select[0].id='str_select'+i;
			}else if(img_array[0].id.split('_')[1]=='time'){
				select[0].id='time_select'+i;
			}else if(img_array[0].id.split('_')[1]=='num'){
				select[0].id='num_select'+i;
			}
     	}
	}

	this.delRow=function (table_id,img_id) {//删除选定的行，并对所有行和相关层重新排序
	 var c=img_id.split('_');
     var table_obj = document.getElementById(table_id);
	 var row_num = table_obj.rows.length;
	 var img_array0=table_obj.getElementsByTagName('img');
	 var n=0;
	 for(var i=0;i<img_array0.length;i++){
		if(img_array0[i].id.split('_')[1]==c[1]){
			n++;
		}
	 }
	 if(n>2){
	 table_obj.deleteRow(parseInt(c[0].substring(6)));
	 row_num = table_obj.rows.length;
     	for(var i=0;i<row_num;i++){
     		var img_array=table_obj.rows[i].getElementsByTagName('img');      		
			var a=img_array[0].id.split('_');    		
			var b=img_array[1].id.split('_');
			img_array[0].id=a[0].substring(0,3)+i+'_'+a[1];
			img_array[1].id=b[0].substring(0,6)+i+'_'+b[1];
			table_obj.rows[i].id='tr'+i;
     	}
	 }
	}

	this.selectChange=function (sel_id){
		var d=document.getElementById&&!document.all;
var obj=document.getElementById(sel_id);
var input_name=obj.value;
var inp_tag=0;
if(input_name==''){inp_tag=1;}else{inp_tag=0;}
while(obj.tagName.toLowerCase()!='tr'){
	obj=d?obj.parentNode:obj.parentElement;
}
var input_array=obj.getElementsByTagName('input');
if(sel_id.split('_')[0]=='str'){
	input_array[0].name=input_name;
input_array[0].id=input_name;
if(inp_tag==0){
input_array[0].onfocus=function(){this.focus();};
}else if(inp_tag==1){
input_array[0].onfocus=function(){this.blur();};
}
}else if(sel_id.split('_')[0]=='time'){
input_array[0].name=input_name+'a';
input_array[1].name=input_name+'b';
input_array[0].id=input_name+'a';
input_array[1].id=input_name+'b';
Calendar.setup ({inputField : input_array[0].id, ifFormat : "%Y-%m-%d", showsTime : false, button : input_array[0].id, singleClick : true, step : 1});
Calendar.setup ({inputField : input_array[1].id, ifFormat : "%Y-%m-%d", showsTime : false, button : input_array[1].id, singleClick : true, step : 1});
if(inp_tag==0){
input_array[0].onfocus=function(){this.focus();};
input_array[1].onfocus=function(){this.focus();};
}else if(inp_tag==1){
input_array[0].onfocus=function(){this.blur();};
input_array[1].onfocus=function(){this.blur();};
}
}else if(sel_id.split('_')[0]=='num'){
input_array[0].name=input_name+'a';
input_array[1].name=input_name+'b';
input_array[0].id=input_name+'a';
input_array[1].id=input_name+'b';
if(inp_tag==0){
input_array[0].onfocus=function(){this.focus();};
input_array[1].onfocus=function(){this.focus();};
}else if(inp_tag==1){
input_array[0].onfocus=function(){this.blur();};
input_array[1].onfocus=function(){this.blur();};
}
}
	}

	this.searchValidateDate=function  (field, params) {
		var obj = field;
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
			if (!this.isValidDate(matched[2], matched[1], matched[3])) {
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
			if (!this.isValidDate(matched[1], matched[2], matched[3])) {
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
			if (!this.isValidDate(matched[3], matched[2], matched[1])) {
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

	this.isValidDate=function (day, month, year) {
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

	this.searchValidateInteger=function  (field) {
		var obj = field;
	if (obj == null) return true;
	if (obj.value == "") return true;
	var exp = new RegExp("^-?\\d+$");
	return exp.test(obj.value);
	}
}