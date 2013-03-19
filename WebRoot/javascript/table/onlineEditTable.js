//全局变量
var inputFocus;//该变量记录当前焦点的input
var bKeyDown=false;//记录键盘被按下的状态，当有键盘按下时其值为true

function setRowClass(obj,className){
 obj.className=className;
 var oldClass,toClass;
 if(className=="tableData")  {oldClass="inputTableDataHit";toClass="inputTableData";}
 if(className=="tableDataHit") {oldClass="inputTableData";toClass="inputTableDataHit";}
 var objsInput=obj.all;
 for(var i=0;i<objsInput.length;i++)
  if(objsInput[i].tagName=="INPUT")if(objsInput[i].className==oldClass)objsInput[i].className=toClass;
}

function lightonRow(obj){
 if(obj.tagName!="TR")return;

 //将所有未被选中的行取消高亮度现实
        var tableOnlineEdit=obj.parentElement;
        while(tableOnlineEdit.tagName!="TABLE")tableOnlineEdit=tableOnlineEdit.parentElement;
 var objsCheckBox=tableOnlineEdit.all("checkLine");
 for(var iCheckBox=1;iCheckBox<objsCheckBox.length;iCheckBox++)
  if(objsCheckBox[iCheckBox].checked==false) setRowClass(tableOnlineEdit.rows[iCheckBox+1],"tableData");

 //当前点击行高亮度显示
 setRowClass(obj,"tableDataHit");
}


//得到obj的上级元素TagName
function getUpperObj(obj,TagName){
 var strTagName=TagName.toUpperCase();
 var objUpper=obj.parentElement;
 while(objUpper){
  if(objUpper.tagName==strTagName) break;
  objUpper=objUpper.parentElement;
 }
 return objUpper;
}

function getPosition(obj,pos){
   var t=eval("obj."+pos);
   while(obj=obj.offsetParent){
      t+=eval("obj."+pos);
   }
   return t;
}
function showInputSelect(obj,objShow){
 inputFocus=obj;//记录当前焦点input至全局变量
 objShow.style.top =getPosition(obj,"offsetTop")+obj.offsetHeight+2;
 objShow.style.left=getPosition(obj,"offsetLeft");
 objShow.style.width=obj.offsetWidth;
 objShow.value=obj.value;
 objShow.style.display="block";
}

function setInputFromSelect(objTo,objShow){
 objTo.value=objShow.options[objShow.selectedIndex].value;
 //objShow.style.display="none";
}

function hideInput(obj){
 obj.style.display="none";
}

function clearRow(objTable){
  var tbodyOnlineEdit=objTable.getElementsByTagName("TBODY")[0];
  for (var i=tbodyOnlineEdit.children.length-1;i>=0;i--)
    tbodyOnlineEdit.deleteRow(i);
}

function deleteRow(objTable){
 var tbodyOnlineEdit=objTable.getElementsByTagName("TBODY")[0];
 for (var i=tbodyOnlineEdit.children.length-1; i>=0 ; i-- )
  if (tbodyOnlineEdit.children[i].firstChild.firstChild.checked)
   tbodyOnlineEdit.deleteRow(i);
}

function addRow(objTable){
 var tbodyOnlineEdit=objTable.getElementsByTagName("TBODY")[0];
 var theadOnlineEdit=objTable.getElementsByTagName("THEAD")[0];
 var elm = theadOnlineEdit.lastChild.cloneNode(true);
 elm.style.display="";
 tbodyOnlineEdit.insertBefore(elm);
}

//将指定数据行的objRow的输入域strName设置为strValue
function setInputValue(objRow,strName,strValue){
 var objs=objRow.all;
 for(var i=0;i<objs.length;i++){
  if(objs[i].name==strName)objs[i].value=strValue;
 }
}

