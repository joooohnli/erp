var sels;
function HideOverSels(objID)
{
 sels = document.getElementsByTagName('select'); 
    for (var i = 0; i < sels.length; i++) 
      if (Obj1OverObj2(document.all[objID], sels[i])){
        if(sels[i].id!='print_type'){
				sels[i].style.visibility = 'hidden';}  }else{
		if(sels[i].id!='print_type'){
				sels[i].style.visibility = 'visible';} 
		}         
}
function Obj1OverObj2(obj1, obj2)
{
  var pos1 = getPosition(obj1) 
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
{
for (var sumTop=0,sumLeft=0;Obj!=window.document.body;sumTop+=Obj.offsetTop,sumLeft+=Obj.offsetLeft, Obj=Obj.offsetParent);
return {left:sumLeft,top:sumTop}
}


var window_tag=0;

function NeatDialog(sHTML, sTitle, bCancel)
{//sHTML　传过来的ＨＴＭＬ　bCancel为false;sTitle用来提示的title,
window.neatDialog = null;
this.elt = null;
if (document.createElement && document.getElementById)
{
var dg = document.createElement("div");
dg.id="window_cont";
dg.className = "neat-dialog";
dg.style.top=(document.body.scrollTop+(document.body.clientHeight-145)/2)+'px';
    if (sTitle)
    sHTML = '<div class="neat-dialog-title">'+sTitle+
              ((bCancel)?
                '<img src="x.gif" alt="Cancel" class="nd-cancel" />':'')+
                '</div>\n' + sHTML;
    dg.innerHTML = sHTML;
    var dbg = document.createElement("div");
    dbg.id = "nd-bdg";
	dbg.style.height=document.body.scrollHeight+'px';
    dbg.className = "neat-dialog-bg";

    var dgc = document.createElement("div");
    dgc.className = "neat-dialog-cont";
      dgc.id = 'max_div';
    dgc.appendChild(dbg);
    dgc.appendChild(dg);
    if (document.body.offsetLeft > 0)
    dgc.style.marginLeft = document.body.offsetLeft + "px";
    document.body.appendChild(dgc);
    this.elt = dgc;
    window.neatDialog = this;
	window_tag=1;
	window.onscroll=scall;//窗口滚动时激发的事件
	window.onresize=scall;//窗口改变大小时激发的事件
	//********************
	if (window.ActiveXObject){ HideOverSels('max_div');}
    //********************

}
NeatDialog.prototype.close = function()
{
	window_tag=0;
  if (this.elt)
  {
    this.elt.style.display = "none";
    this.elt.parentNode.removeChild(this.elt);
  }
  window.neatDialog = null;
//********************
if (window.ActiveXObject){  for (var i = 0; i < sels.length; i++) {
	if(sels[i].id=='print_type'){ sels[i].style.visibility = 'hidden';}else{
		sels[i].style.visibility = 'visible';
	}
}
}
//********************

}

}
function scall(){
	if(window_tag==1){
document.getElementById("window_cont").style.top=(document.body.scrollTop+(document.body.clientHeight-145)/2)+"px"; 
}
}