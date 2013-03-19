var suggest_tag=0;


function search_suggest1(obj,div_width,tag){//该函数利用ajax实现自动查询数据库
var url='../../hr/file/register_search.jsp';
if(tag=='3'){url='../../../hr/file/register_search.jsp';}
if(tag=='2'){url='../../hr/file/register_search.jsp';}
var keyword=document.getElementById(obj).value;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
var cla=document.getElementById('search_suggest');
cla.innerHTML='';
if(parseInt(xmlhttp3.responseText)==179206725){
	document.getElementById('search_suggest').style.display='none';
	}else{
var options =xmlhttp3.responseText.split("\n");
var conter='';
for (var i = 0; i < options.length-1; i++) {
var suggest = '<div onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+obj+'\');\" ';
suggest += '>' + options[i] + '</div>';
conter += suggest;
}
cla.innerHTML = null;
cla.innerHTML = '';
cla.innerHTML = conter;
Dynamic (obj,div_width);
	}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", url, true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword));
}
}


function Dynamic(id,div_width){//该函数取得input框的绝对坐标
	var el = document.getElementById(id);
	var parent = null;
	var pos = []; 
	var box;
	if(el.getBoundingClientRect){
		box = el.getBoundingClientRect();
		var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
		var scrollLeft = Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);
		var left=box.left + scrollLeft;
		var top=box.top + scrollTop;
	}
	document.getElementById('search_suggest').style.width=div_width;
    document.getElementById('search_suggest').style.top=top+20;
    //document.getElementById('search_suggest').style.left=left-20;
    document.getElementById('search_suggest').style.left=left;
    document.getElementById('search_suggest').style.display='block';

	
}


function setSearch(obj,obj1){//该函数查询数据库后的结果选入input框
	document.getElementById(obj1).value=obj.split(" ")[1];//去掉编号
	document.getElementById('search_suggest').style.display='none';
}

function setHiddenTag(tag){//该函数控制放大镜的显示
	if(tag=='1'){
	document.getElementById('magnifier_div').style.display='block';
	}
	if(tag=='0'){
	document.getElementById('magnifier_div').style.display='none';
	}
}

function fill() {//该函数弹出'file_tree'层
	document.getElementById('file_tree').style.display ='block';
	HideOverSels('file_tree');
}



function HideOverSels(objID)
{//该函数将层所覆盖的所有select框显示
 sels = document.getElementsByTagName('select'); 
    for (var i = 0; i < sels.length; i++) 
      if (Obj1OverObj2(document.all[objID], sels[i])){//Obj1OverObj2(obj1, obj2)方法
        sels[i].style.visibility = 'hidden'; }else{

if(sels[i].id!="print_type"){
        
		sels[i].style.visibility = 'visible';
		}
		}         
}
function Obj1OverObj2(obj1, obj2)
{//该函数遍历层下面的位置
  var pos1 = getPosition(obj1)//调用getPosition(Obj)方法
  var pos2 = getPosition(obj2) 
  var result = true; 
  var obj1Left = pos1.left - window.document.body.scrollLeft; 
  var obj1Top = pos1.top - window.document.body.scrollTop; 
  var obj1Right = obj1Left + obj1.offsetWidth; 
  var obj1Bottom = obj1Top + obj1.offsetHeight;
  var obj2Left = pos2.left - window.document.body.scrollLeft; 
  var obj2Top = pos2.top - window.document.body.scrollTop; 
  var obj2Right = obj2Left + obj2.offsetWidth; 
  var obj2Bottom = obj2Top + obj2.offsetHeight;
  if (obj1Right <= obj2Left || obj1Bottom <= obj2Top || 
      obj1Left >= obj2Right || obj1Top >= obj2Bottom) 
    result = false; 
  return result; 
}
function getPosition(Obj) 
{//该函数遍历层下面的位置
for (var sumTop=0,sumLeft=0;Obj!=window.document.body;sumTop+=Obj.offsetTop,sumLeft+=Obj.offsetLeft, Obj=Obj.offsetParent);
return {left:sumLeft,top:sumTop}
}

function jionIn(my_id){//该函数通过递归得到该节点及其所有上级节点的显示文字
	var str="";
	if(my_id>0){
		//str=Nseer_tree.node_list[my_id].showStr.split(' ')[1];
		var str_temp=Nseer_tree.node_list[my_id].showStr.split(' ')[0];
		str=Nseer_tree.node_list[my_id].showStr.substring(str_temp.length+1);
		str=jionIn(Nseer_tree.node_list[my_id].pid)+"-"+str;
	}		
	return str;
}

function hiddenDiv(my_id){
    // alert(suggest_tag);
	if(my_id!=3){
	suggest_tag=my_id;
	}else{
	if(suggest_tag==0){
	document.getElementById('search_suggest').style.display ='none';
	}
	}


}


