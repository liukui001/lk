rollout cmzy "重面反面"
	
(	
	local c = #()
	groupbox gb1 "完全重面" width:185 height:90 pos:[0,5]
	groupbox gb3 "" width:75 height:90 pos:[110,5]
	button getobj "加入选择的E_Poly" pos:[3,25] width:105 height:25
	button ff "处理重面" pos:[115,50] width:65 height:30 enabled:false tooltip:"选择E_Poly后点我"
	radiobuttons sd labels:#("选", "删") pos:[114,25] default:2
	label kj "优先：" pos:[5,55]
	radiobuttons sorc labels:#("快","净") pos:[40,55] default:1 --enabled:false
	label inf "就绪... ..." pos:[30,75]
	
	---
	
	groupbox Dirt "Dirt检测" width:185 height:80 pos:[0,155]
	spinner radius "Dirt 范围：" pos:[30,195] width:80 range:[0,1000,0.1]
	spinner zfg "自 发 光：" pos:[30,215] width:80 range:[0,100,100] type:#integer
	radiobuttons is labels:#("Fixed ", "Adaptive DMC") pos:[5,175] default:2
	button chk "渲染检测" pos:[115,195] width:65 height:35
	button help "说明" pos:[150,172] tooltip:"帮助" width:30
	----
	groupbox fmcz "反面处理" width:185 height:50 pos:[0,100]
	button zfm "反面处理" pos:[115,112] width:65 height:30
	label korjl "方式：" pos:[5,120]
	radiobuttons korj "" labels:#("快","精") pos:[40,120] default:1
	
	--
		
	on getobj pressed do

		(	
			if selection.count > 1 then messagebox "一次只能选一个物体" else 
			(
				if selection.count == 0 then messagebox "请先选择一个E_Poly物体" else 
				(	
					if classof $ != Editable_Poly then 
						
						(
							messagebox "只能选E_Poly实体类型"
							ff.enabled = false 
							
						) 	else
						
					(
						getobj.text = "已选 "+ $.name
						ff.enabled = true
						inf.caption = "物体面数：" + (polyop.getNumFaces $) as string
					)
				)
			)
		)
	
	
	on ff pressed  do  
		
		
	( 
		
		try  facea = polyop.getnumfaces $  catch()
		
									
		(		
			try(	
					c = #()
					subobjectLevel = 4
					a = polyop.getEdgeSelection $ as array
					for i = 1 to polyop.getNumFaces $ do
						
						(	if sorc.state == 2 then 
							
							(
								 for j = 1 to i do
								(	
									if j != i do
									(	
										
										
										if (polyop.getFaceDeg $ i) == (polyop.getFaceDeg $ j) do
										
										(
											if distance (polyop.getFaceCenter $ i) (polyop.getfacecenter $ j ) == 0 then 
											(
											
											append c i
																							
											)
										)
									)
								) 
							)
							
							else 
							
							for j = 1 to (i/(random 2 4) as integer) do
								(	
									if j != i do
									(	
										
										
										if (polyop.getFaceDeg $ i) == (polyop.getFaceDeg $ j) do
										
										(
											if distance (polyop.getFaceCenter $ i) (polyop.getfacecenter $ j ) == 0 then 
											(
											
											append c i
																							
											)
										)
									)
								) 
							
						)
					
					if sd.state == 1 then 
					(
						
						$.EditablePoly.SetSelection #Face (c as bitarray) 
						
						inf.caption = "已找到 " + c.count as string + "个重面"
					)
					else 
					
					(
						$.EditablePoly.SetSelection #Face (c as bitarray) 
						$.EditablePoly.delete #Face 
						inf.caption = "已清除 " + (facea - (polyop.getnumfaces $)) as string + "个重面"
						subobjectLevel = 0
					)
					
					
				
				) catch()
			
		) 
		
	)
	
	
	on chk pressed do
	try (
			vr = renderers.current
			vr.options_overrideMtl_on = true
			vr.gi_on = off 
			if is.state == 1 then vr.imageSampler_type = 0 else vr.imageSampler_type = 1
			vr.filter_on = false

			dirtm = Standardmaterial ()
			dirtm.name = "dirt_zy_祝愿版"
			dirtm.twoSided = on
			dirtm.SelfIllumAmount = zfg.value
			dirtm.diffuseMap = VRayDirt ()
			dirtm.diffuseMap.radius = radius.value
			dirtm.diffuseMap.occluded_color = color 0 192 0
			vr.options_overrideMtl_mtl = dirtm

			render ()
			vr.options_overrideMtl_on = false 
			vr.options_overrideMtl_mtl = undefined 
			vr.gi_on = on 
			vr.filter_on = true 
			
		) catch(messagebox "当前渲染器不是V-Ray或V-Ray版本不兼容。")
		
	on help pressed do messagebox  "此功能是利用V-Ray Dirt材质人工渲染检查重面反面。\n渲染重面处会出现花面绿斑，反面处可能会出现黑色。\n在部份(32位)版本中可能不适用。\n此渲染完成后不会改变渲染器原有设置,渲染设置项请自行设置。" title:"V-Ray Dirt重面检测"
	
---

on korj changed state do if korj.state == 2 then messagebox "建议仅快速清除无效时使用精确清除！\n物体面数过多时(如>300面)请耐心等候！\n操作前请存盘！！" title:"重要提示！！"
	
on zfm pressed do
		
	if korj.state == 1 then
		
	try	(
			if selection.count > 1 then messagebox "一次只能选一个物体" else 
				
				(
					if selection.count == 0 then messagebox "请先选择一个物体" else 
						
						if classof $ == Editable_Poly then 
							
							(
								convertto $ (editable_Mesh)
								subobjectLevel = 4
								actionMan.executeAction 0 "40021"
								meshOps.unifyNormal $
								subobjectLevel = 0
								convertto $ (editable_Poly)
							)
							
						if classof $ == editable_mesh then
							
							(
								subobjectLevel = 4
								actionMan.executeAction 0 "40021"
								meshOps.unifyNormal $
								subobjectLevel = 0
							)
				)
				
		) catch()
		
		else
		
		(
			if selection.count > 1 then messagebox "一次只能选一个物体" else 
				
				(
					if selection.count == 0 then messagebox "请先选择一个物体" else 
						
						if classof $ == Editable_Poly do
							
						try	(
								convertto $ editable_Mesh
								
								a = getNumVerts $
								
								for i = 1 to a do
									
								(
									subobjectLevel = 1
									
									a = getNumVerts $

									for i = 1 to a do 
										
									(		
										for j = 1 to i do
												
											(
												if i != j do
													
												(
													if getVert $ i == getVert $ j then
														
													(
														setVertSelection $ #{i,j}
													)
												)
											)
									) 

								meshOps.collapse $
									
								)
								
								subobjectLevel = 4
								actionMan.executeAction 0 "40021"
								meshOps.unifyNormal $
								subobjectLevel = 0
								convertto $ editable_Poly
								
							) catch()
							
						if classof $ == editable_mesh then
							
						try	(
								a = getNumVerts $
								
								for i = 1 to a do
									
								(
									subobjectLevel = 1
									
									a = getNumVerts $

									for i = 1 to a do 
										
									(		
										for j = 1 to i do
												
											(
												if i != j do
													
												(
													if getVert $ i == getVert $ j then
														
													(
														setVertSelection $ #{i,j}
													)
												)
											)
									) 

								meshOps.collapse $
									
								)
								
								subobjectLevel = 4
								actionMan.executeAction 0 "40021"
								meshOps.unifyNormal $
								subobjectLevel = 0
								
							) catch()
				)
				
		)
	
)

