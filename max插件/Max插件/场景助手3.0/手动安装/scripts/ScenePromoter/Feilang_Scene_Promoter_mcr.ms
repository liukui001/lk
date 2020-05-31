--场景助手3.0
--开发者：飞浪     2009-8-1
--本插件所有功能均可免费使用，版权归原作者所有。
--max脚本开发网站：http://www.cgplusplus.com

macroScript ScenePromoter2_6	--此处变量沿用老版本，实际脚本已经更新
category:"FeilangTools" 
icon:#("FeilangTools",1)
tooltip:"场景助手3.0" 
buttontext:"场景助手"
(
	try fl_scenepromoter.createDlg() catch messagebox "打开场景助手出错！"
)
