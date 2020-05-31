rollout SelectSameNameOBJ "选择重名对象" width:162 height:32
(
	button btn1 "查找" pos:[6,7] width:150 height:21
	on btn1 pressed  do
	(
		objs=$* as array
		s=#()
		for i=1 to objs.count do
		(
			for j=i+1 to objs.count do
			(
				if objs[i].name==objs[j].name do
				(
					join s #(objs[i])
				)
			)
		)
		if s.count==0 then
		(
			messagebox "没有重名的对象！"
		)
		else
		(
			select s
		)
	)
)createdialog SelectSameNameOBJ