----------
rollout ctzy "完全重体"
	
(
local c = #()
label lb1 "范围：" pos:[5,10]
radiobuttons sos  labels:#("场景","选择") width:100 pos:[40,10] default:2
button f2 "查找" pos:[140,5] width:40 height:25

on f2 pressed do

		if sos.state == 2 then 
			
			(
				if selection.count <= 1 then messagebox "请选择可疑物体堆"  else
					 
					(
						c = #()
						a = selection as array 
						for i = 1 to a.count do
							
						(	
							for j = 1 to i do
								
							(
								if i != j do 
									
								if  distance a[i].pos a[j].pos == 0 then 
									
									if a[i].max.x == a[j].max.x and a[i].max.y == a[j].max.y and a[i].max.z == a[j].max.z then
										
									if a[i].min.x == a[j].min.x and a[i].min.y == a[j].min.y and a[i].min.z == a[j].min.z then
																												
									append c a[i]
							)
						
						)
						
						if c.count != 0 then select c else 
							
							(
								clearSelection()
								messagebox "没有找到重物体" beep:off
							)
					)
			)
			
		else 
			
			(
				c = #()
				a = geometry as array 
				for i = 1 to a.count do
					
				(	
					for j = 1 to i do
						
					(
						if i != j do 
							
						if  distance a[i].pos a[j].pos == 0 then 
							
							if a[i].max.x == a[j].max.x and a[i].max.y == a[j].max.y and a[i].max.z == a[j].max.z then
										
							if a[i].min.x == a[j].min.x and a[i].min.y == a[j].min.y and a[i].min.z == a[j].min.z then
																								
							append c a[i]
					)
				
				)
				
				if c.count != 0 then select c else 
					
					(
						clearSelection()
						messagebox "没有找到重物体" beep:off
					)
					
			)
			
	
	
on sos changed state do if sos.state == 1 then messagebox "当场景物体数太多时请耐心等侯！\n当场景物体过多时不推荐使用 \n使用前请存盘" beep:off title:"重体查找提示："	
	
)

