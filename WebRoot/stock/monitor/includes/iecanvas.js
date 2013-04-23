/* This notice must be untouched at all times.

wz_jsgraphics.js    v. 2.33
The latest version is available at
http://www.walterzorn.com
or http://www.devira.com
or http://www.walterzorn.de

Copyright (c) 2002-2004 Walter Zorn. All rights reserved.
Created 3. 11. 2002 by Walter Zorn (Web: http://www.walterzorn.com )
Last modified: 24. 10. 2005

Performance optimizations for Internet Explorer
by Thomas Frank and John Holdsworth.
fillPolygon method implemented by Matthieu Haller.

High Performance JavaScript Graphics Library.
Provides methods
- to draw lines, rectangles, ellipses, polygons
	with specifiable line thickness,
- to fill rectangles and ellipses
- to draw text.
NOTE: Operations, functions and branching have rather been optimized
to efficiency and speed than to shortness of source code.

LICENSE: LGPL

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License (LGPL) as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA,
or see http://www.gnu.org/copyleft/lesser.html
*/


function ieCanvasInit(htcFile) {
	var ie, opera, a, nodes, i, oVml, oStyle, newNode;

	/*
	 * Only proceed if browser is IE 6 or later (as all other major browsers
	 * support canvas out of the box there is no need to try to emulate for
	 * them, and besides only IE supports VML anyway.
	 */
	ie = navigator.appVersion.match(/MSIE (\d\.\d)/);
	opera = (navigator.userAgent.toLowerCase().indexOf("opera") != -1);
	if ((!ie) || (ie[1] < 6) || (opera)) {
		return;
	}

	/*
	 * Recreate elements, as there is no canvas tag in HTML
	 * The canvas tag is replaced by a new one created using createElement,
	 * even though the same tag name is given the generated tag is slightly
	 * different, it's created prefixed with a XML namespace declaration
	 * <?XML:NAMESPACE PREFIX ="PUBLIC" NS="URN:COMPONENT" />
	 */
	nodes = document.getElementsByTagName('canvas');
	for (i = 0; i < nodes.length; i++) {
		node = nodes[i];
		if (node.getContext) { return; } // Other implementation, abort
		newNode = document.createElement('canvas');
		newNode.id = node.id;
		newNode.style.width  = node.width;
		newNode.style.height = node.height;
		node.parentNode.replaceChild(newNode, node);
	}

	/* Add VML includes and namespace */
	document.namespaces.add("v");
	oVml = document.createElement('object');
	oVml.id = 'VMLRender';
	oVml.codebase = 'vgx.dll';
	oVml.classid = 'CLSID:10072CEC-8CC1-11D1-986E-00A0C955B42E';
	document.body.appendChild(oVml);

	/* Add required css rules */
	if ((!htcFile) || (htcFile == '')) { htcFile = 'iecanvas.htc'; }
	oStyle = document.createStyleSheet();
	oStyle.addRule('canvas', "behavior: url('" + htcFile + "');");
	oStyle.addRule('v\\:*', "behavior: url(#VMLRender);");
}
