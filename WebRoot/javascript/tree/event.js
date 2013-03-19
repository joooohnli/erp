function showHide( id )
{
  var el= document.getElementById( id );
  var bExpand = true;
  var images = el.getElementsByTagName("IMG");
  if (images[0].src.indexOf("minus.gif")!=-1)
  {
    bExpand = false;
    images[0].src="/erp/images/plus.gif";
  }else{
    images[0].src="/erp/images/minus.gif";
  }
  var subs=el.lastChild;
  if(bExpand)
    subs.style.display="block";
  else
    subs.style.display="none";
}