----------
rollout abt "关于帮助"
	
(
	
button openabt ">>点击查看帮助说明<<" width:180 height:30

rollout abtin "重面终结-祝愿版 V1.7 帮助说明"
		
(	
			
	hyperlink  cm1 ">>>>重面清除帮助<<<<" enabled:false color:(color 200 0 0)  pos:[65,5]
	label al1 "一、重面清除只能对E_Poly的完全重面选或删除"
	label al2 "部份重面查找功能将在以后版本完善。               "
	label al3 "二、物体面数过大时可先用快速模式后再用干净"
	label al4 "模式。由于采用速度优先方式，有的物体可能需"
	label al5 "要多次操作才能清除干净。                                    "
	label al6 "三、当物体面数过多时清除过程会明显变慢，如"
	label al7 "果面数过大（例如大于3000面）请根据实际配置"
	label al8 "情况分离物体后再进行些操作。                            "
	
	hyperlink  fm1 ">>>>反面清除帮助<<<<" enabled:false color:(color 0 200 200)  pos:[65,170]
	label a11 "一、反面清除功能目前仅供测试。                         "
	label a12 "二、快速清除无效时再用精确清除功能。(较慢)   "
	
	hyperlink  ct1 ">>>>重体查找帮助<<<<" enabled:false color:(color 0 200 0)  pos:[65,225]
	label al9 	"一、选定查找范围来查找，场景物体过多时选择"
	label al10 "场景将会过慢，请按实际情况选择。                     "
	
	
	hyperlink  war1 "！！此脚本将对模型进行操作，不能百分百" enabled:false color:red  pos:[15,280]
	hyperlink  war2 "保证任何操作后的正确性，使用前请存盘。" enabled:false color:red  pos:[15,300]

	
	hyperlink  ab1 ">>>>反馈与更新<<<<" enabled:false color:(color 0 0 200)  pos:[70,320]
	label al15 "祝愿版：祝愿天下所有人平安幸福，健康常在。"
	
	----
				
	hyperlink getzy "联系更新:zhouyang_14@yahoo.com.cn" pos:[34,355] color:(color 128 128 0) address:"http://wpa.qq.com/msgrd?v=3&uin=313703763&site=qq&menu=yes"

	
)
	on openabt pressed do 
		(   
			createDialog abtin width:260 height:370 
		)
	
)
Dialog = newrolloutfloater "重面终结-祝愿版" 200 352
addrollout cmzy dialog
addrollout ctzy dialog 
addrollout abt  dialog
abt.open = false ��