


rollout whz2 "物体附着表面运动" width:161 height:424
(
	pickbutton btn1 "拾取地面" pos:[8,11] width:69 height:22
	label lbl1 "none" pos:[85,12] width:66 height:19
	pickbutton btn2 "拾取路径" pos:[9,45] width:69 height:24
	label lbl2 "none" pos:[85,47] width:52 height:19
	pickbutton btn3 "拾取物体" pos:[8,80] width:71 height:26
	label lbl3 "none" pos:[83,81] width:45 height:21
	spinner spn1 "启始帧" pos:[10,283] width:138 height:16  
	spinner spn2 "结束帧" pos:[10,309] width:138 height:16 range:[0,1000,100]
	button btn4 "创建动画" pos:[17,383] width:114 height:25 		 
	spinner spn4 "物体距地面高" pos:[12,197] width:119 height:16 range:[0,100000,0]
		
	local biaomian 
	local path
	local car
	local c=#()
	local c1=#()
	local n=0
	local t=0
	local c2=#()
	local c3=#()
	local c4=#()
	local weelfront
	local weelback
	
	 
	 
	
	 
	on btn1 picked zz do
	(   
	  lbl1.text=zz.name
	  biaomian=zz
	 )
	on btn2 picked jj do
	(   
	  lbl2.text=jj.name
	  path=jj
	 )
	on btn3 picked yy do
	(   
	  lbl3.text=yy.name
	  car=yy
	 )
	 	 
	on btn4 pressed do
	(
	     c=#()
	    c1=#()
	    c2=#()
	    c3=#()
	  	  for k=0.01 to 1.0 by 0.01 do
	 (  p=lengthinterp path  k
	        append c p )
		 
	  for i=1 to c.count do
	(   r1=ray c[i] [0,0,-1]  
	 zl=intersectray biaomian r1
	  zll=zl.pos+[0,0,spn4.value]
	   append c1 zll
	)
	  juli=0
	 for u=1 to c1.count-1 do
	 (	dis= distance c1[u] c1[u+1]
	     juli+=dis
	 )
	 
	n=(spn2.value-spn1.value)/100
	t=spn1.value
	
	
	
	set animate on
	
	
	mm=c1.count-1
	for m=1 to mm do 
	(
	 y=c1[m+1].y-c1[m].y
	x=c1[m+1].x-c1[m].x
	an=y/x
	ang=atan(an)
	if x<0 then ang=ang+180
			
	 
		
	z=c1[m+1].z-c1[m].z
	oz= sqrt(x^2+y^2)
	an1=z/oz
	ang1=atan(an1)
	a=360-ang1
	 
	append c2 ang
	append c3 a
	)	 
	 append c2 c2[c2.count]
	 append c3 c3[c3.count]
	  
	
	
	for j=1 to 100 do
	(	at time t car.pos=c1[j]
		
	addnewkey car.rotation.controller.z_Rotation.controller t
	addnewkey car.rotation.controller.y_Rotation.controller t
	 
	
	 t+=n
	 )
	   	for w=1 to c2.count do
	(   car.rotation.controller.z_Rotation.controller.keys[w].value=c2[w]
	   car.rotation.controller.y_Rotation.controller.keys[w].value=c3[w]
		 
	 )
	 
	  		 	     t1=spn1.value
		 if t1!=0 then 
		 (  
		 
		 deletekey  car.pos.controller.x_Position.controller 1
		 deletekey  car.pos.controller.y_Position.controller 1
		 deletekey  car.pos.controller.Z_Position.controller 1
		 )
	 
			 	
	
	   setbeforeort car.Rotation.controller #loop
	   setbeforeort car.position.controller #loop
	
	  setafterort car.Rotation.controller #loop
	   setafterort car.position.controller #loop
	 
	set animate off
		
		)
		 
	  
	 
)
createdialog whz2

