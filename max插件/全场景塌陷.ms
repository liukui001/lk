boxs = #()
objs = #();
state = IsolateSelection.IsolateSelectionModeActive()
if(state) then
(
	for obj in geometry do
	(
		if(IsolateSelection.IsNodeIsolated obj) then
		(
			append objs obj
		)
	)
)
else(
	for obj in geometry do
	(
		append objs obj
	)
)
for obj in objs do 
(
	s = convertToPoly(box length:100 width:100 height:100 pos:[100,0,0])
	s.EditablePoly.attach obj s
	s.EditablePoly.SetSelection #Face #{1..6}
	s.EditablePoly.delete #Face
	s.pivot = s.center
	resetxform s;
	s = convertToPoly(s);
	append boxs s
	
)
if(state) then
(
	for obj in boxs do
	(
		 selectmore obj
	)
)
if(state) then IsolateSelection.EnterIsolateSelectionMode()

