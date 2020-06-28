--if bs1==1 then removerollout  AR main
--if bs2==1 then removerollout  BR main
--if bs3==1 then removerollout  CR main
dialog_x=165 
dialog_y=38
bf=1
global CGSplit
global CGSplit2
mm=0;

rollout AR "Full" width:162 height:194
(
	button btn162 "Poly Counter" pos:[6,36] width:69 height:18
	button btn163 "Reset XForm" pos:[75,36] width:70 height:18
	button btn164 "Bitmap Paths" pos:[6,56] width:69 height:18
	button btn165 "场景打包" pos:[75,56] width:70 height:18
	checkbutton btn166 "Lock" pos:[6,76] width:69 height:18
	checkbutton btn167 "UnLock" pos:[75,76] width:70 height:18
	button btn168 "选择灯光" pos:[6,116] width:69 height:18
	button btn169 "选择物体" pos:[75,116] width:70 height:18
	button btn170 "选择帮助物体" pos:[6,96] width:95 height:18
	GroupBox grp39 "" pos:[3,0] width:146 height:32
	button btn528 "→" pos:[122,10] width:22 height:18 toolTip:"Full"
	button btn714 "Full" pos:[6,10] width:61 height:18
	GroupBox grp12 "" pos:[3,132] width:146 height:55
	button btn98 "取消" pos:[102,96] width:43 height:18 toolTip:"取消选择"
	button btn92 "File" pos:[67,10] width:28 height:18	
	button btn12 "" pos:[115,144] width:12 height:18
	button btn30 "C" pos:[95,10] width:25 height:18 toolTip:"CommandPanel"
	edittext edt12 "" pos:[37,164] width:57 height:18
	button btn43 "OK" pos:[98,164] width:25 height:18
	button btn44 "Del" pos:[123,164] width:22 height:18
	edittext edt2 "" pos:[37,144] width:57 height:18
	button btn295 "OK" pos:[98,144] width:17 height:18
	label lbl14 "标志:" pos:[10,166] width:31 height:16
	label lbl15 "改名:" pos:[10,147] width:31 height:16
	button btn17 "S" pos:[127,144] width:18 height:18
	on btn162 pressed do
		UtilityPanel.OpenUtility Polygon_Counter
	on btn163 pressed do
	(
		cui.commandPanelOpen = true
			UtilityPanel.OpenUtility Reset_XForm
		)
	on btn164 pressed do
	(
			cui.commandPanelOpen = true
			UtilityPanel.OpenUtility Bitmap_Photometric_Paths
		)
	on btn165 pressed do
	(
			cui.commandPanelOpen = true
			UtilityPanel.OpenUtility Resource_Collector
		)
	on btn166 changed state do
	(
	btn166.Checked = on
	for i = 1 to selection.count do
			(
			setTransformLockFlags selection[i] #{1,2,3,4,5,6,7,8,9}
			)
			)
	on btn167 changed state do
	(
				btn166.Checked = off
				btn167.Checked = off						
	for i = 1 to selection.count do
					(
					setTransformLockFlags selection[i] #{}
					)
					)
	on btn168 pressed do
		select lights
	on btn169 pressed do
		select geometry
	on btn170 pressed do
		select helpers
	on btn528 pressed do
	(
	
	rollout ro_vPropShop3 "Full"
	(
		button btn130 "Time" pos:[16,52] width:50 height:22
		button btn131 "Trackbar" pos:[67,52] width:50 height:22
		button btn132 "StatusPanel" pos:[16,78] width:101 height:22
		button btn133 "MainToolbar" pos:[16,17] width:101 height:22
		GroupBox grp12 "" pos:[10,40] width:113 height:66
		GroupBox grp25 "" pos:[10,6] width:113 height:38
		on btn130 pressed do
		(		
			time = not
				(
							timeslider.isVisible()
					 ) 
							timeSlider.setVisible  time
			)
		on btn131 pressed do
		(
				if 	trackbar.visible == true  then 
						    trackbar.visible = false
					else
				          	trackbar.visible = true
			)
		on btn132 pressed do
		(
				if 	statusPanel.visible == true  then 
						    statusPanel.visible = false
					else
				          	statusPanel.visible = true
			)
		on btn133 pressed do
			actionMan.executeAction 0 "411"  -- Tools: Show Main Toolbar Toggle
	)
	
	createDialog ro_vPropShop3 width:135 height:120 --bgColor:[110,110,110]
	)
	on btn714 pressed do
	(
			actionMan.executeAction 0 "40264"
	
	if 	bf == 1 then
	    (		 
	     	           menuMan.loadMenuFile "full.mnu"
	    bf=0
		)		
			else
				(
				  menuMan.loadMenuFile "DefaultUI.mnu"
	                bf=1
				)
	
	time = not
			(
						timeslider.isVisible()
				 ) 
						timeSlider.setVisible  time
	
	
	if 	trackbar.visible == true  then 
					    trackbar.visible = false
				else
			          	trackbar.visible = true
	
	
	)
	on btn98 pressed do
		clearSelection()
	on btn92 pressed do
	if 	bf == 1 then
	    (		 
	     	           menuMan.loadMenuFile "full.mnu"
	    bf=0
		)		
			else
				(
				  menuMan.loadMenuFile "DefaultUI.mnu"
	                bf=1
				)
	on btn12 pressed do
		schematicView.Open "CGmolin"
	on btn30 pressed do
	(				if 	cui.commandPanelOpen == true  then 
							    cui.commandPanelOpen = false
						else
					          	cui.commandPanelOpen = true
		)
	on edt12 entered txt do
	(
	try
	(
	clearSelection()
	select $cgmolin_jm*
	delete $
	) 
	catch()
	sliderManipulator xPos:0.88 yPos:1 isSelected:on
	$.hide = on
	$.sldName = txt
	$.Name = "cgmolin_jm"
	clearSelection()
	)
	on btn43 pressed do
	(
	try
	(
	prefix_txt.text = ""
	$.name = "cgmolin_jm"
	clearSelection()
	) 
	catch()
	)
	on btn44 pressed do
	(
	try
	(
	clearSelection()
	select $cgmolin*
	delete $
	) 
	catch()
	)
	on edt2 entered txt do
	(
	try
	(
	$.Name = txt
	) 
	catch()
	)
	on btn295 pressed do
	(
	try
	(
	prefix_txt.text = ""
	) 
	catch()
	)
	on btn17 pressed do
	(
	max create mode
	xz=#()---新建一个组 组名xz
	try(
	for i in selection do append xz i---把当前选择的物体放到 xz 组里
	for i in xz do
	(
	ss=i.name
	pp=i.pos
	text size:2.3 pos:(pp+[-3,0.5,0]) isSelected:on
	$.text=ss
	convertTo $ PolyMeshObject
	)
	)catch()
	)
)
rollout BR "Poly" width:162 height:274
(
	button btn39 "Remove All" pos:[7,5] width:70 height:18
	button btn40 "加点" pos:[7,65] width:44 height:18
	button btn41 "Loop" pos:[77,25] width:65 height:18
	button btn42 "Ring" pos:[7,25] width:70 height:18
	button btn43 "Connect 1" pos:[7,45] width:65 height:18
	button btn44 "2" pos:[74,45] width:22 height:18
	button btn45 "45" pos:[107,192] width:20 height:18
	button btn46 "1" pos:[89,192] width:18 height:18
	button btn47 "Flip" pos:[7,105] width:135 height:18
	button btn48 "180" pos:[127,192] width:20 height:18
	button btn49 "ON / OFF" pos:[79,165] width:63 height:18
	button btn50 "Sym_X" pos:[7,145] width:42 height:18
	button btn51 "Sym_Y" pos:[53,145] width:42 height:18
	button btn52 "Sym_Z" pos:[100,145] width:42 height:18 enabled:true
	button btn145 "Slice" pos:[7,165] width:70 height:18
	button btn58 "Edge" pos:[67,85] width:38 height:18
	label lbl1 "Constraints:" pos:[10,88] width:56 height:16
	button btn140 "None" pos:[106,85] width:36 height:18
	button btn90 "Remove" pos:[77,5] width:65 height:18
	GroupBox grp25 "" pos:[2,-5] width:145 height:192
	button btn22 "EoditPoly" pos:[54,65] width:88 height:18
	button btn23 "3" pos:[96,45] width:23 height:18
	button btn24 "4" pos:[119,45] width:23 height:18
	button btn567 "X" pos:[65,125] width:25 height:18
	button btn568 "Y" pos:[91,125] width:25 height:18
	button btn569 "Z" pos:[117,125] width:25 height:18
	button btn640 "对齐" pos:[7,125] width:54 height:18 toolTip:"makePlanar"
	spinner spn45 "" pos:[44,193] width:45 height:16
	button btn367 "Smooth" pos:[2,192] width:43 height:18
	on btn39 pressed do
	(
	undo "nu RemoveAll" on
			try(
			for i in selection do (i.EditablePoly.SelectEdgeLoop ())
			macros.run "Editable Polygon Object" "EPoly_Convert_Sel_To_Vertex"
			subobjectLevel = 2
			macros.run "Editable Polygon Object" "EPoly_Remove"
			subobjectLevel = 1
			macros.run "Editable Polygon Object" "EPoly_Remove"
	         subobjectLevel = 2
			 ) catch ()
			 )
	on btn40 pressed do
	(undo "nu Vertex" on
	macros.run "Editable Polygon Object" "EPoly_EInsertVertex")
	on btn41 pressed do
	(
	undo "Loop" on
	try($.EditablePoly.SelectEdgeLoop ()) catch()
	)
	on btn42 pressed do
	(
	undo "Ring" on
	try($.EditablePoly.SelectEdgeRing ()) catch()
	)
	on btn43 pressed do
	(
	undo "nu connect1" on
	try(
	$.EditablePoly.SelectEdgeRing ()
	$.connectEdgeSegments = 1
	$.EditablePoly.ConnectEdges ()
	) catch()
				)
	on btn44 pressed do
	(
	undo "nu connect2" on
		try(
		$.EditablePoly.SelectEdgeRing ()
		$.connectEdgeSegments = 2
		$.EditablePoly.ConnectEdges ()
		) catch()
				)
	on btn45 pressed do
	(
	undo "nu smooth45" on
	try(
	$.autoSmoothThreshold = 45
	$.EditablePoly.autosmooth ()
		) catch()
		)
	on btn46 pressed do
	(
	undo "nu smooth1" on
	try(
		$.autoSmoothThreshold = 1
		$.EditablePoly.autosmooth ()
		) catch()
		)
	on btn47 pressed do
	(
	undo "nu Flip" on
			try($.EditablePoly.flipNormals 1) catch()
		)
	on btn48 pressed do
	(
	undo "nu smooth90" on
	try(
			$.autoSmoothThreshold = 180
			$.EditablePoly.autosmooth ()
			) catch()
		)
	on btn49 pressed do
	(
	undo "onoff" on
	try(
				if 	subobjectLevel == 0  then 
						    subobjectLevel = 1
					else
				          	subobjectLevel = 0
							) catch()
			)
	on btn50 pressed do
	(
	undo "nu symX" on
	try
	(
			instance $
			scale $ [-1,1,1]
			)
		catch()
			)
	on btn51 pressed do
	(
	undo "nu symY" on
		try
	(
			instance $
			scale $ [1,-1,1]
						)
		catch()
			)
	on btn52 pressed do
	(
	undo "nu symZ" on
		try
	(
			instance $
			scale $ [1,1,-1]
						)
		catch()
			)
	on btn145 pressed do
	(
	undo "nu Slice" on
			try
	(
	modPanel.addModToSelection (SliceModifier ()) ui:on
	subobjectLevel = 1
							)
		catch()
		)
	on btn58 pressed do
	(
	undo "EdgeZ" on
	actionMan.executeAction 0 "50007"  -- Tools: Restrict to Z
	$.constrainType = 1
				)
	on btn140 pressed do
	(
	undo "None" on
	$.constrainType = 0
				)
	on btn90 pressed do
	(
	undo "nu Remove" on
	case (getSelectionLevel $) of 
	(
	#Vertex: $.EditablePoly.Remove selLevel:#Vertex
	#Edge:(
	sel = #{}
	edgesel = polyOp.getEdgeSelection $
	vertsel = polyOp.getVertsUsingEdge $ edgesel
	$.EditablePoly.Remove selLevel:#Edge
	for i = 1 to vertsel.numberset do
	if ($.GetVertexEdgeCount (vertsel as array)[i]) == 2 then sel = sel + #{(vertsel as array)[i]}
	polyop.setVertSelection $ sel
	$.EditablePoly.Remove selLevel:#Vertex
	)
	#Face:
	(
	sel = #{}
	facesel = polyOp.getFaceSelection $
	edgesel = polyOp.getEdgesUsingFace $ facesel
	for i = 1 to edgesel.numberset do
	if (((polyOp.getEdgeFaces $ (edgesel as array)[i]) as bitarray)*(facesel as bitarray)).numberset == 2 then sel= sel + #{(edgesel as array)[i]}
	polyop.setEdgeSelection $ sel
	$.EditablePoly.Remove selLevel:#Edge
	)
	)
	)
	on btn22 pressed do
	(
	undo on
	try(
	convertTo $ PolyMeshObject
	) catch ()
	)
	on btn23 pressed do
	(
	undo "nu connect2" on
		try(for i in selection do (i.EditablePoly.SelectEdgeRing ())
		for i in selection do (i.connectEdgeSegments = 3)
		for i in selection do (i.EditablePoly.ConnectEdges ())
		) catch()
				)
	on btn24 pressed do
	(
	undo "nu connect2" on
		try(for i in selection do (i.EditablePoly.SelectEdgeRing ())
		for i in selection do (i.connectEdgeSegments = 4)
		for i in selection do (i.EditablePoly.ConnectEdges ())
		) catch()
				)
	on btn567 pressed do
	(
	undo "" on
	try(
	$.EditablePoly.MakePlanarIn #X
			) catch()
		)
	on btn568 pressed do
	(
	undo "" on
	try(
	$.EditablePoly.MakePlanarIn #Y
			) catch()
		)
	on btn569 pressed do
	(
	undo "" on
	try(
	$.EditablePoly.MakePlanarIn #Z
			) catch()
		)
	on btn640 pressed do
	(
	undo "" on
	try(
	$.EditablePoly.makePlanar #Face
			) catch()
		)
	on spn45 changed val do
	(
		
		)
	on btn367 pressed do
	(
	undo "nu smooth1" on
	try(
		$.autoSmoothThreshold = spn45.value
		$.EditablePoly.autosmooth ()
		) catch()
		)
)

