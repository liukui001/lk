/*
		VRayproxies Manager V1.0
		BY Feilang  2008-11-3
		This script was created by CGplusplus.com, any use and modification will be allowed.
		Please comment it on CG++ Forum :http://www.cgplusplus.com/bbs/
		For more maxscripts download : http://www.cgplusplus.com/

			©°©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©´
			©À©¤  CG++,FLY YOUR 3DS MAX ©¤©È
			©À©¤¡¡www.CGplusplus.com¡¡©¤©¤©È
			©¸©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¼
*/

try destroydialog fl_vrayproxyMgr catch()
global fl_vrayproxyMgr,fl_collectVRayProxies
rollout fl_vrayproxyMgr "VRayproxies Manager V1.0" width:348 height:250
(
	listbox lbx_vrayProxyPaths "VRayproxies Paths:" pos:[3,4] width:339 height:10
	edittext edt_selected "" pos:[-1,226] width:346 height:16 readOnly:true 
	radiobuttons rdo_area "" pos:[8,167] width:72 height:32 labels:#("All VRay Proxies", "Missing Proxies  ") default:1 columns:1
	button btn_collect "Collect All VRayproxies" pos:[4,205] width:214 height:16
	button btn_setPath "Set Path" pos:[123,165] width:95 height:16
	radiobuttons rdo_display "Display:" pos:[234,164] width:142 height:62 labels:#("bounding box", "preview from file", "point") columns:1
	button btn_select "Select VRayproxies" pos:[123,185] width:95 height:16
	--Collect all of the VrayProxies
	fn fl_collectAllVrayProxies = 
	(	allVP = #()
		for i in geometry where classof i == VRayProxy do
		( 	
			f = i.filename
			if findItem allVP f == 0 then append allVP f
		)
		if allVP.count != 0 then lbx_vrayProxyPaths.items = allVP --Defined the listbox
		else lbx_vrayProxyPaths.items =#( "No VRayproxies Were Fond","","CG++ Works","www.CGplusplus.com")
		lbx_vrayProxyPaths.selection = 1
		edt_selected.text = lbx_vrayProxyPaths.items[1]
	)
	--Collect the missing VrayProxies
	fn fl_collectMissVrayProxies =
	(
		missVP = #()
		for i in geometry where classof i == VRayProxy do
		( 	
			f = i.filename
			if findItem missVP f == 0 and not doesfileexist f then append missVP f
		)
		if missVP.count != 0 then lbx_vrayProxyPaths.items = missVP --Defined the listbox
		else lbx_vrayProxyPaths.items = #( "No Missing VRayproxies Were Fond","","CG++ Works","www.CGplusplus.com")
		lbx_vrayProxyPaths.selection = 1
		edt_selected.text = lbx_vrayProxyPaths.items[1]
	)
	--Collect the very vrayproxies according to the given path
	fn fl_collectGivenVP path =
	(	colVP = #()
		for i in geometry while not isDeleted i where classof i == VRayProxy do
		( 	
			f = i.filename
			if f == path then append colVP i
		)
		colVP
	)
	--Judge the filename
	fn fl_ifVrmesh path = if getFilenameType path == ".vrmesh" then return true else return false
	fn fl_getTheInstanceVP path =
	(	local tempObj;i = 1
		if fl_ifVrmesh path then while i <= geometry.count do 
		(	--Get the first vrayproxy with this path
			if classof geometry[i] == VRayProxy and geometry[i].filename == path then 
			(	tempObj = geometry[i]
				i = geometry.count
			)
			i = i + 1
		)
		tempObj
	)
	--Display the first type
	fn fl_firstDisplay =
	(
		path = lbx_vrayProxyPaths.items[1]
		tempState = 1
 		obj = fl_getTheInstanceVP path
		if obj != undefined then tempState = obj.display + 1
		rdo_display.state = tempState --Set the radiobutton state
	)
	--Display the selected path type
	fn fl_selectDisplay =
	(
		path = lbx_vrayProxyPaths.selected
		tempState = 1
 		obj = fl_getTheInstanceVP path
		if obj != undefined then tempState = obj.display + 1
		rdo_display.state = tempState --Set the radiobutton state
	)
	--refesh the listbox
	fn fl_refeshListbox stat =
	(
		case stat of
		(
			1: (		fl_collectAllVrayProxies() --Display all VRayproxies
					fl_firstDisplay() --Display the first type
				)
			2: (		fl_collectMissVrayProxies() --Display the missing VRayproxies
					fl_firstDisplay() --Display the first type
				)
		)
	)
	--Collection

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
		newPath = getOpenFileName caption:"Set the VRayproxy path" types: "VRay mesh (*.vrmesh)|*.vrmesh"
		if newPath != undefined then
		(	--Set the new path
			colVP = fl_collectGivenVP lbx_vrayProxyPaths.selected
			undo on (
				if colVP.count != 0 then for v in colVP do
				(	v.filename = newPath	
					CenterObject v --Center the object to the pivot
				)
			) --end undo on
			--Refesh the VRayproxies
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

rollout fl_collectVRayProxies "Collect All VRayproxies" width:182 height:134
(
	edittext edt_output "Output Path:" pos:[4,7] width:174 height:20 readOnly:true labelOnTop:true
	checkbox chk_ifUpdate "Update Paths" pos:[24,79] width:133 height:16 checked:false
	button btn_begin "Begin" pos:[26,103] width:126 height:25
	button btn_browse "Browse" pos:[123,50] width:54 height:20
	--Copy the given vrayproxy
	fn fl_copyVP path newDir =
	(
 		colVP = fl_vrayproxyMgr.fl_getTheInstanceVP path
		if colVP != undefined then
		(	 VPfileName = colVP.filename
			 newFilename = newDir + "\\" + filenameFromPath VPfileName
			 copyFile VPfileName newFilename
		)
	)
	--Copy the given vrayproxy and update the path
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
	--collect the not missing vrayproxies' filenames
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
			true: --Copy vrayproxy files with updating path
			(	colVP = fl_notMissingFile()
				newDir = edt_output.text
				if colVP.count != 0 and newDir != "" then
				for v in colVP do fl_copyAndUpdateVP v newDir
			)
			false: --Copy vrayproxy files without updating path
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
		collectPath = getSavePath caption: "Select Output Path"
		if collectPath != undefined then	edt_output.text = collectPath
	)
)
createdialog fl_vrayproxyMgr