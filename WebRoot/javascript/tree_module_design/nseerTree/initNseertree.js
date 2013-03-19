/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function initMyTree(nseer_tree){//生成tree并且生成tree的一级节点
	var table_obj=serverTree(nseer_tree.moduleName,nseer_tree.tableName);
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
	
	var id=0;
	//设置成同步	
	DWREngine.setAsync(false);
	if(nseer_tree.getNodeByName("No0")!=null&&nseer_tree.getNodeByName("No0")!=""){//如果已经声明了tree，并且创建了根节点
		NseerModuleTreeDB.getNodeInf(id,nseer_tree.tableName,required_array,field_array,{callback:function(msg){
			var data=msg;
	if(data!=null&&data!=""){
		var node1=nseer_tree.getNodeByName("No"+id);
		if(node1!=null&&node1!=""){
			for(var i=0;i<data.length;i++){
				var dbCol=data[i].toString();
				var nodeInf=dbCol.split('☆');
				var nodeName=nodeInf[0].split('◎')[0];
				var nodeShowStr=nodeInf[0].split('◎')[1];
				var myDetailsTag=nodeInf[0].split('◎')[2];
				var myAttributeArray=nodeInf[1].split('◎');
				node1.addNode("No"+nodeName,nodeShowStr,false,myDetailsTag,[field_array,myAttributeArray],'eee.jsp');
			}
		}
	}
		}});//创建一级节点
	}
	//重新设置为异步方式
	DWREngine.setAsync(true);
	nseer_tree.DrawTree(true);
	nseer_tree.setNodeActiveById(1);
	id=0;
}

function initTreeNode(this_node,moduleName,tableName){//生成tree的二级及以下节点,每次打开节点时调用
	var table_obj=serverTree(moduleName,tableName);
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
	DWREngine.setAsync(false);
	NseerModuleTreeDB.getNodeInf(this_node.name.substring(2),tableName,required_array,field_array,{callback:function(msg1){
		if(msg1!=null&&msg1!=''){		
		if(this_node!=null&&this_node!=''){
			for(var i=0;i<msg1.length;i++){
				var dbCol1=msg1[i].toString();
				var nodeInf1=dbCol1.split('☆');
				var nodeName1=nodeInf1[0].split('◎')[0];
				var nodeShowStr1=nodeInf1[0].split('◎')[1];
				var myDetailsTag1=nodeInf1[0].split('◎')[2];
				var myAttributeArray1=nodeInf1[1].split('◎');
				this_node.addNode('No'+nodeName1,nodeShowStr1,false,myDetailsTag1,[field_array,myAttributeArray1],'eee.jsp');
			}
		}
	}else{
	}
	}});
	DWREngine.setAsync(true);
}

/*
//以下为右健
function cls(evt){
	var right_menu_div = document.getElementById("rightMenu");
	var mX=evt.clientX>0?evt.clientX:0;
	var mY=evt.clientY>0?evt.clientY:0;
	var rig_left=parseInt(right_menu_div.style.left);
	var rig_top=parseInt(right_menu_div.style.top);
	var rig_width=parseInt(right_menu_div.style.width);
	var rig_height=parseInt(right_menu_div.style.height);
	//如果鼠标不在右健菜单上
	if((mX<rig_left||mX>(rig_left+rig_width))||(mY<rig_top||mY>(rig_top+rig_height))){
		if(right_menu_div.style.display=="block"){
			right_menu_div.style.display="none";
		}
	}
}
var display_url = 0; // Show URLs in status bar?
function highLight(itemId1,evt1) {
	if(document.getElementById(itemId1)!=null){
		var mySrcElement=window.event?event.srcElement:document.getElementById(itemId1);
		if (mySrcElement.className == "menuItem"){
			mySrcElement.style.backgroundColor = "highlight";
			mySrcElement.style.color = "white";
			if (display_url){
				window.status = mySrcElement.url;
			}
		}
	}
}
function lowLight(itemId2,evt2) {
	if(document.getElementById(itemId2)!=null){
		var mySrcElement=window.event?event.srcElement:document.getElementById(itemId2);
		if (mySrcElement.className == "menuItem"){
			mySrcElement.style.backgroundColor = "";
			mySrcElement.style.color = "black";
			window.status = "";
		}
	}
}*/