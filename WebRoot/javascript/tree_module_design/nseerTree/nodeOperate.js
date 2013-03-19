/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
////////////////////////////////////////////////////////////////////////////////
/*
 * 文件涉及主要参数及变量：
 * nseer_tree  字符串，页面上创建tree时声明的tree名字
 * chief_array 数组，该数组读取tree-config.xml文件，把tree的固定元素保存起来，具体是
 * 					chief_array[0]="CATEGORY_ID"
 * 					chief_array[1]="PARENT_CATEGORY_ID"
 * 					chief_array[2]="CATEGORY_NAME"
 *					chief_array[3]="DETAILS_TAG" 
 *					chief_array[4]="FILE_ID"
 *				    chief_array[5]="FILE_NAME"
 *					以上几个是树必须的元素，所以是固定的，包括在xml文件中配置时的前后顺序
 */

var bc_tag;//是在做添加同级(0)还是添加下级(1)操作
function showAddBrotherDiv(nseer_tree,css_file,xml_file,url){//点击添加同级按钮时创建层
	var first_xml_file=xml_file.split(',')[0];
	var other_xml_file=xml_file.split(',').length==1?xml_file.split(',')[0]:xml_file.split(',')[1];
	var node=eval(nseer_tree).getSelectNode();
	if(node==null||node.deepID==0){return false;}
	//if(node.deepID==1){//给一级节点添加同级
	//	readXml(css_file,url+first_xml_file);//读取xml文件创建层
	//}else{//给二级及以下节点添加同级
		readXml(css_file,url+other_xml_file);
	//}
	bc_tag=0;
	//node=Nseer_tree.node_list[node.pid];
	DWREngine.setAsync(false);
	multiLangValidate.dwrGetLang("erp",'添加同级',{callback:function(msg){document.getElementById('current').innerHTML='<a href="javascript:void(0);"><span align="center">'+msg+'</span></a>';}});
	DWREngine.setAsync(true);
}

function showAddChildDiv(nseer_tree,css_file,xml_file,url){//点击添加下级按钮时创建层
	var first_xml_file=xml_file.split(',')[0];
	var other_xml_file=xml_file.split(',').length==1?xml_file.split(',')[0]:xml_file.split(',')[1];
	var node=eval(nseer_tree).getSelectNode();
	if(node==null){return false;}
	//if(node.deepID==0){//给根节点节点添加下级
	//	readXml(css_file,url+first_xml_file);
	//}else{//给一级及以下节点添加下级
		readXml(css_file,url+other_xml_file);
	//}
	bc_tag=1;
}

function showDeleteDiv(nseer_tree,css_file,xml_file,url){//点击删除所选按钮时创建层
	var node=eval(nseer_tree).getSelectNode();
	if(node==null||node.deepID==0){return false;}
		readXml(css_file,url+xml_file);
}

function showChangeDiv(nseer_tree,css_file,xml_file,url){//点击修改所选按钮时创建层
	
	afterChangeDiv(eval(nseer_tree));	
	var first_xml_file=xml_file.split(',')[0];
	var other_xml_file=xml_file.split(',').length==1?xml_file.split(',')[0]:xml_file.split(',')[1];
	var node=eval(nseer_tree).getSelectNode();	
	if(node==null||node.deepID==0){return false;}
	if(node.deepID==1){//修改一级节点
		readXml(css_file,url+first_xml_file);
	}else{//修改二级及以下节点
		readXml(css_file,url+other_xml_file);
	}
	var table_obj=serverTree(eval(nseer_tree).moduleName,eval(nseer_tree).tableName);
	var field_array=new Array();
	var a=0;
	for(var i=0;i<table_obj.column_array.length;i++){//根据从xml文件中读取出来的字段，在页面上document.getElementById,如果得到把该字段保存到field_array
			var page_id=table_obj.column_array[i].name.toLowerCase();
			var page_obj=document.getElementById(page_id);
			if(page_obj==null||typeof(page_obj)=='undefined'){continue;}
			field_array[a]=page_id;
			a++;
		}
	var chief_array=[table_obj.column_array[1].name.toLowerCase(),table_obj.column_array[2].name.toLowerCase(),table_obj.column_array[3].name.toLowerCase(),table_obj.column_array[4].name.toLowerCase(),table_obj.column_array[5].name.toLowerCase(),table_obj.column_array[6].name.toLowerCase()];
	DWREngine.setAsync(false);
	NseerModuleTreeDB.getSingleNodeInf(node.name.substring(2),eval(nseer_tree).tableName,field_array,chief_array,{callback:function(data_array){
		for(var i=0;i<field_array.length;i++){//为页面元素赋值
			document.getElementById(field_array[i]).value=data_array[i];
			if(field_array[i]==chief_array[4]){//该hidden元素用于存储编号，在判断用户是否修改编号时使用
				document.getElementById(chief_array[4]+'_hidden').value=data_array[i];
			}
		}		
	}});
	DWREngine.setAsync(true);
}

