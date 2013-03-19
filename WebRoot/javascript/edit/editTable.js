//将指定数据行的objRow的输入域strName设置为strValue

function setInputValue(objRow,strName,strValue){
	
 var objs=objRow.all;

 for(var i=0;i<objs.length;i++){
	 //alert(objs[i].name+"DDD");
	 //alert(strName+"FFF");
  if(objs[i].name==strName){objs[i].value=strValue;}
  if(strName=='product_describe1'&&objs[i].name=='product_describe_ok'){objs[i].innerHTML=strValue;}
}}
var k=0;
//添加一个实例数据行
function addInstanceRow(objTable,Names,Values){
 var tbodyOnlineEdit=objTable.getElementsByTagName("TBODY")[0];
 var theadOnlineEdit=objTable.getElementsByTagName("THEAD")[0];
 var elm = theadOnlineEdit.lastChild.cloneNode(true)
 elm.style.display="";
 for(var i=0;i<Names.length;i++){
 setInputValue(elm,Names[i],Values[i]);
tbodyOnlineEdit.insertBefore(elm);
 }	  
 //window.opener.product_describe_ok[0].innerHTML=pro_value;
k++;
 
}

//将全部复选框设为指定值
function setOnlineEditCheckBox(obj,value){
 var tbodyOnlineEdit=obj.getElementsByTagName("TBODY")[0];
 for (var i=tbodyOnlineEdit.children.length-1; i>=0 ; i-- )
  tbodyOnlineEdit.children[i].firstChild.firstChild.checked=value;
}
//删除一行
function deleteRow(objTable){
 var tbodyOnlineEdit=objTable.getElementsByTagName("TBODY")[0];
 for (var i=tbodyOnlineEdit.children.length-1; i>=0 ; i-- )
  if (tbodyOnlineEdit.children[i].firstChild.firstChild.checked)
   tbodyOnlineEdit.deleteRow(i);
}

//根据唯一标志检查是否有重复记录
function checkRow(objTable,unique) {
 var tbodyOnlineEdit=objTable.getElementsByTagName("TBODY")[0];
 for (var i=tbodyOnlineEdit.children.length-1; i>=0 ; i-- ){
   var temp=tbodyOnlineEdit.children[i].childNodes[1].childNodes[0].value;
   //alert(unique+":"+temp);
   if(unique==temp) return false;
 }
 return true;
}