//添加一个实例数据行
function addInstanceRow(objTable,Names,Values){
 var tbodyOnlineEdit=objTable.getElementsByTagName("TBODY")[0];
 var theadOnlineEdit=objTable.getElementsByTagName("THEAD")[0];
 var elm = theadOnlineEdit.lastChild.cloneNode(true)
 elm.style.display="";
        for(var i=0;i<Names.length;i++)
          setInputValue(elm,Names[i],Values[i]);
 tbodyOnlineEdit.insertBefore(elm);
}

//将全部复选框设为指定值
function setOnlineEditCheckBox(obj,value){
 var tbodyOnlineEdit=obj.getElementsByTagName("TBODY")[0];
 for (var i=tbodyOnlineEdit.children.length-1; i>=0 ; i-- )
  tbodyOnlineEdit.children[i].firstChild.firstChild.checked=value;
}

//为动态表格增加键盘导航功能,要使用该功能请在表格定义中增加事件处理onKeyDown="navigateKeys()" onKeyUp="setKeyDown(false)"
//有一点点问题，当按下"->"跳转到下一输入域时，光标显示在第一个字符之后
//建议仍然使用Tab键跳转
function navigateKeys(){
 if(bKeyDown) return;
 bKeyDown=true;
 var elm=event.srcElement;
 if(elm.tagName!="INPUT") return;//默认只对INPUT进行导航，可自行设定

 var objTD=elm.parentElement;
 var objTR=objTD.parentElement;
 var objTBODY=objTR.parentElement.parentElement;
 var objTable=objTBODY.parentElement;

 var nRow=objTR.rowIndex;
 var nCell=objTD.cellIndex;

 var nKeyCode=event.keyCode;
 switch(nKeyCode){
  case 37://<-
   if(getCursorPosition(elm)>0)return;
   nCell--;
   if(nCell==0){
    nRow--;//跳转到上一行
    nCell=objTR.cells.length-1;//最后一列
   }
   break;
  case 38://^
   nRow--;
   break;
  case 39://->
   if(getCursorPosition(elm)<elm.value.length)return;
   nCell++;
   if(nCell==objTR.cells.length){    
    nRow++;//跳转到下一行首位置
    nCell=1;//第一列
   }
   break;
  case 40://\|/
   nRow++;
   if(nRow==objTBODY.rows.length){    
    addRow(objTable);//增加一个空行
    nCell=1;//跳转到第一列
   }
   break;
  case 13://Enter
   nCell++;
   if(nCell==objTR.cells.length){    
    nRow++;//跳转到下一行首位置
    nCell=1;//第一列
   }
   if(nRow==objTBODY.rows.length){    
    addRow(objTable);//增加一个空行
    nCell=1;//跳转到第一列
   }

   break;
  default://do nothing
   return;
 }
 if(nRow<2 || nRow>=objTBODY.rows.length || nCell<1 ||nCell>=objTR.cells.length) return;

 objTR=objTBODY.rows[nRow];
 objTD=objTR.cells[nCell];
 var objs=objTD.all;
 for(var i=0;i<objs.length;i++){
  //此处使用ojbs[0],实际使用时可能需要加以修改,或加入其他条件
  try{
   lightonRow(objTR);
   objs[i].focus();//setCursorPosition(objs[i],-1);
   return;
  }catch(e){
   continue;
   //if error occur,continue to next element
  }
 }//end for objs.length
}


//设置键盘状态，即bKeyDown的值
function setKeyDown(status){
 bKeyDown=status;
}


//得到光标的位置
function getCursorPosition(obj){
 var qswh="@#%#^&#*$"
 obj.focus();
 rng=document.selection.createRange();
 rng.text=qswh;
 var nPosition=obj.value.indexOf(qswh)
 rng.moveStart("character", -qswh.length)
 rng.text="";
 return nPosition;
}


//设置光标位置
function setCursorPosition(obj,position){
 range=obj.createTextRange(); 
 range.collapse(true); 
 range.moveStart('character',position); 
 range.select();
}