function showQueryDiv(nseer_tree,css_file,xml_file,url){//点击快速查询按钮时创建层
		readXml(css_file,url+xml_file);
}

function addTreeNode(nseer_tree){//点击'确定'按钮添加同级或下级
	//用户自定义方法接口
	beforeAddTreeNode();
	{
		//系统通用方法
		var node=eval(nseer_tree).getSelectNode();
		if(node.deepID==0){//如果选择的是根节点
		    //setParentNodeId()方法在validation-framework.js文件中定义
			setParentNodeId('-1');//为validation-framework.js传入父节点的category_id
		}else{
			setParentNodeId(eval(nseer_tree).node_list[node.pid].name.substring(2));
		}
		if (!doValidate(eval(nseer_tree).moduleName+'/tree-config.xml',eval(nseer_tree).tableName)) {//对用户输入做验证		
			return false;
		}
		//验证通过，开始添加
		var data_array=new Array();
		var field_array=new Array();
		var a=0;
		var table_obj=serverTree(eval(nseer_tree).moduleName,eval(nseer_tree).tableName);
		var file_id=document.getElementById(table_obj.column_array[5].name.toLowerCase()).value;
		var file_name=document.getElementById(table_obj.column_array[6].name.toLowerCase()).value;
		var chief_array=[table_obj.column_array[1].name.toLowerCase(),table_obj.column_array[2].name.toLowerCase(),table_obj.column_array[3].name.toLowerCase(),table_obj.column_array[4].name.toLowerCase(),table_obj.column_array[5].name.toLowerCase(),table_obj.column_array[6].name.toLowerCase()];
		for(var i=0;i<table_obj.column_array.length;i++){//根据从xml文件中读取出来的字段，在页面上document.getElementById,如果得到把该字段及对应页面上的value值存储起来
			var page_id=table_obj.column_array[i].name.toLowerCase();			
			var page_obj=document.getElementById(page_id);
			if(page_obj==null||typeof(page_obj)=='undefined'){continue;}
			field_array[a]=page_id;
			data_array[a]=page_obj.value;
			a++;
		}
		var parent_node;
		if (bc_tag == 0) {//bc_tag,唯一全局变量,表示是在做添加同级(0)还是添加下级(1)操作
			parent_node = eval(nseer_tree).node_list[node.pid];//得到node的父节点
		}else if(bc_tag==1){
			parent_node=node;
		}
		if(parent_node.child_list.length==0&&parent_node.detailsTag==1){//当初次载入tree时，打开文件夹图标节点
	 		initTreeNode(parent_node,eval(nseer_tree).moduleName,eval(nseer_tree).tableName);
		}
		doAddNode(eval(nseer_tree).tableName,table_obj.column_array[1].name,parent_node,file_id,file_name,field_array,data_array,chief_array,table_obj.step_length);
	}
	//用户自定义方法接口
	afterAddTreeNode();
}

function deleteNode(nseer_tree){//删除节点
	//用户自定义方法接口
	beforeDeleteNode();
	{
		//系统通用方法
		//if (!doValidate('')) {//对用户输入做验证
		//	return false;
		//}
		//验证通过，开始添加
		var table_obj=serverTree(eval(nseer_tree).moduleName,eval(nseer_tree).tableName);
		var chief_array=[table_obj.column_array[1].name.toLowerCase(),table_obj.column_array[2].name.toLowerCase(),table_obj.column_array[3].name.toLowerCase(),table_obj.column_array[4].name.toLowerCase(),table_obj.column_array[5].name.toLowerCase(),table_obj.column_array[6].name.toLowerCase()];
		var node=eval(nseer_tree).getSelectNode();
		if(node!=null&&node.deepID!=0){
	  	var id1=node.name.substring(2);
		NseerModuleTreeDB.deleteNodeInf(id1,chief_array,eval(nseer_tree).tableName,{callback:function(str){
			if (str == '200') {
				node.removeAllChildren();
				node.remove();
			}
		}});
		}		
	}
	//用户自定义方法接口
	afterDeleteNode();
	n_D.closeDiv('remove');
}