rollout CR "Uvw" width:162 height:219
(
	GLOBAL FaceBuffer=#(), FaceIDs=#(), StoredObject, UndoNo, StoredUVCount
	fn PolyFaceMap =
	(
		local notallfaces=0
		for gg=1 to $.selectedfaces.count do
		(
			local tmpPol=polyop.getmapface $ 1 $.selectedfaces[gg].index
			local uvstart=(polyop.getnummapverts $ 1)+1
			if tmpPol.count==4 then
			(
				polyop.setnummapverts $ 1 ((polyop.getnummapverts $ 1)+4) keep:true
				polyop.setmapvert $ 1 (UVStart) [0,0,0]	
				polyop.setmapvert $ 1 (UVStart+1) [1,0,0]
				polyop.setmapvert $ 1 (UVStart+2) [1,1,0]	
				polyop.setmapvert $ 1 (UVStart+3) [0,1,0]	
				polyop.setmapface $ 1 $.selectedfaces[gg].index #(UVStart,(UVStart+1),(UVStart+2),(UVStart+3))
			)
			else
			(
				notallfaces=1
			)
		)
		update $selection[1]
		if notallfaces==1 do (messagebox "WARNING: Some of the polys couldn't be face mapped as they contained more that 4 vertices.

Deselect these faces and try again.")
	)
	
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		fn FlattenViewVerts = 
		(
			local TempVertList=#()
			if (classof $)==Editable_Mesh do
			(	
				local TmpVerts=(meshop.getvertsusingface $ $.selectedfaces) as array
			)
			if (classof $)==Editable_Poly do
			(	
				local TmpVerts=(Polyop.getvertsusingface $ $.selectedfaces) as array
			)			
			NodeCalc=Point Name:"Nodey" ishidden:true cross:off
			for PP=1 to TmpVerts.count do
			(
				Mat=Matrix3 1
				Mat.rotation=(viewport.getTM()).rotation
				Mat=orthogonalize (inverse Mat)
				Mat.Translation=getvert $ TmpVerts[PP]
				Rotate Mat (inverse Mat.rotation ) 
				NodeCalc.transform=Mat
				Append TempVertList [NodeCalc.pos.x,NodeCalc.pos.y,0]
			)
			delete NodeCalc
			GC()
			return TempVertList
		)

		fn PasteViewFaces VV =
		(
			local CMinX=VXMin
			local CMaxX=VXmax
			local CMinY=VYMin
			local CMaxY=VYMax	
			local OldTVerts=$.numtverts
			local SelFaces=for gg=1 to $.selectedfaces.count collect $.selectedfaces[gg].index
			local VertListIn=(meshop.getvertsusingface $ $.selectedfaces) as array
			VertList=VV
			setnumTVerts $ ($.numtverts+VertList.count) true
	
			local tmpVX=for gg=1 to Vertlist.count collect Vertlist[gg].x
			local tmpVY=for gg=1 to Vertlist.count collect Vertlist[gg].y
			local MinX=amin tmpVX
			local MaxX=amax tmpVX
			local MinY=amin tmpVY
			local MaxY=amax tmpVY
			local XScale=MaxX-MinX
			local YScale=MaxY-MinY
			local TmpTX=#()
			local TmpTY=#()

			for gg=1 to VertList.count do
			(
				tmpV=VertList[gg]
				tmpV.x=CMinX+( 	((tmpV.x-MinX)/XScale)*(CMaxX-CMinX)	)
				tmpV.y=CMinY+( 	((tmpV.y-MinY)/YScale)*(CMaxY-CMinY)	)	
				setTVert $ (OldTVerts+gg)tmpV
				if VertList.count==4 do ( append TmpTX tmpV.x ; append TmpTY tmpV.y )
			)
			
			if VertList.count==4 do
			(
				SortTmpTX=sort TmpTX			
				SortTmpTY=sort TmpTY			
				local LeftQuad=#()
				local RightQuad=#()
				for GG=1 to TmpTX.count do ( if TmpTX[GG]==SortTmpTX[1] do ( append LeftQuad GG ; TmpTX[gg]=9999.0 ))
				for GG=1 to TmpTX.count do ( if TmpTX[GG]==SortTmpTX[2] do ( append LeftQuad GG ; TmpTX[gg]=9999.0  ) )
				for GG=1 to TmpTX.count do ( if TmpTX[GG]==SortTmpTX[SortTmpTX.count] do ( append RightQuad GG ; TmpTX[gg]=9999.0  ) )
				for GG=1 to TmpTX.count do ( if TmpTX[GG]==SortTmpTX[(SortTmpTX.count-1)] do ( append RightQuad GG ; TmpTX[gg]=9999.0 ) )
				
				if TmpTY[LeftQuad[1]]<=TmpTY[LeftQuad[2]] then 
				(
					setTVert $ (OldTVerts+LeftQuad[1]) [0,0,0]		--okay!
					setTVert $ (OldTVerts+LeftQuad[2]) [1,0,0]
				)
				else
				(
					setTVert $ (OldTVerts+LeftQuad[2]) [0,0,0]
					setTVert $ (OldTVerts+LeftQuad[1]) [1,0,0]
				)	
		
				if TmpTY[RightQuad[1]]<=TmpTY[RightQuad[2]] then 
				(
					setTVert $ (OldTVerts+RightQuad[1]) [0,1,0]
					setTVert $ (OldTVerts+RightQuad[2]) [1,1,0]
				)
				else
				(
					setTVert $ (OldTVerts+RightQuad[2]) [0,1,0]
					setTVert $ (OldTVerts+RightQuad[1]) [1,1,0]
				)			
			)
		
			
			for gg=1 to $.SelectedFaces.count do
			(
				local TmpFace=getface $ $.SelectedFaces[gg].index
				local V1=OldTVerts+(finditem VertListIn TmpFace.x)
				local V2=OldTVerts+(finditem VertListIn TmpFace.y)
				local V3=OldTVerts+(finditem VertListIn TmpFace.z)
				setTVFace $ $.SelectedFaces[gg].index [V1,V2,V3]
			)
			update $
			gc()
		)

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		fn NormalAlign B =
		(
			local Norm=[0,0,0]
			local GG=1, TT
			local TransFormMat
			local TMPosZ=(viewport.getTM()).pos.z
			if (classof B)==Editable_Mesh do
			(
				while GG<=B.selectedfaces.count do (Norm=Norm+(getfacenormal B B.selectedfaces[GG].index); GG+=1)
				Norm=Norm/[B.selectedfaces.count,B.selectedfaces.count,B.selectedfaces.count]
				TransFormMat=( MatrixFromNormal Norm )
				tmpV=meshop.getvertsusingFace B(getfaceselection B); setvertselection B tmpV
			)
			if (Classof B)==Editable_Poly do
			(
				while GG<=B.selectedfaces.count do (Norm=Norm+(polyop.getfacenormal B B.selectedfaces[GG].index); GG+=1)
				Norm=Norm/[B.selectedfaces.count,B.selectedfaces.count,B.selectedfaces.count]
				TransFormMat=( MatrixFromNormal Norm )
				tmpV=polyop.getvertsusingFace B(getfaceselection B); polyop.setvertselection B tmpV			
			)			
			
			TransFormMat= orthogonalize TransFormMat 
			GV=viewport.gettype()
			if GV==#view_Front or GV==#view_Back or GV==#view_Left or GV==#view_Right or GV==#view_Top or GV==#view_Bottom do
			(
				viewport.settype #view_iso_user						
			)
			TransFormMat=(inverse TransFormMat)
			TransFormMat.position.z=TMPosZ
			viewport.setTM TransformMat
			max tool zoomextents		
			gc()
		)
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

fn ConformUVs UVPos UVScale = 
(

	local UVMin=[999.0,999.0,0.0], UVMax=[0.0,0.0,0.0]
	local UVset=#()
	for gg=1 to $.selectedfaces.count do
	(
	
		local TmpFce=getTVFace $ $.selectedfaces[gg].index
		local TmpVrt=getTVert $ TmpFce.x
		if TmpVrt.x<=UVMin.x do (UVMin.x=TmpVrt.x)
		if TmpVrt.y<=UVMin.y do (UVMin.y=TmpVrt.y)
		if TmpVrt.x>=UVMax.x do (UVMax.x=TmpVrt.x)
		if TmpVrt.y>=UVMax.y do (UVMax.y=TmpVrt.y)
		if (finditem UVSet TmpFce.x)==0 do (append UVSet TmpFce.x)
		
		local TmpVrt=getTVert $ TmpFce.y
		if TmpVrt.x<=UVMin.x do (UVMin.x=TmpVrt.x)
		if TmpVrt.y<=UVMin.y do (UVMin.y=TmpVrt.y)
		if TmpVrt.x>=UVMax.x do (UVMax.x=TmpVrt.x)
		if TmpVrt.y>=UVMax.y do (UVMax.y=TmpVrt.y)
		if (finditem UVSet TmpFce.y)==0 do (append UVSet TmpFce.y)

		local TmpVrt=getTVert $ TmpFce.z
		if TmpVrt.x<=UVMin.x do (UVMin.x=TmpVrt.x)
		if TmpVrt.y<=UVMin.y do (UVMin.y=TmpVrt.y)	
		if TmpVrt.x>=UVMax.x do (UVMax.x=TmpVrt.x)
		if TmpVrt.y>=UVMax.y do (UVMax.y=TmpVrt.y)
		if (finditem UVSet TmpFce.z)==0 do (append UVSet TmpFce.z)

	)

	--RESET UV POSITIONS
	UVMax=UVScale/(UVMax-UVMin)
	for gg=1 to UVSet.count do
	(
		local tmpVrt=getTvert $ UVSet[gg]
		tmpVrt.x=UVPos.x+((TmpVrt.x-UVMin.x)*UVMax.x)
		tmpVrt.y=UVPos.y+((TmpVrt.y-UVMin.y)*UVMax.y)
		tmpVrt.z=0.0
		setTvert $ UVSet[gg] tmpVrt
	)

	update $
)

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
fn QUADMapPro tmpp =
(
	local getQverts=#(), SetQverts=(), tmptri=#(), FaceA, FaceB, TFaceA, TFaceB, TVert=#(), TVertAdd=0
	local bufcount=1, tt=1
	try
	(
	if tmpp==2 do
	(
	
		case (classof $) of
		(

			Editable_mesh: (
						TVertAdd=($.numtverts+1)
						setnumtverts $ ($.numtverts+($.selectedfaces.count*3)) true
						for gg=1 to $.selectedfaces.count do
							(
							settvert $ (TVertAdd  ) (gettvert $ (getTVface $ facebuffer[bufcount]).x)
							settvert $ (TVertAdd+1) (gettvert $ (getTVface $ facebuffer[bufcount]).y)
							settvert $ (TVertAdd+2) (gettvert $ (getTVface $ facebuffer[bufcount]).z)			
							setTVface $ $.selectedfaces[gg].index (TVertAdd  ) (TVertAdd+1) (TVertAdd+2)
							setfacematId $ $.selectedfaces[gg].index (getfacematid $ facebuffer[bufcount])
							bufcount +=1 ; if bufcount>facebuffer.count do (bufcount=1)
							TVertadd+=3	
							)
						)						
			Editable_Poly: (
						for gg=1 to $.selectedfaces.count do
							(
							local TVs=polyop.getmapface $ 1 $.selectedfaces[gg].index
							local CopTVs=polyop.getmapface $ 1 facebuffer[bufcount]
							local CountTV=(polyop.getnummapverts $ 1)+1
							local TVarray=#()
							tt=1
							polyop.setnummapverts $ 1 (CountTV+TVs.count) keep:true
								for pp =1 to TVs.count do
								(
									polyop.setmapvert $ 1 (CountTV+pp) (polyop.getmapvert $ 1 CopTVs[tt])
									append TVarray (CountTV+pp)
									tt+=1 ; if tt>CopTVs.count do (tt=1)
								)		
							polyop.setmapface $ 1 $.selectedfaces[gg].index TVarray
							polyop.setFaceMatId $ $.selectedfaces[gg].index (polyop.getFaceMatId $ facebuffer[bufcount])
							bufcount +=1 ; if bufcount>facebuffer.count do (bufcount=1)
							)
						)	  		       			
		)
		
	)

	if facebuffer.count==2 or tmpp==1 do
	(
		TVertAdd=($.numtverts+1)
	--*********************************************************************GETQVERTS 1-2=open 3-4=shared
		try
		(
			FaceA=getface $ facebuffer[1]
			FaceB=getface $ facebuffer[2]
			TFaceA=getTVface $ facebuffer[1]
			TFaceB=getTVface $ facebuffer[2]
			Tvert[1]=gettvert $ TFaceB.x ; Tvert[2]=gettvert $ TFaceB.y ; Tvert[3]=gettvert $ TFaceB.z		
			tmptri[1]=FaceA.x ; tmptri[2]=FaceA.y ; tmptri[3]=FaceA.z
			if (finditem tmptri FaceB.x)==0 do ( getQverts[1]=Tvert[1] ; getQverts[3]=Tvert[2] ; getQverts[4]=Tvert[3] )
			if (finditem tmptri FaceB.y)==0 do ( getQverts[1]=Tvert[2] ; getQverts[3]=Tvert[1] ; getQverts[4]=Tvert[3] )
			if (finditem tmptri FaceB.z)==0 do ( getQverts[1]=Tvert[3] ; getQverts[3]=Tvert[1] ; getQverts[4]=Tvert[2] )
		
			Tvert[1]=gettvert $ TFaceA.x ; Tvert[2]=gettvert $ TFaceA.y ; Tvert[3]=gettvert $ TFaceA.z		
			tmptri[1]=FaceB.x ; tmptri[2]=FaceB.y ; tmptri[3]=FaceB.z		
			if (finditem tmptri FaceA.x)==0 do ( getQverts[2]=TVert[1] )
			if (finditem tmptri FaceA.y)==0 do ( getQverts[2]=TVert[2] )
			if (finditem tmptri FaceA.z)==0 do ( getQverts[2]=TVert[3] )
		)
		catch()		
	--*********************************************************************SETQVERTS 1-2=open 3-4=shared
		
		setnumtverts $ ($.numtverts+($.selectedfaces.count*3)) true
		gg=1
		while gg < $.selectedfaces.count do
		(
			if tmpp==0 do
			(
				settvert $ (TVertAdd  ) getQverts[2]
				settvert $ (TVertAdd+1) getQverts[1]
				settvert $ (TVertAdd+2) getQverts[3]
				settvert $ (TVertAdd+3) getQverts[4]
			)
			if tmpp==1 do
			(
				settvert $ (TVertAdd+3) [1,1,0]
				settvert $ (TVertAdd+2) [0,0,0]
				settvert $ (TVertAdd+1) [1,0,0]
				settvert $ (TVertAdd+0) [0,1,0]
			)
			
			if facebuffer.count==2 or tmpp==1 do
			(
				try
				(	
					if tmpp==0 do
					(
						setfacematId $ $.selectedfaces[gg].index (getfacematid $ facebuffer[1])
						setfacematId $ $.selectedfaces[gg+1].index (getfacematid $ facebuffer[2])
					)
					FaceA=getface $ $.selectedfaces[gg].index
					FaceB=getface $ $.selectedfaces[gg+1].index					
					
					tmptri[1]=FaceB.x ; tmptri[2]=FaceB.y ; tmptri[3]=FaceB.z	
					if (finditem tmptri FaceA.x)==0 do ( settvface $ $.selectedfaces[gg].index (TVertAdd  ) (TVertAdd+2) (TVertAdd+3) )
					if (finditem tmptri FaceA.y)==0 do ( settvface $ $.selectedfaces[gg].index (TVertAdd+3) (TVertAdd  ) (TVertAdd+2) )
					if (finditem tmptri FaceA.z)==0 do ( settvface $ $.selectedfaces[gg].index (TVertAdd+2) (TVertAdd+3) (TVertAdd  ) )							
								
					tmptri[1]=FaceA.x ; tmptri[2]=FaceA.y ; tmptri[3]=FaceA.z						
					if (finditem tmptri FaceB.x)==0 do ( settvface $ $.selectedfaces[gg+1].index (TVertAdd+1) (TVertAdd+3) (TVertAdd+2) )
					if (finditem tmptri FaceB.y)==0 do ( settvface $ $.selectedfaces[gg+1].index (TVertAdd+2) (TVertAdd+1) (TVertAdd+3) )
					if (finditem tmptri FaceB.z)==0 do ( settvface $ $.selectedfaces[gg+1].index (TVertAdd+3) (TVertAdd+2) (TVertAdd+1) )				
				)
				catch()
			)
			gg +=2 ; TVertAdd +=4
		)
	--*********************************************************************SETQVERTS 1-2=open 3-4=shared
	)
	update $
	
	)
	catch()
)

--******************************************************************************************************
fn storeUVs =
(
	StoredObject=selection[1]
	StoredID=#()
	StoredUVCoords=#()

	StoredFaces=for gg=1 to selection[1].selectedfaces.count collect selection[1].selectedfaces[gg].index
	
			case (classof $) of
			(
				Editable_mesh: (
					StoredUVCount=selection[1].numtverts					
					for FaceCount=1 to StoredFaces.count do
					(				
						StoredID[FaceCount]=getfacematid storedobject storedfaces[facecount]
						StoredUVCoords[FaceCount]=getTVface selection[1] Storedfaces[FaceCount]
					)
				)
				Editable_poly: (
					StoredUVCount=polyop.getnummapverts selection[1] 1					
					for FaceCount=1 to StoredFaces.count do
					(	
						StoredID[FaceCount]=polyop.getfacematid storedobject storedfaces[facecount]	
						StoredUVCoords[FaceCount]=polyop.getmapface selection[1] 1 Storedfaces[FaceCount]		
					)
				)
			)
	UndoNo=1
)
--**************************************************************************************************

fn UndoTask UndoType =
(
	if UndoType==1 do
	(
		--try
		--(

			case (classof $) of
			(
				Editable_mesh: (
					setnumtverts StoredObject StoredUVCount true
					for FaceCount=1 to StoredFaces.count do
					(	
						setfacematId storedobject StoredFaces[Facecount] StoredID[FaceCount]
						setTVface StoredObject StoredFaces[FaceCount] StoredUVCoords[FaceCount]
					)
				)
				Editable_poly: (
					polyop.setnummapverts StoredObject 1 StoredUVCount keep:true
					for FaceCount=1 to StoredFaces.count do
					(	
						polyop.setFaceMatId storedobject StoredFaces[Facecount] StoredID[FaceCount]
						polyop.setmapface StoredObject 1 StoredFaces[FaceCount] StoredUVCoords[FaceCount]
					)
				)			
			
			)
			
		update StoredObject
		--)
		--catch()
	)
)

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

fn RotateMultiFaces=
(
		local AxisPos=[0,0,0] , ang=90.0 , angcalc=rotateZmatrix ang
		local Xmin=9999999.0, Ymin=9999999.0, Xmax=0.0,  Ymax=0.0, xratio, yratio,TVertadd, cpy
		local tt=1, bufcount=1
		case (classof $) of
		(

			Editable_mesh: (
						TVertAdd=($.numtverts+1)
						setnumtverts $ ($.numtverts+($.selectedfaces.count*3)) true
						for gg=1 to $.selectedfaces.count do
							(
							settvert $ (TVertAdd  ) (gettvert $ (getTVface $ $.selectedfaces[gg].index).x)
							settvert $ (TVertAdd+1) (gettvert $ (getTVface $ $.selectedfaces[gg].index).y)
							settvert $ (TVertAdd+2) (gettvert $ (getTVface $ $.selectedfaces[gg].index).z)			
							setTVface $ $.selectedfaces[gg].index (TVertAdd  ) (TVertAdd+1) (TVertAdd+2)
							TVertadd+=3	
							)
						)						
			Editable_Poly: (
						for gg=1 to $.selectedfaces.count do
							(
							local TVs=polyop.getmapface $ 1 $.selectedfaces[gg].index
							local CountTV=(polyop.getnummapverts $ 1)+1
							local TVarray=#()
							tt=1
							polyop.setnummapverts $ 1 (CountTV+TVs.count) keep:true
								for pp =1 to TVs.count do
								(
									polyop.setmapvert $ 1 (CountTV+pp) (polyop.getmapvert $ 1 TVs[pp])
									append TVarray (CountTV+pp)
								)		
							polyop.setmapface $ 1 $.selectedfaces[gg].index TVarray
							)
						)	  		       			
		)

	local tmpv=#()
	for gg=1 to $.selectedfaces.count do
	(
		case (classof $) of
		(
			editable_Mesh: (
				append tmpv (getTvert $ (getTVface $ $.selectedfaces[gg].index).x)
				append tmpv (getTvert $ (getTVface $ $.selectedfaces[gg].index).y)
				append tmpv (getTvert $ (getTVface $ $.selectedfaces[gg].index).z)
			)
			editable_poly: (
				local faceverts=polyop.getmapface $ 1 $.selectedfaces[gg].index
				for zz=1 to faceverts.count do
				(
					append tmpv (polyop.getmapvert $ 1 faceverts[zz])
				)
			)			
		)
		
		for pp=1 to tmpv.count do
		(
			if tmpv[PP].x<Xmin do (Xmin=tmpv[PP].x) ; if tmpv[PP].y<Ymin do (Ymin=tmpv[PP].y)		
			if tmpv[PP].x>Xmax do (Xmax=tmpv[PP].x) ; if tmpv[PP].y>Ymax do (Ymax=tmpv[PP].y)		
		)
		
	)
	yratio=(ymax-ymin)/(xmax-xmin) ; xratio=(xmax-xmin)/(ymax-ymin)
	
	AxisPos.x=(Xmin+((Xmax-Xmin)/2)) ; 	AxisPos.y=(Ymin+((Ymax-Ymin)/2))

	case (classof $) of
	(
		editable_mesh: (
			for tt=1 to $.selectedfaces.count do
			(
			Vertpos=getTvert $ (getTVface $ $.selectedfaces[tt].index).x
			Vertpos -=AxisPos ; Vertpos *=angcalc ; VertPos.x*=xratio ; VertPos.y*=yratio ; VertPos +=AxisPos
			setTvert $ (getTVface $ $.selectedfaces[tt].index).x Vertpos
			--*******
			Vertpos=getTvert $ (getTVface $ $.selectedfaces[tt].index).y
			Vertpos -=AxisPos ; Vertpos *=angcalc ; VertPos.x*=xratio ; VertPos.y*=yratio ; VertPos +=AxisPos
			setTvert $ (getTVface $ $.selectedfaces[tt].index).y Vertpos
			--*******
			Vertpos=getTvert $ (getTVface $ $.selectedfaces[tt].index).z
			Vertpos -=AxisPos ; Vertpos *=angcalc ; VertPos.x*=xratio ; VertPos.y*=yratio ; VertPos +=AxisPos
			setTvert $ (getTVface $ $.selectedfaces[tt].index).z Vertpos		
			)
		)
		editable_poly: (
			for tt=1 to $.selectedfaces.count do
			(
			
			local faceverts=polyop.getmapface $ 1 $.selectedfaces[tt].index

				for zz=1 to faceverts.count do
				(
					Vertpos=polyop.getmapvert $ 1 faceverts[zz]
					Vertpos -=AxisPos ; Vertpos *=angcalc ; VertPos.x*=xratio ; VertPos.y*=yratio ; VertPos +=AxisPos
					polyop.setmapvert $ 1 faceverts[zz] Vertpos					
				)		
			)
		)	
	
	)		
		
update $
)
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^POLY HERE
fn FlippingPolys FlipStatus =
(
	try
	(
	local TmpFaces=$.selectedfaces, TmpOrigin=[0,0,0]	--, addon=1
	local Xmin=9999999.0, Ymin=9999999.0, Xmax=0.0,  Ymax=0.0
	local tmpcount=1
	--************************
	PSTFACE=(Polyop.GetNumMapVerts $ 1)+1
	for pp=1 to $.selectedfaces.count do tmpcount+=(polyop.getfaceverts $ $.selectedfaces[pp].index).count
	Polyop.setnumMapverts $ 1 ((Polyop.GetNumMapVerts $ 1)+tmpcount) keep:true
	for PSF=1 to $.selectedfaces.count do
	(
		local tmparr=#(), OLDPST=PSTFACE
		cpy=Polyop.getMapface $ 1 $.selectedfaces[PSF].index
		for tt=1 to cpy.count do append tmparr (PSTFACE+tt)
		Polyop.setMapface $ 1 $.selectedfaces[PSF].index tmparr
		
		for tt=1 to cpy.count do
		(
			Polyop.setMapvert $ 1 (PSTFACE+tt) (Polyop.getMapvert $ 1 cpy[tt])
		)
		PSTFACE+=cpy.count
	)
	--************************
	for gg=1 to TmpFaces.count do
	(
		cpy=Polyop.getMapface $ 1 $.selectedfaces[gg].index

		for tt=1 to cpy.count do
		(
			tmp=Polyop.getMapvert $ 1 cpy[tt]
			if tmp.x<Xmin do (Xmin=tmp.x) ; if tmp.y<Ymin do (Ymin=tmp.y)
			if tmp.x>Xmax do (Xmax=tmp.x) ; if tmp.y>Ymax do (Ymax=tmp.y)
		)
	)
	TmpOrigin.x=Xmin+((Xmax-Xmin)/2) ; 	TmpOrigin.y=Ymin+((Ymax-Ymin)/2)
	for gg=1 to TmpFaces.count do
	(
		cpy=Polyop.getMapface $ 1 $.selectedfaces[gg].index
		local keytest=keyboard.controlpressed
 		local normalflip=1
		if keytest==true do NormalFlip=0
		if NormalFlip==0 do
		(
			if cpy.count==4 then
			(
				case FlipStatus of
				(
					1:(
						tmpTVert=polyop.getMapvert $ 1 cpy[1]
						polyop.setMapvert $ 1 cpy[1] (polyop.getMapvert $ 1 cpy[2])
						polyop.setMapvert $ 1 cpy[2] tmpTVert
						tmpTVert=polyop.getMapvert $ 1 cpy[3]
						polyop.setMapvert $ 1 cpy[3] (polyop.getMapvert $ 1 cpy[4])
						polyop.setMapvert $ 1 cpy[4] tmpTVert				
					)
					2:(
						tmpTVert=polyop.getMapvert $ 1 cpy[1]
						polyop.setMapvert $ 1 cpy[1] (polyop.getMapvert $ 1 cpy[4])
						polyop.setMapvert $ 1 cpy[4] tmpTVert
						tmpTVert=polyop.getMapvert $ 1 cpy[2]
						polyop.setMapvert $ 1 cpy[2] (polyop.getMapvert $ 1 cpy[3])
						polyop.setMapvert $ 1 cpy[3] tmpTVert				
					)

				)
			)
			else
			(
				NormalFlip=1
			)
		)
		if NormalFlip==1 do
		(
			for tt=1 to cpy.count do
			(
				tmpTVert=polyop.getMapvert $ 1 cpy[tt]
				case FlipStatus of
				(
					1: tmpTVert.x=TmpOrigin.x+(TmpOrigin.x-TmpTVert.x)
					2: tmpTVert.y=TmpOrigin.y+(TmpOrigin.y-TmpTVert.y)
				)
				polyop.setMapvert $ 1 cpy[tt] tmpTvert
			)
		)

	)
	update $
	)
	catch()
)
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^POLY HERE
fn FlippingFaces FlipStatus =
(
	try
	(
	local TmpFaces=$.selectedfaces, TmpOrigin=[0,0,0], addon=1
	local Xmin=9999999.0, Ymin=9999999.0, Xmax=0.0,  Ymax=0.0
	--************************
	PSTFACE=(Meshop.GetNumMapVerts $ 1)+1
	meshop.setnumMapverts $ 1 ((Meshop.GetNumMapVerts $ 1)+($.selectedfaces.count*3)) keep:true
	for PSF=1 to $.selectedfaces.count do
	(
		cpy=meshop.getMapface $ 1 $.selectedfaces[PSF].index
		meshop.setMapvert $ 1 PSTFACE (meshop.getMapvert $ 1 cpy.x)
		meshop.setMapvert $ 1 (PSTFACE+1) (meshop.getMapvert $ 1 cpy.y)
		meshop.setMapvert $ 1 (PSTFACE+2) (meshop.getMapvert $ 1 cpy.z)
		meshop.setMapface $ 1 $.selectedfaces[PSF].index [PSTFACE, (PSTFACE+1), (PSTFACE+2)]
		PSTFACE=PSTFACE+3
	)
	--************************
	for gg=1 to TmpFaces.count do
	(
		tmpv1=meshop.getMapvert $ 1 (meshop.getMapface $ 1 TmpFaces[gg].index).x
		tmpv2=meshop.getMapvert $ 1 (meshop.getMapface $ 1 TmpFaces[gg].index).y
		tmpv3=meshop.getMapvert $ 1 (meshop.getMapface $ 1 TmpFaces[gg].index).z
		if tmpv1.x<Xmin do (Xmin=tmpv1.x) ; if tmpv1.y<Ymin do (Ymin=tmpv1.y)
		if tmpv2.x<Xmin do (Xmin=tmpv2.x) ; if tmpv2.y<Ymin do (Ymin=tmpv2.y)	
		if tmpv3.x<Xmin do (Xmin=tmpv3.x) ; if tmpv3.y<Ymin do (Ymin=tmpv3.y)
		if tmpv1.x>Xmax do (Xmax=tmpv1.x) ; if tmpv1.y>Ymax do (Ymax=tmpv1.y)
		if tmpv2.x>Xmax do (Xmax=tmpv2.x) ; if tmpv2.y>Ymax do (Ymax=tmpv2.y)	
		if tmpv3.x>Xmax do (Xmax=tmpv3.x) ; if tmpv3.y>Ymax do (Ymax=tmpv3.y)
	)
	TmpOrigin.x=Xmin+((Xmax-Xmin)/2) ; 	TmpOrigin.y=Ymin+((Ymax-Ymin)/2)
	for gg=1 to TmpFaces.count do
	(
		tmpTVert1=meshop.getMapvert $ 1 (meshop.getMapface $ 1 TmpFaces[addon].index).x
		tmpTVert2=meshop.getMapvert $ 1 (meshop.getMapface $ 1 TmpFaces[addon].index).y
		tmpTVert3=meshop.getMapvert $ 1 (meshop.getMapface $ 1 TmpFaces[addon].index).z
		if FlipStatus==1 do (	tmp=TmpOrigin.x+(TmpOrigin.x-TmpTvert1.x)
								tmpTvert1.x=tmp
								tmp=TmpOrigin.x+(TmpOrigin.x-TmpTvert2.x)
								tmpTvert2.x=tmp
								tmp=TmpOrigin.x+(TmpOrigin.x-TmpTvert3.x)
								tmpTvert3.x=tmp
							)
		if FlipStatus==2 do (	tmp=TmpOrigin.y+(TmpOrigin.y-TmpTvert1.y)
								tmpTvert1.y=tmp
								tmp=TmpOrigin.y+(TmpOrigin.y-TmpTvert2.y)
								tmpTvert2.y=tmp
								tmp=TmpOrigin.y+(TmpOrigin.y-TmpTvert3.y)
								tmpTvert3.y=tmp
							)
		meshop.setMapvert $ 1 (meshop.getMapface $ 1 TmpFaces[addon].index).x tmpTvert1
		meshop.setMapvert $ 1 (meshop.getMapface $ 1 TmpFaces[addon].index).y tmpTvert2
		meshop.setMapvert $ 1 (meshop.getMapface $ 1 TmpFaces[addon].index).z tmpTvert3
		addon=addon+1
	)
--update $
)
catch()
)

	--include "$UI/MacroScripts/molin/molinUvwTools.ms"
	GroupBox grp9 "" pos:[3,3] width:145 height:189
	button btn150 "Copy" pos:[8,14] width:45 height:20
	button btn151 "Paste" pos:[8,36] width:45 height:20
	button btn152 "FlipX" pos:[53,14] width:45 height:20
	button btn153 "FlipY" pos:[53,36] width:45 height:20
	button btn154 "Rotate" pos:[98,14] width:45 height:20
	button btn155 "Mapit" pos:[98,36] width:45 height:20
	button btn156 "On/Off" pos:[76,149] width:67 height:18
	button btn157 "UnwrapUVW" pos:[8,127] width:82 height:20
	button btn158 "Edit" pos:[93,127] width:50 height:20
	button btn159 "1" pos:[8,149] width:20 height:18
	button btn160 "2" pos:[28,149] width:20 height:18
	button btn161 "3" pos:[48,149] width:20 height:18
	button btn162 "UVW Map" pos:[8,65] width:65 height:20
	button btn163 "Cylin.." pos:[53,87] width:45 height:18
	button btn164 "Planar" pos:[8,87] width:45 height:18
	button btn165 "X" pos:[77,107] width:22 height:18
	button btn166 "Y" pos:[99,107] width:22 height:18
	button btn167 "Z" pos:[121,107] width:22 height:18
	button btn168 "1" pos:[8,107] width:20 height:18
	button btn169 "2" pos:[28,107] width:20 height:18
	button btn170 "3" pos:[48,107] width:20 height:18
	button btn171 "Box" pos:[98,87] width:45 height:18
	GroupBox grp15 "" pos:[3,3] width:145 height:58
	button btn57 "Manipulate" pos:[73,65] width:70 height:20
	button btn172 "Del..UVW1" pos:[8,169] width:135 height:18
	on btn150 pressed do
	(
		try
		(
		
		OBJ=selection[1]
		FceBffr=OBJ.selectedFaces
		FaceBuffer=for k=1 to OBJ.selectedFaces.count collect FceBffr[k].index
		case (classof $) of
		(
			Editable_poly: (FaceIDs=for k=1 to OBJ.selectedFaces.count collect polyop.getfacematID OBJ FceBffr[k].index)
			Editable_mesh: (FaceIDs=for k=1 to OBJ.selectedFaces.count collect getfacematID OBJ FceBffr[k].index)
		)
		)
		catch()
	)
	on btn151 pressed do
	(
		try
		(
			StoreUVs()
			case (classof $) of
			(
				Editable_mesh: (		
					if facebuffer.count==2 do ( QUADMapPro 0 )
					if facebuffer.count!=2 do ( QUADMapPro 2 )
				)
				Editable_Poly: (
					QUADMapPro 2
				)
			)		
		)
		catch()
	)
	on btn152 pressed do
	(
		try
		(
		
		StoreUVs()
		if (classof $)==editable_mesh do
		( 
			if $.selectedfaces.count<3 then
			(
			OBJ2=selection[1]
			norm=#() ; chk=0
			if OBJ2.selectedfaces.count>=1 do ( FA=meshop.getMapface OBJ2 1 OBJ2.selectedfaces[1].index )
			if OBJ2.selectedfaces.count==1 do (meshop.setMapface OBJ2 1 OBJ2.selectedfaces[1].index [FA.x, FA.z, FA.y] ; update OBJ2)	
	
			if OBJ2.selectedfaces.count==2 do 	
			(						
				FB=meshop.getMapface OBJ2 1 OBJ2.selectedfaces[2].index
				VAx=meshop.getMapvert OBJ2 1 FA.x
				VAy=meshop.getMapvert OBJ2 1 FA.y
				VAz=meshop.getMapvert OBJ2 1 FA.z
				VBx=meshop.getMapvert OBJ2 1 FB.x
				VBy=meshop.getMapvert OBJ2 1 FB.y
				VBz=meshop.getMapvert OBJ2 1 FB.z
				if VAx!=VBx and VAx!=VBy and VAx!=VBz do (norm[1]=FA.x ; chk=chk+1)
				if VAy!=VBx and VAy!=VBy and VAy!=VBz do (norm[1]=FA.y ; chk=chk+1)
				if VAz!=VBx and VAz!=VBy and VAz!=VBz do (norm[1]=FA.z ; chk=chk+1)
				if chk >1 do (chk=3)
				if VBx!=VAx and VBx!=VAy and VBx!=VAz do (norm[2]=FB.x ; chk=chk+1)
				if VBy!=VAx and VBy!=VAy and VBy!=VAz do (norm[2]=FB.y ; chk=chk+1)
				if VBz!=VAx and VBz!=VAy and VBz!=VAz do (norm[2]=FB.z ; chk=chk+1)
				if chk==2 do
				(		
					if FA.x==norm[1] do (tmp=[FA.y,FA.x,norm[2]])
					if FA.y==norm[1] do (tmp=[norm[2],FA.z,FA.y])
					if FA.z==norm[1] do (tmp=[FA.z,norm[2],FA.x])				
					if FB.x==norm[2] do (meshop.setMapface OBJ2 1 OBJ2.selectedfaces[2].index [FB.y,FB.x,norm[1]])
					if FB.y==norm[2] do (meshop.setMapface OBJ2 1 OBJ2.selectedfaces[2].index [norm[1],FB.z,FB.y])
					if FB.z==norm[2] do (meshop.setMapface OBJ2 1 OBJ2.selectedfaces[2].index [FB.z,norm[1],FB.x])
					meshop.setMapface OBJ2 1 OBJ2.selectedfaces[1].index tmp			
				)
				update OBJ2
				)
			)
			else
			(
			FlippingFaces 1
			)
		)
		if (classof $)==editable_poly do FlippingPolys 1
		)
		catch()
	)
	on btn153 pressed do
	(
		try
		(	
			StoreUVs()
			if (classof $)==editable_mesh then
			( 
				if $.selectedfaces.count<3 then
				(
					OBJ2=selection[1]
					norm=#() ; chk=0
					if OBJ2.selectedfaces.count>=1 do ( FA=meshop.getMapface OBJ2 1 OBJ2.selectedfaces[1].index )
					if OBJ2.selectedfaces.count==1 do (meshop.setMapface OBJ2 1 OBJ2.selectedfaces[1].index [FA.y, FA.x, FA.z] ; update OBJ2)	
					if OBJ2.selectedfaces.count==2 do 	
					(
						FB=meshop.getMapface OBJ2 1 OBJ2.selectedfaces[2].index
						VAx=meshop.getMapvert OBJ2 1 FA.x
						VAy=meshop.getMapvert OBJ2 1 FA.y
						VAz=meshop.getMapvert OBJ2 1 FA.z
						VBx=meshop.getMapvert OBJ2 1 FB.x
						VBy=meshop.getMapvert OBJ2 1 FB.y
						VBz=meshop.getMapvert OBJ2 1 FB.z
						if VAx!=VBx and VAx!=VBy and VAx!=VBz do (norm[1]=FA.x ; chk=chk+1)
						if VAy!=VBx and VAy!=VBy and VAy!=VBz do (norm[1]=FA.y ; chk=chk+1)
						if VAz!=VBx and VAz!=VBy and VAz!=VBz do (norm[1]=FA.z ; chk=chk+1)
						if chk >1 do (chk=3)
						if VBx!=VAx and VBx!=VAy and VBx!=VAz do (norm[2]=FB.x ; chk=chk+1)
						if VBy!=VAx and VBy!=VAy and VBy!=VAz do (norm[2]=FB.y ; chk=chk+1)
						if VBz!=VAx and VBz!=VAy and VBz!=VAz do (norm[2]=FB.z ; chk=chk+1)
						if chk==2 do
						(		
							if FA.x==norm[1] do (tmp=[FA.z,norm[2],FA.x])	
							if FA.y==norm[1] do (tmp=[FA.y,FA.x,norm[2]])
							if FA.z==norm[1] do (tmp=[norm[2],FA.z,FA.y])		
							if FB.x==norm[2] do (meshop.setMapface OBJ2 1 OBJ2.selectedfaces[2].index [FB.z,norm[1],FB.x])
							if FB.y==norm[2] do (meshop.setMapface OBJ2 1 OBJ2.selectedfaces[2].index [FB.y,FB.x,norm[1]])
							if FB.z==norm[2] do (meshop.setMapface OBJ2 1 OBJ2.selectedfaces[2].index [norm[1],FB.z,FB.y])
							meshop.setMapface OBJ2 1 OBJ2.selectedfaces[1].index tmp
						)
					update OBJ2
					)
				)
				else
				(
	 				flippingfaces 2
				)
			)
			else
			(
				if (classof $)==editable_poly do FlippingPolys 2
			)
		)
		catch()
	)
	on btn154 pressed do
	(
		try
		(
		StoreUVs()	
		OBJ2=selection[1]
		norm=#() ; chk=0
		
		if (classof $)==editable_mesh do
		(
		if OBJ2.selectedfaces.count>=1 do ( FA=getTVface OBJ2 OBJ2.selectedfaces[1].index )
		if OBJ2.selectedfaces.count==1 do (setTVface OBJ2 OBJ2.selectedfaces[1].index [FA.z, FA.x, FA.y] ; update OBJ2)	
		if OBJ2.selectedfaces.count==2 do 	
			(
			FB=getTVface OBJ2 OBJ2.selectedfaces[2].index	
			VAx=gettvert OBJ2 FA.x
			VAy=gettvert OBJ2 FA.y
			VAz=gettvert OBJ2 FA.z
			VBx=gettvert OBJ2 FB.x
			VBy=gettvert OBJ2 FB.y
			VBz=gettvert OBJ2 FB.z
			if VAx!=VBx and VAx!=VBy and VAx!=VBz do (norm[1]=FA.x ; chk=chk+1)
			if VAy!=VBx and VAy!=VBy and VAy!=VBz do (norm[1]=FA.y ; chk=chk+1)
			if VAz!=VBx and VAz!=VBy and VAz!=VBz do (norm[1]=FA.z ; chk=chk+1)
			if chk >1 do (chk=3)
			if VBx!=VAx and VBx!=VAy and VBx!=VAz do (norm[2]=FB.x ; chk=chk+1)
			if VBy!=VAx and VBy!=VAy and VBy!=VAz do (norm[2]=FB.y ; chk=chk+1)
			if VBz!=VAx and VBz!=VAy and VBz!=VAz do (norm[2]=FB.z ; chk=chk+1)
			if chk==2 do
				( 			if FA.x==norm[1] do (setTVface OBJ2 OBJ2.selectedfaces[1].index [FA.z,FA.x,norm[2]])
				if FA.y==norm[1] do (setTVface OBJ2 OBJ2.selectedfaces[1].index [norm[2],FA.x,FA.y])
				if FA.z==norm[1] do (setTVface OBJ2 OBJ2.selectedfaces[1].index [FA.z,norm[2],FA.y])	
				if FB.x==norm[2] do (setTVface OBJ2 OBJ2.selectedfaces[2].index [FB.z,FB.x,norm[1]])
				if FB.y==norm[2] do (setTVface OBJ2 OBJ2.selectedfaces[2].index [norm[1],FB.x,FB.y])
				if FB.z==norm[2] do (setTVface OBJ2 OBJ2.selectedfaces[2].index [FB.z,norm[1],FB.y])
				)
			update OBJ2
			)
		)
		
		if OBJ2.selectedfaces.count>2 or (classof $)==editable_poly do
			(
			RotateMultiFaces()
			)
		)
		catch()
	)
	on btn155 pressed do
	(
		try
		(
			StoreUVs()
			case (classof $selection[1]) of
			(
				editable_mesh: QUADmappro 1
				editable_poly: POLYfacemap()
			)
			update $
		)
		catch()
	)
	on btn156 pressed do
	(
	try(
				if 	subobjectLevel == 0  then 
						    subobjectLevel = 1
					else
				          	subobjectLevel = 0
							) catch()
			)
	on btn157 pressed do
	(
	undo "nu unwrap" on
	try(
	modPanel.addModToSelection (Unwrap_UVW ()) ui:on
			modPanel.setCurrentObject $.modifiers[#Unwrap_UVW]		
				for i in selection do (i.modifiers[#unwrap_uvw].unwrap2.setFreeFormMode on)
				for i in selection do (i.modifiers[#unwrap_uvw].unwrap.edit ())
				) catch()
		)
	on btn158 pressed do
	(		
	try(
				modPanel.setCurrentObject $.modifiers[#Unwrap_UVW]		
				for i in selection do (i.modifiers[#unwrap_uvw].unwrap2.setFreeFormMode on)
				for i in selection do (i.modifiers[#unwrap_uvw].unwrap.edit ())
				) catch()
		)
	on btn159 pressed do
	(
			try(
				for i in selection do (i.modifiers[#unwrap_uvw].unwrap.setMapChannel 1)
				) catch()
		)
	on btn160 pressed do
	(
			try(
				for i in selection do (i.modifiers[#unwrap_uvw].unwrap.setMapChannel 2)
				) catch()
		)
	on btn161 pressed do
	(
			try(
				for i in selection do (i.modifiers[#unwrap_uvw].unwrap.setMapChannel 3)
				) catch()
		)
	on btn162 pressed do
	(
	undo "nu UVW" on
	try(
	modPanel.addModToSelection (Uvwmap ()) ui:on
			subobjectLevel = 1
			) catch()
		)
	on btn163 pressed do
	(
	undo "nu cylin" on
			try(
				for i in selection do (i.modifiers[#UVW_Mapping].maptype = 1)
				) catch()
		)
	on btn164 pressed do
	(
	undo "nu Plan" on
			try(
				for i in selection do (i.modifiers[#UVW_Mapping].maptype = 0)
				) catch()
		)
	on btn165 pressed do
	(
			try(
				for i in selection do (i.modifiers[#UVW_Mapping].axis = 0)
				) catch()
		)
	on btn166 pressed do
	(
			try(
				for i in selection do (i.modifiers[#UVW_Mapping].axis = 1)
				) catch()
		)
	on btn167 pressed do
	(
			try(
				for i in selection do (i.modifiers[#UVW_Mapping].axis = 2)
				) catch()
		)
	on btn168 pressed do
	(
			try(
				for i in selection do (i.modifiers[#UVW_Mapping].mapChannel = 1)
				) catch()
		)
	on btn169 pressed do
	(
			try(
				for i in selection do (i.modifiers[#UVW_Mapping].mapChannel = 2)
				) catch()
		)
	on btn170 pressed do
	(
			try(
				for i in selection do (i.modifiers[#UVW_Mapping].mapChannel = 3)
				) catch()
		)
	on btn171 pressed do
	(
	undo "nu box" on
			try(
				for i in selection do (i.modifiers[#UVW_Mapping].maptype = 4)
				) catch()
		)
	on btn57 pressed do
		actionMan.executeAction 0 "59225"
	on btn172 pressed do
	(
	try(
		for a in selection do deletemodifier a 1
		) catch()
	)
)

rollout DR "Game" width:178 height:280
(
	GroupBox grp9 "" pos:[2,-2] width:144 height:146
	checkbutton btn90 "VertexPaint" pos:[9,8] width:75 height:18
	checkbutton btn91 "On" pos:[88,8] width:24 height:18
	checkbutton btn92 "Off" pos:[115,8] width:24 height:18
	button btn93 "清空材质球" pos:[9,27] width:84 height:18
	button btn94 "导入" pos:[93,27] width:46 height:18 toolTip:"将材质导入材质球"
	button btn95 "2层" pos:[104,65] width:35 height:18 toolTip:"选择2层多重材质"
	button btn96 "空物体" pos:[9,103] width:65 height:18
	button btn97 "没材质" pos:[74,103] width:65 height:18
	button btn98 "Select VertexPaint" pos:[9,46] width:130 height:18
	button btn99 "选择多重材质" pos:[9,65] width:95 height:18
	button btn100 "P" pos:[5,166] width:30 height:16 toolTip:"Clear Position" across:3
	button btn101 "R" pos:[36,166] width:30 height:16 toolTip:"Clear Rotation"
	button btn102 "S" pos:[67,166] width:30 height:16 toolTip:"Clear Scale"
	button btn43 "切分" pos:[98,166] width:45 height:16 toolTip:"Clear Scale"
	button btn517 "选择Shell材质" pos:[9,84] width:130 height:18 toolTip:"选择ShellMaterial材质"
	colorPicker cp63 "" pos:[2,210] width:27 height:16 color:(color 255 255 255)
	spinner spn87 "" pos:[29,210] width:50 height:16 enabled:true range:[0,100,0] scale:0.01
	Timer tmr32 "Timer" pos:[138,199] width:24 height:24 interval:200
	button btn143 "180" pos:[124,186] width:19 height:18
	button btn144 "0" pos:[89,186] width:16 height:18
	spinner spn117 "" pos:[43,187] width:45 height:16 range:[0,180,45]
	button btn145 "45" pos:[105,186] width:18 height:18
	button btn146 "smooth" pos:[5,186] width:39 height:18
		fn smooth2 sn=(
		mysmooth=smooth ()
		for a in selection do addmodifier a (mysmooth)
		mysmooth.autosmooth=on
		mysmooth.threshold=sn
		spn117.value=mysmooth.threshold
		convertToPoly selection
			)
		fn _smooth n=(
			mysmooth=smooth ()
			for a in geometry do addmodifier a (mysmooth)
			mysmooth.autosmooth=on
			mysmooth.threshold=n
			convertTo geometry PolyMeshObject
			spn117.value= mysmooth.threshold
			)
			
		fn bake L=(
		try(
			be = LightingMap()
			for i in selection do (i.removeAllBakeElements())
			for i in selection do (i.addBakeElement be)
			be.fileName = ".bmp" -----输出格式
			for i in selection do (i.nDilations = 4)
			spn4.value= $.nDilations
			) catch()
	)
	colorPicker cp16 "" pos:[76,210] width:23 height:16 color:(color 38 38 38)
	colorPicker cp17 "" pos:[98,210] width:23 height:16 color:(color 225 198 87)
	colorPicker cp18 "" pos:[120,210] width:23 height:16 color:(color 26 177 88)
	button btn21 "ClearVertColor" pos:[5,147] width:77 height:17
	button btn246 "自发光" pos:[85,147] width:58 height:17 toolTip:"选择自发光物体"
	button btn19 "ViewLightmap" pos:[5,230] width:75 height:18
	button btn23 "m" pos:[122,230] width:23 height:18
	button btn292 "vShell" pos:[81,230] width:38 height:18
	button btn106 "选择带通道的" pos:[9,122] width:94 height:18
	button btn33 "Add" pos:[5,250] width:39 height:18
	button btn34 "Add_vr" pos:[45,250] width:59 height:18
	button btn117 "Render" pos:[105,250] width:41 height:18
	button btn51 "中心" pos:[105,122] width:34 height:18
	on btn90 changed state do
	(
	try
	(
			btn91.Checked = on
			btn92.Checked = off
			modPanel.addModToSelection (VertexPaint ()) ui:on
			for i in selection do (i.showVertexColors = on)
				)
		--catch()
		catch messageBox "在物体状态下使用"
		)
	on btn91 changed state do
	(
		btn90.Checked = off
		btn92.Checked = OFF
		for i in selection do (i.showVertexColors = on)
	)
	on btn92 changed state do
	(
		btn90.Checked = OFF
		btn91.Checked = OFF
		for i in selection do (i.showVertexColors = off)
	)
	on btn93 pressed do
	(
			for i in 1 to 24 do  /*根据材质球个数设定循环次数，24材质球时循环24次*/
			(
			 meditMaterials[i] = Standardmaterial()  /*将当前材质球设定为标准材质*/
			 meditMaterials[i].name = i as string + " - CGmolin"  /*将当前材质球命名，名称为'i - Default'*/
			)
		)
	on btn94 pressed do
	(
	disableSceneRedraw()
	if scenematerials.count>0 and geometry.count>0 do
	(
	em=meditMaterials
	m=scenematerials
	clearSelection()
	select(geometry[1])
	s=m.count
	x=int(s/24)---计算取整
	y=mod s 24 ---计算余数
	global k
	if k==undefined then k=1
	if k>x+2 do k=1
	if y>0 and k==x+1  do
	(
	for j=1 to 24 do
	   (
	     new_mat_name = (j+24*(k-1)) as string + " - Default"
	     em[j] = standard name:new_mat_name 
	   )
	)
	for j=1 to 24 do 
	   (
	     if (j+24*(k-1))<s+1 then
	     em[j]=m[j+24*(k-1)]
	   )
	clearSelection()
	pushPrompt ("第 "as string+k as string+" 批材质成功运行!!   "as string +s as string+"个场景材质。")
	k=k+1
	if k==x+1 and y==0 do k=1
	if k==x+2 and y>0 do k=1
	)
	if scenematerials.count==0 do
	(pushPrompt ("本场景没有任何材质"))
	enableSceneRedraw()
	)
	on btn95 pressed do
	(
			--- get all multi material objects . 
			Multi_Mat_objs = for i in geometry where classof i.material ==Multimaterial collect i 
			--- make a fn for the search . 
			fn found_Sub_Multi theMat = 
			(
			local theR = off
			if classof theMat == MultiMaterial do 
			(
			for i in theMat.materialList do 
			(
			if classof i ==MultiMaterial do theR = on 
			
			)
			)
			return theR 
			)
			
			--- search in these objects . 
			multi_multi_Mat_objs = for i in Multi_Mat_objs where (found_Sub_Multi i.material) collect i
			-- show the name for check . 
			for i in Multi_Multi_Mat_objs do print i.name 
			-- select them . 
			select Multi_Multi_Mat_objs
		)
	on btn96 pressed do
	(
			fn select0FaceObj =
			( 
				clearSelection()
				num=0
				for obj in geometry do (fv=getPolygonCount obj ;if fv[1]==0 do (num+=1;selectMore obj) )
				pushPrompt (num as string+" objects are zero face")
			) 
			select0FaceObj()
		)
	on btn97 pressed do
	(
			fn selectUnMaterialObj =
			( 
				clearSelection()
				num=0
				for obj in geometry do if obj.material==undefined do (num+=1;selectMore obj)
				pushPrompt (num as string+" objects have no material")
			) 
			selectUnMaterialObj()
		)
	on btn98 pressed do
	(
			select (for o in geometry where isproperty o "vertexpaint" collect o)
		)
	on btn99 pressed do
		select(for o in geometry where classof o.material == Multimaterial collect o)
	on btn100 pressed do
	if selection.count == 0 then (MessageBox "Please Pick " title:"Transform")
			else
				(	
				$.pos.x = 0
				$.pos.y = 0
				$.pos.z = 0
				)
	on btn101 pressed do
	if selection.count == 0 then (MessageBox "Please Pick an Object" title:"TransformTools")
		else
			(
			for i in selection do
				(
				a = i.pos.x
				b = i.pos.y
				c = i.pos.z
				i.rotation.x = 0
				i.rotation.y = 0
				i.rotation.z = 0
				i.pos.x = a
				i.pos.y = b
				i.pos.z = c
				)
			)
	on btn102 pressed do
	if selection.count == 0 then (MessageBox "Please Pick an Object" title:"TransformTools")
		else
			(	
			$.scale.x = 1
			$.scale.y = 1
			$.scale.z = 1
			)
	on btn43 pressed do
	(
	rollout split "Split" width:175 height:60
	(
	button splitbutt "切分" pos:[97,10] width:60 height:20 toolTip:"Split up model to chunks."
	spinner splitspin "段数" pos:[10,13] width:73 height:16 range:[1,100,10] type:#integer fieldwidth:36
	checkbox splitcheck "" pos:[15,37] width:28 height:15 checked:true
	spinner splitspin2 "移动碎片" pos:[31,37] width:126 height:16 range:[0,10000,0] fieldwidth:46	
	on splitbutt pressed do
	(
	if selection.count == 1 and classof $ == Editable_Poly then undo off
		(
		setWaitcursor()
		try(suspendEditing())catch()
		numval = splitspin.value
		polyop.setFaceSelection $.baseobject #all
		distMin = $.min-$.pivot
		distMax = $.max-$.pivot
		for i = 1 to numval do --split up object with slice mod and cap holes
			(
			addmodifier $ (SliceModifier slice_type:1)
			randomrot = quat (random -1.0 1.0) (random -1.0 1.0) (random -1.0 1.0) (random -1.0 1.0)
			$.modifiers[#Slice].Slice_Plane.rotation = randomrot
			randpos = [(random distMin.x distMax.x),(random distMin.y distMax.y),(random distMin.z distMax.z)]
			$.modifiers[#Slice].Slice_Plane.position = randpos
			convertTo $ Editable_Poly
			polyOp.capHolesByEdge $.baseobject #all
			if keyboard.escpressed == true do exit
			)
		try(resumeEditing())catch()
		disablesceneredraw()
		if splitcheck.state == true then --explode elements to seperate objects
			(
			Selobj = $
			splitval = 0
			max select all
			while splitval == 0 do --get a random face and detach the element wich the face is on, then select a new random face and so on until there is no faces left
				(
				elmf = polyop.getElementsUsingFace Selobj.baseobject 1
				polyOp.detachFaces Selobj.baseobject elmf delete:true asNode:true node:Selobj
				if (polyop.getNumFaces Selobj.baseobject) == 0 do (splitval = 1 ; delete Selobj)
				if keyboard.escpressed == true do (splitval = 1 ; delete Selobj)
				)
			max select invert
			CGSplit = selection as array --put all the chunks into an array for later moving
			CGSplit2 = for p in CGSplit collect p.pos --put the positions of all chunks into an array
			)
		else (CGSplit = #() ; CGSplit2 = #())
		enablesceneredraw()
		setArrowcursor()
		gc()
		redrawviews()
		)
	else messagebox "请选择单个物体，在Poly状态下使用" title:"出错"
	)
	on splitcheck changed state do
		splitspin2.enabled = state
	on splitspin2 changed value do
	undo off
				(
				if CGSplit.count != 0 do --move all chunks
					try(
					selnum = 0
					allpos = [0,0,0]
					for d in CGSplit do (selnum += 1 ; allpos += d.center)
					midpos = allpos/selnum
					for w = 1 to selnum do
						(
						levec = normalize (CGSplit[w].center-midpos)
						CGSplit[w].pos = CGSplit2[w] + (levec * value)
						)
					)catch()
				)
	)
	createDialog split width:165 height:70
		)
	on btn517 pressed do
		select(for o in geometry where classof o.material == Shell_Material collect o)
	on cp63 changed col do
	(
		try($.rgb=col)catch()
		)
	on spn87 changed val do
	(
		try($.multiplier=val)catch()
		)
	on tmr32 tick do
	(
	try	(
	if cp63.color!=$.rgb then cp63.color=$.rgb
	if spn87.value!=$.multiplier then spn87.value=$.multiplier
	)catch()
	)
	on btn143 pressed do
	(
	--clearSelection()
			undo on
			(
			smooth2 180
			)
		)
	on btn143 rightClick do
	(
	clearSelection()
			undo on
			(
			_smooth 180
			)
		)
	on btn144 pressed do
	(
	--clearSelection()
			undo on
			(
			smooth2 0	
			)
		)
	on btn144 rightClick do
	(
	clearSelection()
			undo on
			(
			_smooth 0	
			)
		)
	on spn117 changed val do
	(
		)
	on btn145 pressed do
	(
	--clearSelection()
			undo on
			(
			smooth2 45
			)
		)
	on btn145 rightClick do
	(
	clearSelection()
			undo on
			(
			_smooth 45
			)
		)
	on btn146 pressed do
	(
	--clearSelection()
			undo on
			(
			mysmooth=smooth ()
			for a in selection do addmodifier a (mysmooth)
			mysmooth.autosmooth=on
			mysmooth.threshold=spn117.value
			convertTo selection PolyMeshObject
			)
		)
	on btn146 rightClick do
	(
	clearSelection()
			undo on
			(
			mysmooth=smooth ()
			for a in geometry do addmodifier a (mysmooth)
			mysmooth.autosmooth=on
			mysmooth.threshold=spn117.value
			convertToPoly geometry 
			)
		)
	on cp16 changed col do
	(
	geometry.wirecolor = col)
	on cp17 changed col do
	(
	lights.wirecolor = col)
	on cp18 changed col do
	(
	helpers.wirecolor = col)
	on btn21 pressed do
	(
	undo on
	try( 
	for a in selection do 
	( 
	convertToPoly selection
	for i in 1 to a.numverts do polyop.setVertColor a 0 i (color 255 255 255)
	)
	)catch()
	)
	on btn246 pressed do
	(
			clearSelection()
			for a in geometry do 
			try (
			(
			if a.material.selfIllumAmount>0 then selectmore a 
			  )
			) catch()
		)
	on btn19 pressed do
	(
	mm=1-mm;
			for m in scenematerials do 
			(
			if classof m == Shell_Material then
		(
		if mm==1 then 
		(
			m.viewportMtlIndex = 1
			m.renderMtlIndex = 0
	)
		else 
		(
			m.viewportMtlIndex = 0
			m.renderMtlIndex = 1
	)
			)
			)
		)
	on btn23 pressed do
	(
		mm=1-mm;
		for m in sceneMaterials do
		(
			if classof m == standardmaterial then
		(
			if mm==1 then showTextureMap m on else showTextureMap m off
				)
				)
	)
	on btn292 pressed do
	(
		mm=1-mm;
		for m in sceneMaterials do
		(
		if classof m == shell_material then
		(
			if mm==1 then 
			(
			showTextureMap m.originalmaterial on 
			showTextureMap m.bakedMaterial on
			)
			else 
			(
			showTextureMap m.originalmaterial off
			showTextureMap m.bakedMaterial off
			)
				)
				)	
			)
	on btn106 pressed do
	(
	clearSelection()
	for a in geometry do 
	(
	try(
		if a.material.opacityMapEnable==on then selectmore a
		)
		catch()
		)
		)
	on btn33 pressed do
	(
	for i in selection do (i.removeAllBakeElements())
	be = LightingMap()
	for i in selection do (i.addBakeElement be)
	be.elementName = "LightingMap" -----lightmap材质名字
	be.fileName = ".bmp" -----输出格式
	be.outputSzX = 512
	be.outputSzy = 512
	for b in selection do b.nDilations = 4
	)
	on btn34 pressed do
	(
	for i in selection do (i.removeAllBakeElements())
	be = VrayLightingMap()
	for i in selection do (i.addBakeElement be)
	be.elementName = "VrayLightingMap" -----lightmap材质名字
	be.fileName = ".bmp" -----输出格式
	be.outputSzX = 512
	be.outputSzy = 512
	for b in selection do b.nDilations = 4
	)
	on btn117 pressed do
	(
	macros.run "Render" "BakeDialog"
	)
	on btn51 pressed do
	(
	for a in selection do CenterPivot a
		)
)
rollout ER "About" width:180 height:68
(
	label lbl1 "CGmolin.GooglePages.Com" pos:[8,36] width:162 height:18 enabled:false
	label lbl4 "2006_ _ _ 魔 临" pos:[37,12] width:113 height:18 enabled:false
)
try(DestroyDialog main) catch()

rollout main "MaxTools v2.0" width:168 height:42
(
	checkbutton a "Full" pos:[6,8] width:30 height:23
	checkbutton b "Poly" pos:[37,8] width:30 height:23
	checkbutton c "Uvw" pos:[68,8] width:30 height:23
	checkbutton d "Game" pos:[99,8] width:30 height:23
	checkbutton e "Ab.." pos:[130,8] width:30 height:23
	subRollout sub_Rollout "" pos:[5,38] width:0 height:0
	
		fn alloff a =
	(
	a.Checked = off
	b.Checked = off
	c.Checked = off
	d.Checked = off
	e.Checked = off
			removeSubRollout Main.sub_Rollout aR
			removeSubRollout Main.sub_Rollout bR
			removeSubRollout Main.sub_Rollout cR
			removeSubRollout Main.sub_Rollout dR
			removeSubRollout Main.sub_Rollout eR
			)
	
		
	--------------rightclick--------右击功能

	on a changed state do
	(
	if state == on then
		(
		alloff a
			main.height = 260
			main.sub_Rollout.height = 260
			main.sub_Rollout.width = 162
			a.Checked = on
			addSubRollout Main.sub_Rollout aR
			)
		else
		(
			main.height -= 222
			main.sub_Rollout.height -= 222
			removeSubRollout Main.sub_Rollout AR
		)
		)
	on a rightClick do
	(
			actionMan.executeAction 0 "40264"
	
	if bf == 1 then
	    (		 
	     	           menuMan.loadMenuFile "full.mnu"
	    bf=0
		)		
			else
				(
				  menuMan.loadMenuFile "DefaultUI.mnu"
	                bf=1
				)
	
	time = not
			(
						timeslider.isVisible()
				 ) 
						timeSlider.setVisible  time
	
	
	if trackbar.visible == true  then 
					    trackbar.visible = false
				else
			          	trackbar.visible = true
	
	
	)
	on b changed state do
	(
		if state == on then
		(
		alloff a
			main.height = 280
			main.sub_Rollout.height = 280
			main.sub_Rollout.width = 162
			b.Checked = on
			addSubRollout Main.sub_Rollout bR
			)
		else
		(
			main.height -= 242
			main.sub_Rollout.height -= 242
			removeSubRollout Main.sub_Rollout bR
		)
	)
	on b rightClick do
	(
	undo on
	try(
		convertTo $ PolyMeshObject
		) catch ()
		)
	on c changed state do
	(
	if state == on then
		(
	alloff a
			main.height = 260
			main.sub_Rollout.height = 260
			main.sub_Rollout.width = 162
			c.Checked = on
			addSubRollout Main.sub_Rollout cR
			)
		else
		(
			main.height -= 222
			main.sub_Rollout.height -= 222
			removeSubRollout Main.sub_Rollout cR
		)
	)
	on c rightClick do
	(
			undo on
	try(
		modPanel.addModToSelection (Uvwmap ()) ui:on
		subobjectLevel = 1
		) catch ()
		)
		
	on d changed state do
	(
		if state == on then
		(
			alloff a	
			main.height = 340
			main.sub_Rollout.height = 340
			main.sub_Rollout.width = 162
			d.Checked = on
			addSubRollout Main.sub_Rollout dR
			)
		else
		(
			main.height -= 302
			main.sub_Rollout.height -= 302
			removeSubRollout Main.sub_Rollout dR
		)
	)
	on d rightClick do
	(
	 try (fileIn "$UI/MacroScripts/Molin/materialTools.ms")catch()
	 )
	on e changed state do
	(
			if state == on then
		(
	alloff a
			main.height = 120
			main.sub_Rollout.height = 120
			main.sub_Rollout.width = 162
			e.Checked = on
			addSubRollout Main.sub_Rollout eR
			)
		else
		(
			main.height -= 83
			main.sub_Rollout.height -= 83
			removeSubRollout Main.sub_Rollout eR
		)
	)
)
CreateDialog main dialog_x dialog_y 50 80



