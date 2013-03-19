/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function bar(){
window.setInterval("drawBar();", 2000);
}



function drawBar(painterType) {
var c = new Chart(document.getElementById('chart'));
if (painterType == 'svg') { c.setPainterFactory(SVGChartPainterFactory); }
c.setDefaultType(CHART_AREA | CHART_STACKED);
c.setHorizontalLabels(['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十1月', '十2月']);
c.setBarWidth(20);
c.add('',    '#ffffff',     [], CHART_LINE);
c.add('恩信科技',     'red', [10,43,  7, 12, 20, 44, 16, 36, 36, 18,20,60],      CHART_BAR);
c.add('Memory Usage',    'blue', [5,60, 20,  3,  2,  26,  4, 80, 12, 8,60,30],      CHART_BAR);
c.draw();
}