function changeNode(nseer_tree){//修改所选节点,类似添加节点时
	//用户自定义方法接口
	beforeChangeNode();
	{
		//系统通用方法
		//if (!doValidate('')) {//对用户输入做验证
		//	return false;
		//}
		var node=eval(nseer_tree).getSelectNode();
		var data_array=new Array();
		var field_array=new Array();
		var a=0;
		var table_obj=serverTree(eval(nseer_tree).moduleName,eval(nseer_tree).tableName);
		var step_length=table_obj.step_length;
		var file_id=document.getElementById(table_obj.column_array[5].name.toLowerCase()).value;
		var file_id_hidden=document.getElementById(table_obj.column_array[5].name.toLowerCase()+'_hidden').value;
		var file_name=document.getElementById(table_obj.column_array[6].name.toLowerCase()).value;
		var chief_array=[table_obj.column_array[1].name.toLowerCase(),table_obj.column_array[2].name.toLowerCase(),table_obj.column_array[3].name.toLowerCase(),table_obj.column_array[4].name.toLowerCase(),table_obj.column_array[5].name.toLowerCase(),table_obj.column_array[6].name.toLowerCase()];	
		DWREngine.setAsync(false);
		NseerModuleTreeDB.changeNodeInf(eval(nseer_tree).tableName,node.name.substring(2),file_id,file_id_hidden,file_name,chief_array,step_length,{callback:function(parent_node_name){
			if(file_id==file_id_hidden||file_id.substring(0,file_id.length-step_length)==file_id_hidden.substring(0,file_id_hidden.length-step_length)){				
				node.setShowStr(file_id+' '+file_name);
			}else{
				var node_name=node.name;
				node.removeAllChildren();
				node.remove();
				var parent_node=eval(nseer_tree).getNodeByName('No'+parent_node_name);
				parent_node.addNode(node_name,file_id+' '+file_name,false,'0',data_array,'eee.jsp');
			}
		}});
		DWREngine.setAsync(true);
	}
	
	//用户自定义方法接口
	afterChangeNode(eval(nseer_tree));
	n_D.closeDiv('remove');
}

function quickSearchNode(nseer_tree){//快速查询
	//用户自定义方法接口
	beforeQuickSearchNode();
	{
		//系统通用方法
		//if (!doValidate('')) {//对用户输入做验证
		//	return false;
		//}
		//验证通过，开始添加
		var table_obj=serverTree(eval(nseer_tree).moduleName,eval(nseer_tree).tableName);
		var field_array=new Array();
		var required_array=new Array();
		var m=0;n=0;
	
		for(var i=0;i<table_obj.column_array.length;i++){
			if(table_obj.column_array[i].depend=='nodeAttribute'){//需要返回作为节点属性的数据表列名
				field_array[m]=table_obj.column_array[i].name;
				m++;
			}
			if(table_obj.column_array[i].depend=='required'){//数据表中必须存在的列名，tree依赖于这几个字段，注意，xml配置时有顺序!
				required_array[n]=table_obj.column_array[i].name;
				n++;
			}
		}
		
		var key_word=document.getElementById('keyword').value;//快速查询的层中，录入框的id必须为keyword,此处为固定的，待以后优化
		if(key_word!=null){
			var rootnode=eval(nseer_tree).getNodeByName("No0");
			rootnode.removeAllChildren();
			rootnode.setShowStr(rootnode.showStr.split("搜索")[0]+" 搜索 \""+key_word+"\"的结果");
			if(rootnode!=null&&rootnode!=""){
				DWREngine.setAsync(false);
				NseerModuleTreeDB.getNodeInfBySearch(key_word,eval(nseer_tree).tableName,required_array,field_array,{callback:function(result){
					for(var i=0;i<result.length;i++){
					var dbCol=result[i].toString();
					var nodeInf=dbCol.split('☆');
					var nodeName=nodeInf[0].split('◎')[0];
					var nodeShowStr=nodeInf[0].split('◎')[1];
					var myDetailsTag=nodeInf[0].split('◎')[2];
					var myAttributeArray=nodeInf[1].split('◎');
					rootnode.addNode("No"+nodeName,nodeShowStr,false,'0',myAttributeArray);
					}
				}});//创建一级节点
	  			DWREngine.setAsync(true);
			}  		
		}
	}
	//用户自定义方法接口
	afterQuickSearchNode();
	n_D.closeDiv('remove');	
}

