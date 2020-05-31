rollout proxyredirect "proxy redirect" width:240 height:136
(
	button btn1 "获取路径" pos:[8,8] width:96 height:25
	label lbl1 "" pos:[8,39] width:216 height:41
	button btn2 "执行" pos:[8,88] width:216 height:25
	progressBar pb1 "" pos:[8,120] width:216 height:8
	checkbox chk1 "复制代理" pos:[136,8] width:88 height:24 checked:true
	
	fn directproxy myproxy newpath copyon=
		(
			local oldfilename=myproxy.filename
			local aaa=filterString myproxy.filename "\\"
			local bbb=findString myproxy.filename (aaa[(aaa.count)])
			local proxyname=substring myproxy.filename bbb -1
			
			--if substring newpath (newpath.count) 1 !="\\"  then
				--(
					myproxy.filename=(newpath+"\\"+proxyname)

			
			
			if copyon==true then copyFile oldfilename (myproxy.filename)
		)
		
	
	on btn1 pressed do
	(
		local myproxyname = getSavePath()
		if substring myproxyname (myproxyname.count) 1 =="\\"  then 
		(
			messagebox "真乃懒人，连个目录都懒得建。 "
			btn2.enabled=false
		)
		else
		(
			btn2.enabled=true
		)
		try(lbl1.caption=myproxyname) catch(false)
	)
	on btn2 pressed do
	(
		pb1.value=0
		newpath=lbl1.caption
		myproxy_array=for i in geometry where classof i == VRayProxy collect i
		for j =1 to myproxy_array.count do 
		(
			pb1.value=((ceil ((100.0/(myproxy_array.count))*j)) as integer)
			directproxy myproxy_array[j] newpath (chk1.checked)
			
		)
	
	)


)



createdialog proxyredirect