/*
		VRay代理管理器1.0
		作者：飞浪  2008-11-3
		此脚本由CG++原创，可以自由传播并修改，请到CG++论坛发表你对此脚本的意见！
		CG++论坛： http://www.cgplusplus.com/bbs/
		更多原创脚本请到CG++下载：http://www.cgplusplus.com/

					┌──────────────┐
					├─ CG++,让你的3DMAX飞起来 ─┤
					├─　www.CGplusplus.com　──┤
					└──────────────┘
*/

try destroydialog fl_vrayproxyMgr catch()
global fl_vrayproxyMgr,fl_collectVRayProxies
rollout fl_vrayproxyMgr "VRay代理管理器V1.0" width:348 height:250
(
	listbox lbx_vrayProxyPaths "VRay代理路径列表：" pos:[3,4] width:339 height:10
	edittext edt_selected "" pos:[-1,226] width:346 height:16 readOnly:true 
	radiobuttons rdo_area "" pos:[8,167] width:107 height:32 labels:#("所有VRay代理  ", "丢失VRay代理  ") default:1 columns:1
	button btn_collect "收集所有VRay代理" pos:[4,205] width:214 height:16
	button btn_setPath "设置路径" pos:[123,165] width:95 height:16
	radiobuttons rdo_display "显示形式：" pos:[234,164] width:114 height:62 labels:#("边界框   ", "从文件预览   ", "点 ") columns:1
	button btn_select "选择VRay代理" pos:[123,185] width:95 height:16
	--收集所有VRay代理
	fn fl_collectAllVrayProxies = 
	(	allVP = #()
		for i in geometry where classof i == VRayProxy do
		( 	
			f = i.filename
			if findItem allVP f == 0 then append allVP f
		)
		if allVP.count != 0 then lbx_vrayProxyPaths.items = allVP --Defined the listbox
		else lbx_vrayProxyPaths.items =#( "没有找到VRay代理","","CG++出品","www.CGplusplus.com")
		lbx_vrayProxyPaths.selection = 1
		edt_selected.text = lbx_vrayProxyPaths.items[1]
	)
	--收集丢失VRay代理
	fn fl_collectMissVrayProxies =
	(
		missVP = #()
		for i in geometry where classof i == VRayProxy do
		( 	
			f = i.filename
			if findItem missVP f == 0 and not doesfileexist f then append missVP f
		)
		if missVP.count != 0 then lbx_vrayProxyPaths.items = missVP --Defined the listbox
		else lbx_vrayProxyPaths.items = #( "没有找到丢失VRay代理","","CG++出品","www.CGplusplus.com")
		lbx_vrayProxyPaths.selection = 1
		edt_selected.text = lbx_vrayProxyPaths.items[1]
	)
	--根据所给路径收集VRay代理
	fn fl_collectGivenVP path =
	(	colVP = #()
		for i in geometry while not isDeleted i where classof i == VRayProxy do
		( 	
			f = i.filename
			if f == path then append colVP i
		)
		colVP
	)
	--判断文件名
	fn fl_ifVrmesh path = if getFilenameType path == ".vrmesh" then return true else return false
	fn fl_getTheInstanceVP path =
	(	local tempObj;i = 1
		if fl_ifVrmesh path then while i <= geometry.count do 
		(	--获得使用此文件的第一个VRay代理
			if classof geometry[i] == VRayProxy and geometry[i].filename == path then 
			(	tempObj = geometry[i]
				i = geometry.count
			)
			i = i + 1
		)
		tempObj
	)
	--列表第一个路径的显示方式
	fn fl_firstDisplay =
	(
		path = lbx_vrayProxyPaths.items[1]
		tempState = 1
 		obj = fl_getTheInstanceVP path
		if obj != undefined then tempState = obj.display + 1
		rdo_display.state = tempState --设置显示方式
	)
	--列表选择路径的显示方式
	fn fl_selectDisplay =
	(
		path = lbx_vrayProxyPaths.selected
		tempState = 1
 		obj = fl_getTheInstanceVP path
		if obj != undefined then tempState = obj.display + 1
		rdo_display.state = tempState --设置显示方式
	)
	--刷新列表
	fn fl_refeshListbox stat =
	(
		case stat of
		(
			1: (		fl_collectAllVrayProxies() --显示所有VRay代理
					fl_firstDisplay() --第一个的显示方式
				)
			2: (		fl_collectMissVrayProxies() --显示丢失VRay代理
					fl_firstDisplay() --第一个的显示方式
				)
		)
	)
	--显示选择列表的路径
	--显示范围
	--收集

	on fl_vrayproxyMgr open do
	(
		fl_collectAllVrayProxies()
		fl_firstDisplay()
	)
	on fl_vrayproxyMgr close do
	(
		try destroydialog fl_collectVRayProxies catch()
	)
	on lbx_vrayProxyPaths selected sel do
	(
		edt_selected.text = lbx_vrayProxyPaths.selected
		fl_selectDisplay()
	)
	on rdo_area changed stat do
	(
		fl_refeshListbox stat
	)
	on btn_collect pressed do
	(
		try destroydialog fl_collectVRayProxies catch()
		createdialog fl_collectVRayProxies
	)
	on btn_setPath pressed do
	(
		newPath = getOpenFileName caption:"设置VRay代理路径" types: "VRay mesh (*.vrmesh)|*.vrmesh"
		if newPath != undefined then
		(	--设置新路径
			colVP = fl_collectGivenVP lbx_vrayProxyPaths.selected
			undo on (
				if colVP.count != 0 then for v in colVP do
				(	v.filename = newPath	
					CenterObject v --轴心归坐标中心
				)
			) --end undo on
			--刷新显示方式
			fl_refeshListbox rdo_area.state
		) --end if
	)
	on rdo_display changed stat do
	(	
		selPath = lbx_vrayProxyPaths.selected
		if fl_ifVrmesh selPath then
		(	
			colVP = fl_getTheInstanceVP selPath
			undo on (
			case stat of
			(
				1: for i in colVP do i.display = 0 --bounding box
				2: for i in colVP do i.display = 1 --preview from file
				3: for i in colVP do i.display = 2 --point
			)
			) --end undo on
		)--end if
	)
	on btn_select pressed do
	(
		colVP = fl_collectGivenVP lbx_vrayProxyPaths.selected
		undo on ( select colVP )
	)
)


