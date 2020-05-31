rollout cmzy "ÖØÃæ·´Ãæ"
	
(	
	local c = #()
	groupbox gb1 "ÍêÈ«ÖØÃæ" width:185 height:90 pos:[0,5]
	groupbox gb3 "" width:75 height:90 pos:[110,5]
	button getobj "¼ÓÈëÑ¡ÔñµÄE_Poly" pos:[3,25] width:105 height:25
	button ff "´¦ÀíÖØÃæ" pos:[115,50] width:65 height:30 enabled:false tooltip:"Ñ¡ÔñE_PolyºóµãÎÒ"
	radiobuttons sd labels:#("Ñ¡", "É¾") pos:[114,25] default:2
	label kj "ÓÅÏÈ£º" pos:[5,55]
	radiobuttons sorc labels:#("¿ì","¾»") pos:[40,55] default:1 --enabled:false
	label inf "¾ÍĞ÷... ..." pos:[30,75]
	
	---
	
	groupbox Dirt "Dirt¼ì²â" width:185 height:80 pos:[0,155]
	spinner radius "Dirt ·¶Î§£º" pos:[30,195] width:80 range:[0,1000,0.1]
	spinner zfg "×Ô ·¢ ¹â£º" pos:[30,215] width:80 range:[0,100,100] type:#integer
	radiobuttons is labels:#("Fixed ", "Adaptive DMC") pos:[5,175] default:2
	button chk "äÖÈ¾¼ì²â" pos:[115,195] width:65 height:35
	button help "ËµÃ÷" pos:[150,172] tooltip:"°ïÖú" width:30
	----
	groupbox fmcz "·´Ãæ´¦Àí" width:185 height:50 pos:[0,100]
	button zfm "·´Ãæ´¦Àí" pos:[115,112] width:65 height:30
	label korjl "·½Ê½£º" pos:[5,120]
	radiobuttons korj "" labels:#("¿ì","¾«") pos:[40,120] default:1
	
	--
		
	on getobj pressed do

		(	
			if selection.count > 1 then messagebox "Ò»´ÎÖ»ÄÜÑ¡Ò»¸öÎïÌå" else 
			(
				if selection.count == 0 then messagebox "ÇëÏÈÑ¡ÔñÒ»¸öE_PolyÎïÌå" else 
				(	
					if classof $ != Editable_Poly then 
						
						(
							messagebox "Ö»ÄÜÑ¡E_PolyÊµÌåÀàĞÍ"
							ff.enabled = false 
							
						) 	else
						
					(
						getobj.text = "ÒÑÑ¡ "+ $.name
						ff.enabled = true
						inf.caption = "ÎïÌåÃæÊı£º" + (polyop.getNumFaces $) as string
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
						
						inf.caption = "ÒÑÕÒµ½ " + c.count as string + "¸öÖØÃæ"
					)
					else 
					
					(
						$.EditablePoly.SetSelection #Face (c as bitarray) 
						$.EditablePoly.delete #Face 
						inf.caption = "ÒÑÇå³ı " + (facea - (polyop.getnumfaces $)) as string + "¸öÖØÃæ"
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
			dirtm.name = "dirt_zy_×£Ô¸°æ"
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
			
		) catch(messagebox "µ±Ç°äÖÈ¾Æ÷²»ÊÇV-Ray»òV-Ray°æ±¾²»¼æÈİ¡£")
		
	on help pressed do messagebox  "´Ë¹¦ÄÜÊÇÀûÓÃV-Ray Dirt²ÄÖÊÈË¹¤äÖÈ¾¼ì²éÖØÃæ·´Ãæ¡£\näÖÈ¾ÖØÃæ´¦»á³öÏÖ»¨ÃæÂÌ°ß£¬·´Ãæ´¦¿ÉÄÜ»á³öÏÖºÚÉ«¡£\nÔÚ²¿·İ(32Î»)°æ±¾ÖĞ¿ÉÄÜ²»ÊÊÓÃ¡£\n´ËäÖÈ¾Íê³Éºó²»»á¸Ä±ääÖÈ¾Æ÷Ô­ÓĞÉèÖÃ,äÖÈ¾ÉèÖÃÏîÇë×ÔĞĞÉèÖÃ¡£" title:"V-Ray DirtÖØÃæ¼ì²â"
	
---

on korj changed state do if korj.state == 2 then messagebox "½¨Òé½ö¿ìËÙÇå³ıÎŞĞ§Ê±Ê¹ÓÃ¾«È·Çå³ı£¡\nÎïÌåÃæÊı¹ı¶àÊ±(Èç>300Ãæ)ÇëÄÍĞÄµÈºò£¡\n²Ù×÷Ç°Çë´æÅÌ£¡£¡" title:"ÖØÒªÌáÊ¾£¡£¡"
	
on zfm pressed do
		
	if korj.state == 1 then
		
	try	(
			if selection.count > 1 then messagebox "Ò»´ÎÖ»ÄÜÑ¡Ò»¸öÎïÌå" else 
				
				(
					if selection.count == 0 then messagebox "ÇëÏÈÑ¡ÔñÒ»¸öÎïÌå" else 
						
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
			if selection.count > 1 then messagebox "Ò»´ÎÖ»ÄÜÑ¡Ò»¸öÎïÌå" else 
				
				(
					if selection.count == 0 then messagebox "ÇëÏÈÑ¡ÔñÒ»¸öÎïÌå" else 
						
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
rollout ctzy "ÍêÈ«ÖØÌå"
	
(
local c = #()
label lb1 "·¶Î§£º" pos:[5,10]
radiobuttons sos  labels:#("³¡¾°","Ñ¡Ôñ") width:100 pos:[40,10] default:2
button f2 "²éÕÒ" pos:[140,5] width:40 height:25

on f2 pressed do

		if sos.state == 2 then 
			
			(
				if selection.count <= 1 then messagebox "ÇëÑ¡Ôñ¿ÉÒÉÎïÌå¶Ñ"  else
					 
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
								messagebox "Ã»ÓĞÕÒµ½ÖØÎïÌå" beep:off
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
						messagebox "Ã»ÓĞÕÒµ½ÖØÎïÌå" beep:off
					)
					
			)
			
	
	
on sos changed state do if sos.state == 1 then messagebox "µ±³¡¾°ÎïÌåÊıÌ«¶àÊ±ÇëÄÍĞÄµÈºî£¡\nµ±³¡¾°ÎïÌå¹ı¶àÊ±²»ÍÆ¼öÊ¹ÓÃ \nÊ¹ÓÃÇ°Çë´æÅÌ" beep:off title:"ÖØÌå²éÕÒÌáÊ¾£º"	
	
)

----------
rollout abt "¹ØÓÚ°ïÖú"
	
(
	
button openabt ">>µã»÷²é¿´°ïÖúËµÃ÷<<" width:180 height:30

rollout abtin "ÖØÃæÖÕ½á-×£Ô¸°æ V1.7 °ïÖúËµÃ÷"
		
(	
			
	hyperlink  cm1 ">>>>ÖØÃæÇå³ı°ïÖú<<<<" enabled:false color:(color 200 0 0)  pos:[65,5]
	label al1 "Ò»¡¢ÖØÃæÇå³ıÖ»ÄÜ¶ÔE_PolyµÄÍêÈ«ÖØÃæÑ¡»òÉ¾³ı"
	label al2 "²¿·İÖØÃæ²éÕÒ¹¦ÄÜ½«ÔÚÒÔºó°æ±¾ÍêÉÆ¡£               "
	label al3 "¶ş¡¢ÎïÌåÃæÊı¹ı´óÊ±¿ÉÏÈÓÃ¿ìËÙÄ£Ê½ºóÔÙÓÃ¸É¾»"
	label al4 "Ä£Ê½¡£ÓÉÓÚ²ÉÓÃËÙ¶ÈÓÅÏÈ·½Ê½£¬ÓĞµÄÎïÌå¿ÉÄÜĞè"
	label al5 "Òª¶à´Î²Ù×÷²ÅÄÜÇå³ı¸É¾»¡£                                    "
	label al6 "Èı¡¢µ±ÎïÌåÃæÊı¹ı¶àÊ±Çå³ı¹ı³Ì»áÃ÷ÏÔ±äÂı£¬Èç"
	label al7 "¹ûÃæÊı¹ı´ó£¨ÀıÈç´óÓÚ3000Ãæ£©Çë¸ù¾İÊµ¼ÊÅäÖÃ"
	label al8 "Çé¿ö·ÖÀëÎïÌåºóÔÙ½øĞĞĞ©²Ù×÷¡£                            "
	
	hyperlink  fm1 ">>>>·´ÃæÇå³ı°ïÖú<<<<" enabled:false color:(color 0 200 200)  pos:[65,170]
	label a11 "Ò»¡¢·´ÃæÇå³ı¹¦ÄÜÄ¿Ç°½ö¹©²âÊÔ¡£                         "
	label a12 "¶ş¡¢¿ìËÙÇå³ıÎŞĞ§Ê±ÔÙÓÃ¾«È·Çå³ı¹¦ÄÜ¡£(½ÏÂı)   "
	
	hyperlink  ct1 ">>>>ÖØÌå²éÕÒ°ïÖú<<<<" enabled:false color:(color 0 200 0)  pos:[65,225]
	label al9 	"Ò»¡¢Ñ¡¶¨²éÕÒ·¶Î§À´²éÕÒ£¬³¡¾°ÎïÌå¹ı¶àÊ±Ñ¡Ôñ"
	label al10 "³¡¾°½«»á¹ıÂı£¬Çë°´Êµ¼ÊÇé¿öÑ¡Ôñ¡£                     "
	
	
	hyperlink  war1 "£¡£¡´Ë½Å±¾½«¶ÔÄ£ĞÍ½øĞĞ²Ù×÷£¬²»ÄÜ°Ù·Ö°Ù" enabled:false color:red  pos:[15,280]
	hyperlink  war2 "±£Ö¤ÈÎºÎ²Ù×÷ºóµÄÕıÈ·ĞÔ£¬Ê¹ÓÃÇ°Çë´æÅÌ¡£" enabled:false color:red  pos:[15,300]

	
	hyperlink  ab1 ">>>>·´À¡Óë¸üĞÂ<<<<" enabled:false color:(color 0 0 200)  pos:[70,320]
	label al15 "×£Ô¸°æ£º×£Ô¸ÌìÏÂËùÓĞÈËÆ½°²ĞÒ¸££¬½¡¿µ³£ÔÚ¡£"
	
	----
				
	hyperlink getzy "ÁªÏµ¸üĞÂ:zhouyang_14@yahoo.com.cn" pos:[34,355] color:(color 128 128 0) address:"http://wpa.qq.com/msgrd?v=3&uin=313703763&site=qq&menu=yes"

	
)
	on openabt pressed do 
		(   
			createDialog abtin width:260 height:370 
		)
	
)
Dialog = newrolloutfloater "ÖØÃæÖÕ½á-×£Ô¸°æ" 200 352
addrollout cmzy dialog
addrollout ctzy dialog 
addrollout abt  dialog
abt.open = false ÿÖ