function doAddNode(table_name,category_id,parent_node,file_id,file_name,field_array,data_array,chief_array,step_length){//实际节点的添加动作在此执行	
	if(parent_node!=null){
		DWREngine.setAsync(false);
		NseerModuleTreeDB.getNodeName(table_name,category_id,{callback:function(str){
			var nodeName='No'+str;
			if(nodeName=='No'){
				alert('tree-config.xml文件错误或数据库根节点不存在');
				return false;
			}
/*    if(parent_node.deepID==0){//添加一级节点
	var picture='';
    var pic=document.getElementById('nseer_picture').getElementsByTagName('input');//得radio数组	 
	for(var i=0;i<pic.length;i++){
	if(pic[i].type=='radio'){//得类型为radio的
    if(pic[i].checked==true){
     picture=pic[i].value;//选中的值
	}
	}
	}
    NseerModuleTreeDB.insertNodeInf(table_name,str,parseInt(parent_node.name.substring(2)),file_id+' '+file_name,data_array,field_array,chief_array,document.getElementById('reason').value,document.getElementById('hreflink').value,picture,{callback:function(str){
	parent_node.addNode(nodeName,file_id+' '+file_name,false,'0',data_array,'eee.jsp');
	n_D.closeDiv('remove');//定义在javascript/include/div/divViewChange.js中定义,关闭层
	}});
}else*/
	{//添加其他级节点
    var picture='';
    var pic=document.getElementById('nseer_picture').getElementsByTagName('input');//得radio数组
    for(var i=0;i<pic.length;i++){
	if(pic[i].type=='radio'){
    if(pic[i].checked==true){
    picture=pic[i].value;//选中的值
	}
	}
	}	NseerModuleTreeDB.getFileId(table_name,chief_array,parseInt(parent_node.name.substring(2)),step_length,{callback:function(fileId){
	for(var i=0;i<field_array.length;i++){
	if(field_array[i]==chief_array[4]){
				data_array[i]=fileId;
	}
	}
	NseerModuleTreeDB.insertNodeInf(table_name,str,parseInt(parent_node.name.substring(2)),fileId+' '+file_name,data_array,field_array,chief_array,document.getElementById('reason').value,document.getElementById('hreflink').value,picture,{callback:function(str){                
	parent_node.addNode(nodeName,fileId+' '+file_name,false,'0',data_array,'eee.jsp');
	n_D.closeDiv('remove');
				}});
			}});
		}
		}});
		DWREngine.setAsync(true);
	}
}
function doubleClick(evt,nseer_tree){//双击节点时执行
	var dbnode=eval(nseer_tree).getSelectNode();	
	if(eval(nseer_tree).getNodeByName("No0").showStr.indexOf("搜索")!=-1){//如果是搜索出来的结果
		//afterDoubleClick();
	}
	else{
	 if(dbnode.child_list.length==0&&dbnode.detailsTag==1){//当初次载入tree时，打开文件夹图标节点
	 		initTreeNode(dbnode,eval(nseer_tree).moduleName,eval(nseer_tree).tableName);
	}else if(dbnode.child_list.length!=0){//当节点已被打开过时，打开或关闭文件夹图标节点
		eval(nseer_tree).openNode(dbnode.id);
	}else{//节点没有下级时默认弹出修改层,用户可在接口方法中添加自己操作或通过return中断弹出修改层
		afterDoubleClick();//用户操作接口
		var url=eval(nseer_tree).moduleName+'/';
		var xml_obj=getXmlObj(eval(nseer_tree).moduleName,eval(nseer_tree).tableName);
		showChangeDiv(xml_obj.getAttribute('tree-name'),xml_obj.parentNode.getAttribute('css'),xml_obj.getAttribute('change-node'),url);
	}
	}
}

