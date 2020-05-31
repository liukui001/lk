macroScript activeType
category:"Terabyte"
buttonText:"ActiveType"
tooltip:"ActiveType"
(

global activeType, activeTypePreferences
global activeTypePos -- added on 0.30
global activeTypeExitText
global activeTypeWidth
global activeTypeHeight
global activeTypeMaxItems
global activeTypeWildCard
global activeTypeStartMenuBar -- added on 0.30
global activeTypeCustomColors
global activeTypeColorText
global activeTypeColorTextBG
global activeTypeColorList
global activeTypeColorListBG
global activeTypeINIFile = (getDir #plugcfg + "\\activeType.ini")
global activeTypeINICmdFile = (getDir #plugcfg + "\\activeTypeCommands.ini")

local debugMode = off

fn getColor key default:gray =
(
	theColorText = try(getINISetting activeTypeINIFile "Preferences" key)catch("")
	if theColorText != "" then
	(
		arr = filterString theColorText " "
		color (arr[1] as float) (arr[2] as float) (arr[3] as float)		
	)
	else
	(
		default
	)
)
	
fn activeTypeLoadSettings =
(
	activeTypeExitText = try(getINISetting activeTypeINIFile "Preferences" "Exit Text")catch("@")
	val = (getINISetting activeTypeINIFile "Preferences" "Width") as integer
	activeTypeWidth = if val != 0 then val else 100
	val = (getINISetting activeTypeINIFile "Preferences" "Height") as integer
	activeTypeHeight = if val != 0 then val else 18
	val = (getINISetting activeTypeINIFile "Preferences" "Max Items") as integer
	activeTypeMaxItems = if val != 0 then val else 15
	val = (getINISetting activeTypeINIFile "Preferences" "Wild Cards") as integer
	activeTypeWildCard = if val == 0 then false else true
	val = (getINISetting activeTypeINIFile "Preferences" "Start Menu Bar") as integer
	activeTypeStartMenuBar = if val == 0 then false else true
	val = (getINISetting activeTypeINIFile "Preferences" "Custom Colors") as integer
	activeTypeCustomColors = if val == 0 then false else true
	
	activeTypeColorText = getColor "Color Text" default:black
	activeTypeColorTextBG = getColor "Color Text BG" default:(color 200 200 200)
	activeTypeColorList = getColor "Color List" default:black
	activeTypeColorListBG = getColor "Color List BG" default:(color 160 160 160)
)
activeTypeLoadSettings()


------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

try(destroyDialog activeType)catch()

rollout activeType "" height:18
	-- unable to set height "18" to variable "activeTypeHeight"
	-- the global variable needs to be outside the macroscript scope
	-- also unable to use try-catch
(	
	local theClass
	local theSection = "geometryClasses"
	
	local classGeoExemptions = #()
	local classModExemptions = #(OldVertexPaint, Old_Point_Cache, EmptyModifier_Old, Missing_OSM)
	local activeTypeClasses = #()
	local defaultClasses = #()
	local filtersClasses = #()	
	local parameterClasses = #()
	local commandClasses = #()
	local executeClasses = #()
	
	local selectedText
	
	local checkParam
	local checkCommand
	local checkObject
	local checkModifier
	
	dotNetControl classTxt "TextBox" pos:[-100,-100]
	dotNetControl textView "Label" pos:[2,2] width:(ActiveTypeWidth-4) visible:on
	dotNetControl classList "ListBox" pos:[2,18] width:(ActiveTypeWidth-4) height:0
	
	fn compareFN v1 v2 valArray: =
	(
		local v1i = valArray[v1][2]
		local v2i = valArray[v2][2]
		local d = v1i - v2i
		case of
		(
			(d > 0.): -1
			(d < 0.): 1
			default: 0
		)
	)
	
	-- this will resize the UI width as you type in the textbox
	-- it will also resize the UI height depending on the listbox height
	-- lastly, it will also offset the UI if the size is off-screen
	-- added on 0.30
	fn resizeUI txt arr =
	(
		local txtWidth = 0
		local arrWidth = 0
		local newWidth = activeTypeWidth
		local theHeight = activeType.height
		local barHeight = if activeTypeStartMenuBar then 30 else 0 -- start menu bar height ?
		
		txtWidth = (getTextExtent txt).x		
		if txt != "" then
		(
			tempArr = #()
			for i in arr do
			(
				append tempArr ((getTextExtent (i as string)).x)
			)
			arrWidth = if tempArr.count > 0 then amax tempArr else 0
		)		
		maxWidth = amax #(txtWidth, arrWidth)
		
		if (maxWidth + 50) > activeTypeWidth then
		(
			newWidth = maxWidth + 50
			activeType.width = newWidth
			textView.width = classList.width = newWidth-4
		)
		else
		(
			activeType.width = activeTypeWidth
			textView.width = classList.width = activeTypeWidth-4
		)
		
		mX = mouse.screenPos.x
		mY = mouse.screenPos.y
		pSize = sysInfo.desktopSize
		pCenter = pSize/2
		pRight = if mX > pCenter.x then true else false
		pBottom = if mY > pCenter.y then true else false
		
		pX = if pRight and activeTypePos.x + newWidth > pSize.x then activeTypePos.x-((activeTypePos.x + newWidth) - pSize.x) else activeTypePos.x
		pY = if pBottom and activeTypePos.y + theHeight > pSize.y-barHeight then (activeTypePos.y-((activeTypePos.y + theHeight) - pSize.y))-barHeight else activeTypePos.y
		
		setDialogPos activeType ([pX,pY])
	)
	
	-- this will sort the classes based on the ini file counters
	fn loadFilters =
	(
		local tempArr = #()
		
		for c in defaultClasses do
		(	
			theValue = getINISetting activeTypeINIFile theSection (c as string)
			if theValue != "" then append tempArr #(c, (theValue as integer))
		)
		count = tempArr.count
		dexArr = for i in 1 to count collect i
		qSort dexArr compareFN valArray:tempArr
		
		filtersClasses = for i in 1 to count collect tempArr[dexArr[i]][1]
	)
	
	fn saveFilters theSec theClass val =
	(
		setINISetting activeTypeINIFile theSec theClass val
	)
	
	-- this will update the classes with the sorted classes
	fn updateClassList =
	(		
		loadFilters()
		count = defaultClasses.count
		tempClasses = deepCopy defaultClasses
		for i in count to 1 by -1 do
		(
			if findItem filtersClasses tempClasses[i] != 0 then
			(
				deleteItem tempClasses i
			)
		)
		activeTypeClasses = join filtersClasses tempClasses		
		tempClasses = #()
	)
	
	-- max9 equivalent of the substituteString fn on higher max versions
	fn substituteSingleString sourceString fromString toString =
	(
		newString = sourceString
		for i in sourceString.count to 1 by -1 do
		(
			if sourceString[i] == fromString then newString[i] = toString
		)
		newString
	)
	
	-- will convert spaces into *
	-- forDisplay:
	--    true: will remove the * from the text
	--    false: will return the generated text as is with the *
	fn spacesAsWildcard txt forDisplay:false =
	(
		txtArr = filterString txt " "
		count = txtArr.count
		
		newTxt = ""
		
		if txt[1] == " " do
		(
			newTxt = "*" + newTxt
		)
		
		if count == 0 then
		(
			newTxt
		)
		else
		(
			for i in 1 to count do
			(
				newTxt += txtArr[i] + "*"
			)
		)
		if forDisplay then newTxt = substring newTxt 1 (newTxt.count-1)
-- 		if forDisplay then newTxt = substituteString txt " " "*" -- not max9 compatible
		if forDisplay then newTxt = substituteSingleString txt " " "*"
		
		newTxt
	)
	
	-- will return an array of items that match the txt
	fn search txt arr =
	(
		local isCmd = false
		items = #()
		realPat = if activeTypeWildCard then spacesAsWildcard txt else  txt + "*"
		if txt != "" and txt[1] == "#" do isCmd = true
		for t in arr do
		(
			x = t as string
			pat = realPat
			if isCmd do
			(
				pat = substring realPat 2 -1
				if pat.count == 0 do pat = "*"
			)
			if matchPattern x pattern:pat do
			(
				append items x
			)
		)
		items
	)
	
	-- check to see if the mouse is outside the borders of the script UI
	fn checkMouse =
	(
		state = true
		mp = mouse.screenpos
		dp = getdialogpos activeType
		
		above_this = (mp.y < (dp.y+activeTypeHeight))
		below_this = (mp.y > (dp.y+activeType.height))
		left_this = (mp.x < dp.x)
		right_this = (mp.x >(dp.x+activeType.width))
		
		if (above_this or below_this) \
		or (left_this or right_this) then state = true else state = false
		
		state
	)
	
	fn incrementClassCounter txt =
	(
		theClass = try(classList.selectedItem)catch()
		if theClass != undefined do
		(
			theSec = theSection
			-- save and increment the counter for the class
			count = try(getINISetting activeTypeINIFile theSec theClass)catch(0)
			saveFilters theSec theClass (((count as integer)+1) as string)
		)
	)
	
	fn exec =
	(
		incrementClassCounter selectedText
		case of
		(
			checkParam:
			(
				global activeTypeTempObj = modPanel.getCurrentObject()
				if activeTypeTempObj == undefined do activeTypeTempObj = $
				execString = "activeTypeTempObj" + classTxt.text				
				try(execute execString)catch(format "%\n" (getCurrentException()))
			)
			checkCommand:
			(
				index = findItem commandClasses theClass
				try(execute (executeClasses[index]))catch(format "%\n" (getCurrentException()))
			)
			checkObject:
			(
				try
				(
					defaultClassesString = for i in defaultClasses collect i as string
					index = findItem defaultClassesString classList.selectedItem
					if index != 0 do startobjectcreation defaultClasses[index]
				)
				catch
				(
					pushPrompt "Unable to create object."
				)
			)
			checkModifier:
			(	
				try
				(
					defaultClassesString = for i in defaultClasses collect i as string
					index = findItem defaultClassesString classList.selectedItem
					if index != 0 do AddMod defaultClasses[index]
				)
				catch
				(
					pushPrompt "Unable to add modifier."
				)
			)
			checkExecute:
			(
				execString = subString classTxt.text 2 classTxt.text.count
				with undo on try(execute execString)catch(format "%\n" (getCurrentException()))
				print execString
			)
		)
		destroyDialog activeType
	)
	
	fn cleantxt txt =
	(
		txt_count = txt.count
		the_text = ""
		if txt_count != 0 do
		(
			for i in 1 to txt_count where txt[i] != " " do
			(
				the_text += txt[i]
			)
		)
		the_text
	)
	
	fn dotNetColor clr =
	(		
		(dotNetClass "System.Drawing.Color").fromARGB clr.r clr.g clr.b
	)
	
	fn buildParameterList arr =
	(
		local tmpObj = modPanel.getCurrentObject()
		local parameterClasses = #()
		local validParamClasses = #(Integer, Float, String, BooleanClass)
		
		for obj in arr do
		(
			if tmpObj == undefined do tmpObj = obj
			for i in (getPropNames tmpObj) do
			(
				p = getProperty tmpObj i
				c = classOf p
				if (findItem validParamClasses c) != 0 do
				(
					if (findItem parameterClasses ("." + i)) == 0 do
					(
						append parameterClasses ("." + i)
					)
				)
			)
		)
		parameterClasses
	)
	
	fn buildcommandClasses =
	(
		-- built-in commands
		local theCmd = #("ActiveType INI", "ActiveType Commands", "ActiveType Preferences")
		local theExe = #("shellLaunch activeTypeINIFile \"\"", "shellLaunch activeTypeINICmdFile \"\"", "macros.run \"Terabyte\" \"activeTypePreferences\"")
			
		commandClasses = getINISetting activeTypeINICmdFile "Commands"
		executeClasses = #()		
		for i in commandClasses do append executeClasses (getINISetting activeTypeINICmdFile "Commands" i)
		
		join commandClasses theCmd
		join executeClasses theExe
		
		commandClasses
-- 		#(cmd, realCmd)
	)
	
	fn initClassList =
	(
		defaultClasses = #()
		txt = classTxt.text
		
		checkParam = $ != undefined and txt[1] == "."
		checkCommand = txt[1] == "#" 
		checkExecute = txt[1] == "=" 
		checkObject = $ == undefined and not checkExecute
		checkModifier = $ != undefined and not checkExecute
		
		case of
		(
			checkParam:
			(
				theSection = "parameterClasses"
				--parameterClasses = buildParameterList $
				defaultClasses = buildParameterList selection
			)
			checkCommand:
			(
				theSection = "commandClasses"
				--commandClasses = buildcommandClasses()
				defaultClasses = buildcommandClasses()
			)
			checkExecute:
			(
				theSection = "geometryClasses"
				defaultClasses = #()
			)
			checkObject:
			(
				theSection = "geometryClasses"
				
				geometryClasses = for i in geometryClass.classes where okToCreate i collect i
				shapeClasses = for i in shape.classes where okToCreate i collect i
				lightClasses = for i in light.classes where okToCreate i collect i
				cameraClasses = for i in camera.classes where okToCreate i collect i
				helperClasses = for i in helper.classes where okToCreate i collect i
				spaceWarpClasses = for i in SpacewarpObject.classes where okToCreate i collect i
				systemClasses = for i in System.classes where okToCreate i collect i
				
				--defaultClasses = #()
				defaultClasses += geometryClasses
				defaultClasses += shapeClasses
				defaultClasses += lightClasses
				defaultClasses += cameraClasses
				defaultClasses += helperClasses
				defaultClasses += spaceWarpClasses
				defaultClasses += systemClasses
				
				cleanUpClasses = for i in defaultClasses where (findItem classGeoExemptions i == 0) collect i
				defaultClasses = cleanUpClasses
				
			)
			checkModifier:
			(
				theSection = "modifierClasses"
				
				modifierClasses = for i in modifier.classes where (mcrUtils.ValidMod i) collect i
				spaceWarpModClasses = for i in SpacewarpModifier.classes where (mcrUtils.ValidMod i) collect i
				
				--defaultClasses = #()
				defaultClasses += modifierClasses
				defaultClasses += spaceWarpModClasses
				
				cleanUpClasses = for i in defaultClasses where (findItem classModExemptions i == 0) collect i
				defaultClasses = cleanUpClasses
			)
		)
		updateClassList()
	)
	
	on activeType open do
	(
		setIniSetting activeTypeINICmdFile "Commands" "Save" "max file save"
		if activeTypeCustomColors do
		(
			textView.ForeColor = dotNetColor activeTypeColorText
			textView.BackColor = dotNetColor activeTypeColorTextBG
			classList.ForeColor = dotNetColor activeTypeColorList
			classList.BackColor = dotNetColor activeTypeColorListBG
		)
		setfocus classTxt
		activeTypePos = getDialogPos activeType
	)
	
	fn setItems ui arr =
	(
		ui.items.clear()
        v = maxversion()
		
        for i in arr do
        (
            if v[1]/1000 >= 12 then
			(
                ui.items.add i
			)
            else
			(
                ui.items.add (dotNetObject "System.String" i)
			)
        )
	)
	
	on classTxt TextChanged arg do
	(
		txt = classTxt.text
		
		if txt != activeTypeExitText then
		(
			if txt.count == 1 do initClassList() -- defaultClasses will be generated based on the 1st text string
			
			textView.text = if txt[1] != "=" then (if activeTypeWildCard then spacesAsWildcard txt forDisplay:true else txt) else txt
			
			items = search txt activeTypeClasses
			if debugMode do items = try(for i in 1 to (txt as integer) collect (i as string))catch(#()) -- type in numbers to define list height

			count = try(items.count)catch(0)				
			
			if txt != "" and count != 0 then
			(
				setItems classList items				
				
				h =
				(
					case (sysInfo.getLanguage())[1] of
					(
						9: 13 -- English (US)
						17: -- Japanese (Nihonggo)
						(
							--max2010 on a Japanese Vista OS 64bit seems to be using 12
							if (maxVersion())[1]/1000 == 12 then 13 else 12
						)
						default: 13
					)
				)
				maxCount = activeTypeMaxItems
				
				listH = (amin (count*h) (maxCount*h)) + 4 -- text height + 6 pixel border offset
				
				activeType.height = activeTypeHeight + listH + 2
				classList.height = listH
				classList.height = listH
				
				classList.selectedIndex = 0
				selectedText = classList.selectedItem
			)
			else
			(
				classList.items.clear()
				classList.height = 0
				activeType.height = activeTypeHeight					
			)
			resizeUI txt items
		)
		else
		(
			try(destroyDialog activeType)catch()
		)
	)
	
	on classTxt KeyUp arg do
	(
		txt = classTxt.text
		dex = classList.selectedIndex
		count = classList.items.count
		txtcount = txt.count
		
		case arg.keyValue of
		(
			-- entered
			13:
			(
				if txtcount != 0 then
				(
					if txt[1] == "." and findString txt "=" == undefined then
					(
						classTxt.text = selectedText + "="
						classTxt.SelectionStart = classTxt.text.count
					)
					else
					(
						exec()
					)
				)
				else
				(
					destroyDialog activeType
				)
			)
			-- up
			38:
			(
				classTxt.SelectionStart = txtcount
				
				newDex = dex - 1
				if newDex <= count-1 and newDex > -1 do classList.selectedIndex = newDex
				selectedText = classList.selectedItem
			)
			
			-- down
			40:
			(
				classTxt.SelectionStart = txtcount
				
				newDex = dex + 1
				try(if newDex <= count-1 and newDex > -1 do classList.selectedIndex = newDex)catch()
				selectedText = classList.selectedItem
			)
			-- TAB
			9:
			(		
				selectedText = classList.selectedItem
				if selectedText != undefined then
				(
					classTxt.text = selectedText
					if selectedText != "" and selectedText[1] == "." do
					(
						classTxt.text += "="
					)
					classTxt.SelectionStart = classTxt.text.count
				)
			)
			-- ESC
			27:
			(
				destroyDialog activeType
			)
			--default: print arg.keyValue
		)
	)
	
	on classTxt LostFocus arg do
	(
		if checkMouse() do
		(
			try(destroyDialog activeType)catch()
		)
	)
	
	on classList mouseUp arg do
	(
		txt = classTxt.text
		selectedText = classList.selectedItem
		if txt[1] == "." and findString txt "=" == undefined then
		(
			classTxt.text = selectedText + "="
			classTxt.SelectionStart = classTxt.text.count
			setFocus classTxt
		)
		else
		(
			exec()
		)

	)
	
	on activeType close do
	(
		try(destroyDialog activeType)catch()
	)
)

if (getfiles activeTypeINIFile).count == 0 then
(
	try(macros.run "Terabyte" "activeTypePreferences")catch()
)
else
(
	mX = mouse.screenPos.x
	mY = mouse.screenPos.y
	pSize = sysInfo.desktopSize
	pCenter = pSize/2
	pLeft = if mX < pCenter.x then true else false
	pTop = if mY < pCenter.y then true else false
	
	pX = if pLeft and mX < activeTypeWidth then mX else activeTypeWidth
	pY = if pTop and mY < activeTypeHeight then mY else activeTypeHeight
	
	createDialog activeType pos:(mouse.screenPos-[pX,pY]) \
	escapeEnable:true bgColor:activeTypeColorListBG style:#(style_border) \
	width:activeTypeWidth
)

) -- end main


------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------


macroScript activeTypePreferences
category:"Terabyte"
buttonText:"ActiveType Preferences"
tooltip:"ActiveType Preferences"
(
	global activeType, activeTypePreferences
	global activeTypePos
	global activeTypeExitText
	global activeTypeWidth
	global activeTypeHeight
	global activeTypeMaxItems
	global activeTypeWildCard
	global activeTypeStartMenuBar
	global activeTypeCustomColors
	global activeTypeColorText
	global activeTypeColorTextBG
	global activeTypeColorList
	global activeTypeColorListBG
	global activeTypeINIFile = (getDir #plugcfg + "\\activeType.ini")
	global activeTypeINICmdFile = (getDir #plugcfg + "\\activeTypeCommands.ini")

	fn getColor key default:gray =
	(
		theColorText = try(getINISetting activeTypeINIFile "Preferences" key)catch("")
		if theColorText != "" then
		(
			arr = filterString theColorText " "
			color (arr[1] as float) (arr[2] as float) (arr[3] as float)		
		)
		else
		(
			default
		)
	)
		
	fn activeTypeLoadSettings =
	(
		activeTypeExitText = try(getINISetting activeTypeINIFile "Preferences" "Exit Text")catch("@")
		val = (getINISetting activeTypeINIFile "Preferences" "Width") as integer
		activeTypeWidth = if val != 0 then val else 100
		val = (getINISetting activeTypeINIFile "Preferences" "Height") as integer
		activeTypeHeight = if val != 0 then val else 18
		val = (getINISetting activeTypeINIFile "Preferences" "Max Items") as integer
		activeTypeMaxItems = if val != 0 then val else 15
		val = (getINISetting activeTypeINIFile "Preferences" "Wild Cards") as integer
		activeTypeWildCard = if val == 0 then false else true
		val = (getINISetting activeTypeINIFile "Preferences" "Start Menu Bar") as integer
		activeTypeStartMenuBar = if val == 0 then false else true
		val = (getINISetting activeTypeINIFile "Preferences" "Custom Colors") as integer
		activeTypeCustomColors = if val == 0 then false else true
		
		activeTypeColorText = getColor "Color Text" default:black
		activeTypeColorTextBG = getColor "Color Text BG" default:(color 200 200 200)
		activeTypeColorList = getColor "Color List" default:black
		activeTypeColorListBG = getColor "Color List BG" default:(color 160 160 160)
	)
	activeTypeLoadSettings()
	
	try(destroyDialog activeTypePreferences)catch()
	
	rollout activeTypePreferences "ActiveType 0.30" width:175 height:310
	(
		GroupBox grp_pref "Settings:" pos:[5,0] width:165 height:120
		GroupBox grp_colors "" pos:[5,125] width:165 height:100
		
		label lbl_exit "Exit Text:" pos:[10,20] height:13
		label lbl_width "Box Width:" pos:[10,40] height:13
		label lbl_maxitems "Max Items:" pos:[10,60] height:13
		
		label lbl_ftext "Field Text:" pos:[10,145] height:13
		label lbl_fbg "Field Background:" pos:[10,165] height:13
		label lbl_listtext "List Text:" pos:[10,185] height:13
		label lbl_listbg "List Background:" pos:[10,205] height:13
		
		editText edt_exit "" pos:[102,20] width:62 height:17
		spinner spn_width "" pos:[105,40] width:60 height:16 range:[50,1000,activeTypeWidth] type:#integer scale:0.1
		spinner spn_maxitems "" pos:[105,60] width:60 height:16 range:[0,1000,15] type:#integer scale:0.1
		checkBox chk_space "[Spaces] as Wildcards [*]" pos:[10,85] width:140 height:15
		checkBox chk_bar "Windows Start Menu Bar" pos:[10,100] width:140 height:15
		
		checkBox chk_clr "Use Custom Colors:" pos:[10,123]
		colorPicker cp_text "" pos:[100,140] width:63 height:19 modal:off
		colorPicker cp_textbg "" pos:[100,160] width:63 height:19 modal:off
		colorPicker cp_list "" pos:[100,180] width:63 height:19 modal:off
		colorPicker cp_listbg "" pos:[100,200] width:63 height:19 modal:off
		
		button btn_ini "Open INI File" pos:[5,230] width:165 height:25 enabled:on
			toolTip:"Open the activeType.ini file."
		button btn_cmd "Open Commands File:" pos:[5,255] width:165 height:25
			toolTip:"Open the activeTypeCommands.ini file."
		button btn_edit "Open List Editor:" pos:[5,280] width:165 height:25 enabled:false
			toolTip:"- - Disabled - -\nWill be updated on the next version."
		
		fn fixLabels ui offset:10 =
		(
			for p in ui.controls where classOf p == LabelControl do
			(
				adjust = (ui.width/2)+offset
				txtSize = getTextExtent p.text
				p.pos.x = adjust-txtSize.x
			)
		)
		
		on activeTypePreferences open do
		(
			fixLabels activeTypePreferences
			setFocus activeTypePreferences.edt_exit
			activeTypeLoadSettings()
			edt_exit.text = activeTypeExitText
			spn_width.value = activeTypeWidth
			spn_maxitems.value = activeTypeMaxItems
			chk_space.checked = activeTypeWildCard
			chk_bar.checked = activeTypeStartMenuBar
			chk_clr.checked = activeTypeCustomColors
			cp_text.color = activeTypeColorText
			cp_textbg.color = activeTypeColorTextBG
			cp_list.color = activeTypeColorList
			cp_listbg.color = activeTypeColorListBG
		)
		
		fn stringToRGB clr =
		(
			theR = clr.r as string
			theG = clr.g as string
			theB = clr.b as string
			
			theR + " " + theG + " " + theB
		)
		
		on activeTypePreferences close do
		(
			activeTypeExitText = edt_exit.text
			activeTypeWidth = spn_width.value
			activeTypeMaxItems = spn_maxitems.value
			activeTypeWildCard = chk_space.checked
			activeTypeStartMenuBar  =chk_bar.checked
			activeTypeCustomColors = chk_clr.checked
			activeTypeColorText = cp_text.color
			activeTypeColorTextBG = cp_textbg.color
			activeTypeColorList = cp_list.color
			activeTypeColorListBG = cp_listbg.color
					
			setINISetting activeTypeINIFile "Preferences" "Exit Text" edt_exit.text
			setINISetting activeTypeINIFile "Preferences" "Width" (spn_width.value as string)
			setINISetting activeTypeINIFile "Preferences" "Max Items" (spn_maxitems.value as string)
			setINISetting activeTypeINIFile "Preferences" "Wild Cards" (if chk_space.checked then "1" else "0")
			setINISetting activeTypeINIFile "Preferences" "Start Menu Bar" (if chk_bar.checked then "1" else "0")
			setINISetting activeTypeINIFile "Preferences" "Custom Colors" (if chk_clr.checked then "1" else "0")
			setINISetting activeTypeINIFile "Preferences" "Color Text" (stringToRGB cp_text.color)
			setINISetting activeTypeINIFile "Preferences" "Color Text BG" (stringToRGB cp_textbg.color)
			setINISetting activeTypeINIFile "Preferences" "Color List" (stringToRGB cp_list.color)
			setINISetting activeTypeINIFile "Preferences" "Color List BG" (stringToRGB cp_listbg.color)
		)
		
		on btn_ini pressed do
		(
			try(shellLaunch activeTypeINIFile "")catch()
		)
		
		on btn_cmd pressed do
		(
			try(shellLaunch activeTypeINICmdFile "")catch()
		)
	)
	
	on execute do
	(
		try(createdialog activeTypePreferences)catch()
	)
) -- end preferences


/*
[to do]
/- add all the other classes
/- filtered unnecessary classes
/- add up/down arrow key support
/- preferences
  /- customizable colors
  /- width
  /- shortcut text
  /- max items
/- colors
  /- field text
  /- field bg
  /- list text
  /- list bg
  X- highlight text
  X- highlight bg
  /- disable custom colors
/- space as wildcard
/- fix 2010 list size
- sub-object detection
- support pflow operators
- add borders

/- auto expand width
- auto move input box if on screen edge

list editor
- get maxscript commands
- get macroscript commands
- dynamic custom coloring
*/