rollout fl_collectVRayProxies "收集所有VRay代理" width:182 height:134
(
	edittext edt_output "收集路径：" pos:[4,7] width:174 height:20 readOnly:true labelOnTop:true
	checkbox chk_ifUpdate "更新VRay代理路径" pos:[24,79] width:133 height:16 checked:false
	button btn_begin "开  始" pos:[26,103] width:126 height:25
	button btn_browse "打开" pos:[123,50] width:54 height:20
	--复制VRay代理
	fn fl_copyVP path newDir =
	(
 		colVP = fl_vrayproxyMgr.fl_getTheInstanceVP path
		if colVP != undefined then
		(	 VPfileName = colVP.filename
			 newFilename = newDir + "\\" + filenameFromPath VPfileName
			 copyFile VPfileName newFilename
		)
	)
	--复制VRay代理并更新路径
	fn fl_copyAndUpdateVP path newDir =
	(
 		colVP = fl_vrayproxyMgr.fl_getTheInstanceVP path
		if colVP != undefined then
		(	 VPfileName = colVP.filename
			 newFilename = newDir + "\\" + filenameFromPath VPfileName
			 copyFile VPfileName newFilename
			 colVP.filename = newFilename
		)
	)
	--收集没有丢失的VRay代理
	fn fl_notMissingFile =
	(
		allVP = #()
		for i in geometry where classof i == VRayProxy do
		( 	
			f = i.filename
			if findItem allVP f == 0 and doesfileexist f then append allVP f
		)
		allVP
	)
	on btn_begin pressed do
	(
		case chk_ifUpdate.checked of
		(
			true: --复制VRay代理并更新路径
			(	colVP = fl_notMissingFile()
				newDir = edt_output.text
				if colVP.count != 0 and newDir != "" then
				for v in colVP do fl_copyAndUpdateVP v newDir
			)
			false: --复制VRay代理
			( 	colVP = fl_notMissingFile()
				newDir = edt_output.text
				if colVP.count != 0 and newDir != "" then
				for v in colVP do fl_copyVP v newDir
			)
		)
		max views redraw
		fl_vrayproxyMgr.fl_refeshListbox fl_vrayproxyMgr.rdo_area.state
		destroydialog fl_collectVRayProxies
	)
	on btn_browse pressed do
	(
		collectPath = getSavePath caption: "选择保存路径"
		if collectPath != undefined then	edt_output.text = collectPath
	)
)
createdialog fl_vrayproxyMgr