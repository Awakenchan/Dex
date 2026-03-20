local API='http://api.plusgiant5.com'local LastCall=0 local SafeString=function(
Object)local Metatable=getrawmetatable(Object)local IsTable=typeof(Object)==
'table'or typeof(Object)=='userdata'local __tostring=Metatable and rawget(
Metatable,'__tostring')if not IsTable or not __tostring then return tostring(
Object)end rawset(Metatable,'__tostring',nil)local String=tostring(Object)
rawset(Metatable,'__tostring',__tostring)return String end local Call=function(
KonstantType,ScriptPath)assert(type(KonstantType)=='string',
'KonstantType must be string')local Success,Bytecode=pcall(getscriptbytecode,
ScriptPath)if not Success then return
'-- Failed to get script bytecode, error:\n\n--[[\n'..SafeString(Bytecode)..
'\n--]]'end local Elapsed=os.clock()-LastCall if Elapsed<=0.5 then task.wait(0.5
-Elapsed)end local Result=request({Url=API..KonstantType,Body=Bytecode,Method=
'POST',Headers={['Content-Type']='text/plain'}})LastCall=os.clock()if Result.
StatusCode~=200 then return
'-- Error occured while requesting the API, error:\n\n--[[\n'..SafeString(Result
.Body)..'\n--]]'end return Result.Body end local Disassemble=function(ScriptPath
)return Call('/konstant/disassemble',ScriptPath)end if not getgenv().decompile
then assert(getscriptbytecode,'exploit does not support getscriptbytecode.')
local Last=0 local HttpService=cloneref and cloneref(game:GetService(
'HttpService'))or game:GetService('HttpService')getgenv().decompile=function(Scr
)local Ok,Bytecode=pcall(getscriptbytecode,Scr)if not Ok then return
'-- failed to read script bytecode\n--[[\n'..tostring(Bytecode)..'\n--]]'end
local Elapsed=os.clock()-Last if Elapsed<0.12 then task.wait(0.12-Elapsed)end
local Encoder=base64_encode if not Encoder then Encoder=function(Data)local B=
[[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/]]return((Data
:gsub('.',function(X)local R,Byte='',X:byte()for I=8,1,-1 do R=R..(Byte%2^I-Byte
%2^(I-1)>0 and'1'or'0')end return R end)..'0000'):gsub('%d%d%d?%d?%d?%d?',
function(X)if#X<6 then return''end local C=0 for I=1,6 do C=C+(X:sub(I,I)=='1'
and 2^(6-I)or 0)end return B:sub(C+1,C+1)end)..({'','==','='})[#Data%3+1])end
end local Res=request({Url='https://api.lua.expert/decompile',Method='POST',
Headers={['content-type']='application/json'},Body=HttpService:JSONEncode({
script=Encoder(Bytecode)})})Last=os.clock()if not Res or Res.StatusCode~=200
then return'-- api request error\n--[[\n'..(Res and Res.Body or'no response')..
'\n--]]'end return Res.Body end print('decompile set')end getgenv().disassemble=
Disassemble local Players=cloneref(game:GetService('Players'))local
UserInputService=cloneref(game:GetService('UserInputService'))local TweenService
=cloneref(game:GetService('TweenService'))local LocalPlayer=Players.LocalPlayer
local PlayerGui=LocalPlayer:WaitForChild('PlayerGui')local Colors={Bg=Color3.
fromRGB(10,10,12),Panel=Color3.fromRGB(15,15,18),Panel2=Color3.fromRGB(20,20,25)
,Panel3=Color3.fromRGB(25,25,32),Border=Color3.fromRGB(30,30,38),Border2=Color3.
fromRGB(42,42,54),Accent=Color3.fromRGB(232,55,42),Accent2=Color3.fromRGB(255,94
,77),Green=Color3.fromRGB(34,197,94),Green2=Color3.fromRGB(22,160,70),Yellow=
Color3.fromRGB(234,179,8),Blue=Color3.fromRGB(96,165,250),Blue2=Color3.fromRGB(
59,130,210),Purple=Color3.fromRGB(192,132,252),Pink=Color3.fromRGB(244,114,182),
Orange=Color3.fromRGB(251,146,60),Teal=Color3.fromRGB(45,212,191),Text=Color3.
fromRGB(226,226,232),Text2=Color3.fromRGB(136,136,160),Text3=Color3.fromRGB(85,
85,104),Muted=Color3.fromRGB(58,58,72),White=Color3.fromRGB(255,255,255)}local
FontBold=Enum.Font.GothamBold local FontMed=Enum.Font.Gotham local FontMono=Enum
.Font.Code local ClassTags={Workspace={'WS',Colors.Accent2},Players={'PLY',
Colors.Accent2},ReplicatedStorage={'RS',Colors.Accent2},ServerScriptService={
'SSS',Colors.Accent2},StarterGui={'SGI',Colors.Accent2},Lighting={'LIT',Colors.
Accent2},SoundService={'SND',Colors.Accent2},RunService={'RUN',Colors.Accent2},
CoreGui={'CG',Colors.Accent2},StarterPack={'SPK',Colors.Accent2},Teams={'TMS',
Colors.Accent2},Chat={'CHT',Colors.Accent2},ReplicatedFirst={'RF',Colors.Accent2
},Script={'SCR',Colors.Green},LocalScript={'LSC',Colors.Green},ModuleScript={
'MOD',Colors.Green},Part={'PRT',Colors.Blue},MeshPart={'MSH',Colors.Blue},
UnionOperation={'UNI',Colors.Blue},WedgePart={'WDG',Colors.Blue},SpawnLocation={
'SPW',Colors.Blue},Model={'MDL',Colors.Purple},Humanoid={'HMN',Colors.Purple},
Animation={'ANI',Colors.Purple},ScreenGui={'SGU',Colors.Pink},Frame={'FRM',
Colors.Pink},TextLabel={'TXT',Colors.Pink},TextButton={'BTN',Colors.Pink},
TextBox={'INP',Colors.Pink},ImageLabel={'IMG',Colors.Pink},ImageButton={'IBT',
Colors.Pink},Folder={'FLD',Colors.Yellow},Configuration={'CFG',Colors.Yellow},
RemoteEvent={'REM',Colors.Orange},RemoteFunction={'RFN',Colors.Orange},
BindableEvent={'BEV',Colors.Orange},BindableFunction={'BFN',Colors.Orange},
Camera={'CAM',Colors.Text2},StringValue={'STR',Colors.Text2},IntValue={'INT',
Colors.Text2},BoolValue={'BOL',Colors.Text2},NumberValue={'NUM',Colors.Text2},
ObjectValue={'OBJ',Colors.Text2},Sound={'SFX',Colors.Text2}}local Methods={
__base={{'GetFullName','string'},{'GetDebugId','string'},{'GetChildren',
'Instance[]'},{'GetDescendants','Instance[]'},{'FindFirstChild','Instance?'},{
'FindFirstAncestor','Instance?'},{'WaitForChild','Instance'},{'Clone','Instance'
},{'Destroy','void'},{'IsA','bool'},{'IsAncestorOf','bool'},{'IsDescendantOf',
'bool'},{'GetPropertyChangedSignal','RBXScriptSignal'},{'GetAttributes',
'Dictionary'},{'SetAttribute','void'},{'GetAttribute','Variant'}},Part={{
'GetMass','number'},{'GetNetworkOwner','Player?'},{'SetNetworkOwner','void'},{
'CanCollideWith','bool'},{'GetConnectedParts','Part[]'},{'ApplyImpulse','void'}}
,Humanoid={{'TakeDamage','void'},{'MoveTo','void'},{'GetState',
'HumanoidStateType'},{'ChangeState','void'},{'UnequipTools','void'},{'EquipTool'
,'void'}},Player={{'Kick','void'},{'GetMouse','Mouse'},{'GetRankInGroup',
'number'},{'IsInGroup','bool'},{'LoadCharacter','void'},{'HasAppearanceLoaded',
'bool'}},Sound={{'Play','void'},{'Stop','void'},{'Pause','void'}},RemoteEvent={{
'FireServer','void'},{'FireAllClients','void'},{'FireClient','void'},{
'OnClientEvent','RBXScriptSignal'},{'OnServerEvent','RBXScriptSignal'}},
RemoteFunction={{'InvokeServer','Variant'},{'InvokeClient','Variant'},{
'OnClientInvoke','function'},{'OnServerInvoke','function'}}}local ScriptClasses=
{Script=true,LocalScript=true,ModuleScript=true}local ClassFilters={{Label='ALL'
,Col=Colors.Text2,Classes=nil},{Label='Scripts',Col=Colors.Green,Classes={Script
=true,LocalScript=true,ModuleScript=true}},{Label='Models',Col=Colors.Purple,
Classes={Model=true}},{Label='Parts',Col=Colors.Blue,Classes={Part=true,MeshPart
=true,WedgePart=true,UnionOperation=true,SpawnLocation=true}},{Label='GUIs',Col=
Colors.Pink,Classes={ScreenGui=true,Frame=true,TextLabel=true,TextButton=true,
TextBox=true,ImageLabel=true,ImageButton=true}},{Label='Remotes',Col=Colors.
Orange,Classes={RemoteEvent=true,RemoteFunction=true,BindableEvent=true,
BindableFunction=true}},{Label='Folders',Col=Colors.Yellow,Classes={Folder=true,
Configuration=true}},{Label='Values',Col=Colors.Text2,Classes={StringValue=true,
IntValue=true,NumberValue=true,BoolValue=true,ObjectValue=true}}}local
ActiveClassFilter=nil local FilterToSelected=false local HasGetProperties=type(
getproperties)=='function'local HasGetHidden=type(gethiddenproperty)=='function'
local HasSetHidden=type(sethiddenproperty)=='function'local GetAllProperties=
function(Inst)assert(typeof(Inst)=='Instance','Inst must be Instance')local
Props={}if HasGetProperties then local Ok,Raw=pcall(getproperties,Inst)if Ok and
type(Raw)=='table'then for K,V in Raw do Props[K]=V end end if HasGetHidden then
local Ok2,Hidden=pcall(gethiddenproperties,Inst)if Ok2 and type(Hidden)=='table'
then for K,V in Hidden do Props[K]=V end end end end for _,Key in{'Name',
'ClassName','Archivable'}do if Props[Key]==nil then local Ok,V=pcall(function()
return(Inst)[Key]end)if Ok then Props[Key]=V end end end return Props end local
ReadProp=function(Inst,Key)local Ok,Val=pcall(function()return(Inst)[Key]end)if
Ok then return Val end if HasGetHidden then local Ok2,Val2=pcall(
gethiddenproperty,Inst,Key)if Ok2 then return Val2 end end return nil end local
WriteProp=function(Inst,Key,Value)local Ok=pcall(function()(Inst)[Key]=Value end
)if not Ok and HasSetHidden then pcall(sethiddenproperty,Inst,Key,Value)end end
local ValStr=function(V)if V==nil then return'nil'end local T=typeof(V)if T==
'boolean'then return SafeString(V)end if T=='number'then if V==math.floor(V)then
return tostring(math.floor(V))end return string.format('%.5g',V)end if T==
'string'then return V end if T=='Vector3'then return string.format(
'%.3g, %.3g, %.3g',V.X,V.Y,V.Z)end if T=='Vector2'then return string.format(
'%.3g, %.3g',V.X,V.Y)end if T=='CFrame'then local P=V.Position return string.
format('%.3g, %.3g, %.3g',P.X,P.Y,P.Z)end if T=='Color3'then return string.
format('%d, %d, %d',math.floor(V.R*255),math.floor(V.G*255),math.floor(V.B*255))
end if T=='BrickColor'then return V.Name end if T=='UDim2'then return string.
format('{%.3g,%d},{%.3g,%d}',V.X.Scale,V.X.Offset,V.Y.Scale,V.Y.Offset)end if T
=='UDim'then return string.format('%.3g, %d',V.Scale,V.Offset)end if T==
'EnumItem'then return V.Name end if T=='Instance'then return V.ClassName..'('..V
.Name..')'end return SafeString(V)end local ValColor=function(V)if V==nil then
return Colors.Text3 end local T=typeof(V)if T=='boolean'then return V and Colors
.Green or Colors.Accent2 end if T=='number'then return Colors.Blue end if T==
'string'then return Colors.Yellow end if T=='Vector3'or T=='Vector2'then return
Colors.Orange end if T=='CFrame'then return Colors.Purple end if T=='Color3'then
return Colors.Pink end if T=='BrickColor'then return Colors.Pink end if T==
'EnumItem'then return Colors.Teal end if T=='Instance'then return Colors.Blue
end return Colors.Text2 end local ParseEdit=function(Raw,V)assert(type(Raw)==
'string','Raw must be string')local T=typeof(V)if T=='string'then return Raw end
if T=='number'then return tonumber(Raw)end if T=='boolean'then local Lo=Raw:
lower()if Lo=='true'or Lo=='1'then return true end if Lo=='false'or Lo=='0'then
return false end return nil end if T=='Vector3'then local A,B,Cc=Raw:match(
'([%d%.%-]+)[,%s]+([%d%.%-]+)[,%s]+([%d%.%-]+)')if A then return Vector3.new(
tonumber(A),tonumber(B),tonumber(Cc))end end if T=='Vector2'then local A,B=Raw:
match('([%d%.%-]+)[,%s]+([%d%.%-]+)')if A then return Vector2.new(tonumber(A),
tonumber(B))end end return nil end local IsEditable=function(V)local T=typeof(V)
return T=='string'or T=='number'or T=='boolean'or T=='Vector3'or T=='Vector2'end
local GetClassTag=function(Inst)assert(typeof(Inst)=='Instance',
'Inst must be Instance')local Tag=ClassTags[Inst.ClassName]if Tag then return(
Tag[1]),(Tag[2])end return Inst.ClassName:sub(1,3):upper(),Colors.Text2 end
local FullPath=function(Inst)assert(typeof(Inst)=='Instance',
'Inst must be Instance')local Parts={}local Cur=Inst while Cur and Cur~=game do
table.insert(Parts,1,Cur.Name)Cur=Cur.Parent end table.insert(Parts,1,'game')
return table.concat(Parts,'.')end local IsScriptClass=function(Inst)return
ScriptClasses[Inst.ClassName]==true end local GetTopService=function(Inst)local
Cur=Inst while Cur do if Cur.Parent==game then return Cur end Cur=Cur.Parent end
return nil end local NewFrame=function(Props)local F=Instance.new('Frame')F.
BorderSizePixel=0 F.BackgroundColor3=Colors.Bg for K,V in pairs(Props or{})do(F)
[K]=V end return F end local NewLabel=function(Props)local L=Instance.new(
'TextLabel')L.BorderSizePixel=0 L.BackgroundTransparency=1 L.TextColor3=Colors.
Text L.Font=FontMono L.TextSize=12 L.TextXAlignment=Enum.TextXAlignment.Left L.
TextYAlignment=Enum.TextYAlignment.Center L.TextTruncate=Enum.TextTruncate.AtEnd
for K,V in pairs(Props or{})do(L)[K]=V end return L end local NewButton=function
(Props)local B=Instance.new('TextButton')B.BorderSizePixel=0 B.BackgroundColor3=
Colors.Panel2 B.TextColor3=Colors.Text2 B.Font=FontMed B.TextSize=10 B.
AutoButtonColor=false for K,V in pairs(Props or{})do(B)[K]=V end return B end
local NewTextBox=function(Props)local T=Instance.new('TextBox')T.BorderSizePixel
=0 T.BackgroundColor3=Colors.Panel3 T.TextColor3=Colors.Text T.Font=FontMono T.
TextSize=11 T.ClearTextOnFocus=false T.TextXAlignment=Enum.TextXAlignment.Left
for K,V in pairs(Props or{})do(T)[K]=V end return T end local NewScroll=function
(Props)local S=Instance.new('ScrollingFrame')S.BorderSizePixel=0 S.
BackgroundTransparency=1 S.ScrollBarThickness=3 S.ScrollBarImageColor3=Colors.
Muted S.CanvasSize=UDim2.new(0,0,0,0)for K,V in pairs(Props or{})do(S)[K]=V end
return S end local AddCorner=function(Radius,Parent)local C=Instance.new(
'UICorner')C.CornerRadius=UDim.new(0,Radius)C.Parent=Parent end local AddStroke=
function(Col,Thickness,Parent)local S=Instance.new('UIStroke')S.Color=Col S.
Thickness=Thickness S.Parent=Parent end local HLine=function(Parent,Y)NewFrame({
Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,0,Y),BackgroundColor3=Colors.
Border,Parent=Parent})end local ClearChildren=function(Frame)for _,Child in
ipairs(Frame:GetChildren())do Child:Destroy()end end local SG=Instance.new(
'ScreenGui')SG.Name='DEX_Explorer'SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
SG.ResetOnSpawn=false SG.DisplayOrder=9999 local Ok=pcall(function()SG.Parent=
gethui()end)if not Ok then SG.Parent=PlayerGui end local WinW,WinH=980,600 local
IsFullscreen=false local PreFsSize,PreFsPos local Window=NewFrame({Size=UDim2.
new(0,WinW,0,WinH),Position=UDim2.new(0.5,-WinW/2,0.5,-WinH/2),BackgroundColor3=
Colors.Bg,Parent=SG})AddCorner(5,Window)AddStroke(Colors.Border,1,Window)local
TitleBar=NewFrame({Size=UDim2.new(1,0,0,36),BackgroundColor3=Colors.Panel,Parent
=Window})HLine(TitleBar,35)local MakeDot=function(Col,X)local D=NewFrame({Size=
UDim2.new(0,12,0,12),Position=UDim2.new(0,X,0.5,-6),BackgroundColor3=Col,Parent=
TitleBar})AddCorner(6,D)return D end local DotRed=MakeDot(Colors.Accent,12)local
DotYellow=MakeDot(Colors.Yellow,30)local DotGreen=MakeDot(Colors.Green,48)
NewLabel({Text='DEX Explorer by awakenkn',Size=UDim2.new(0,220,1,0),Position=
UDim2.new(0,72,0,0),TextColor3=Colors.Text2,Font=FontBold,TextSize=12,Parent=
TitleBar})local SidebarW,RightW,BBarH=240,220,34 local Content=NewFrame({Size=
UDim2.new(1,0,1,-(36+BBarH)),Position=UDim2.new(0,0,0,36),BackgroundTransparency
=1,Parent=Window})local Sidebar=NewFrame({Size=UDim2.new(0,SidebarW,1,0),
BackgroundColor3=Colors.Panel,Parent=Content})AddStroke(Colors.Border,1,Sidebar)
local SideHdr=NewFrame({Size=UDim2.new(1,0,0,30),BackgroundColor3=Colors.Panel,
Parent=Sidebar})local Sections={'GAME','NIL','RUNNING'}local ActiveSec='GAME'
local SecBtns={}for I,Sec in ipairs(Sections)do local Sb=NewButton({Text=Sec,
Size=UDim2.new(0,62,1,0),Position=UDim2.new(0,(I-1)*62,0,0),
BackgroundTransparency=1,TextColor3=I==1 and Colors.Text or Colors.Text3,Font=
FontBold,TextSize=9,Parent=SideHdr})local Ul=NewFrame({Size=UDim2.new(1,-8,0,2),
Position=UDim2.new(0,4,1,-2),BackgroundColor3=Colors.Accent,
BackgroundTransparency=I==1 and 0 or 1,Parent=Sb})SecBtns[Sec]={Btn=Sb,Line=Ul}
end local NodeCountLbl=NewLabel({Text='0',Size=UDim2.new(0,40,1,0),Position=
UDim2.new(1,-44,0,0),TextColor3=Colors.Accent2,TextXAlignment=Enum.
TextXAlignment.Right,TextSize=10,Font=FontBold,Parent=SideHdr})HLine(Sidebar,30)
local FilterStrip=NewScroll({Size=UDim2.new(1,0,0,26),Position=UDim2.new(0,0,0,
31),ScrollingDirection=Enum.ScrollingDirection.X,ScrollBarThickness=0,Parent=
Sidebar})local ChipRefs={}local ChipX=4 for _,Flt in ipairs(ClassFilters)do
local W=#Flt.Label*7+16 local Chip=NewButton({Text=Flt.Label,Size=UDim2.new(0,W,
0,18),Position=UDim2.new(0,ChipX,0,4),BackgroundColor3=Flt.Classes==nil and
Color3.new(Flt.Col.R*0.25,Flt.Col.G*0.25,Flt.Col.B*0.25)or Colors.Panel2,
TextColor3=Flt.Col,Font=FontBold,TextSize=9,Parent=FilterStrip})AddCorner(9,Chip
)table.insert(ChipRefs,{Chip=Chip,Flt=Flt})ChipX=ChipX+W+5 end local SelChipW=72
local SelChip=NewButton({Text='Selected',Size=UDim2.new(0,SelChipW,0,18),
Position=UDim2.new(0,ChipX,0,4),BackgroundColor3=Colors.Panel2,TextColor3=Colors
.Teal,Font=FontBold,TextSize=9,Parent=FilterStrip})AddCorner(9,SelChip)ChipX=
ChipX+SelChipW+5 FilterStrip.CanvasSize=UDim2.new(0,ChipX,0,0)HLine(Sidebar,57)
local SearchBox=Instance.new('TextBox')SearchBox.PlaceholderText=
'Filter instances...'SearchBox.PlaceholderColor3=Colors.Text3 SearchBox.Text=''
SearchBox.BackgroundColor3=Colors.Panel2 SearchBox.TextColor3=Colors.Text
SearchBox.Font=FontMono SearchBox.TextSize=11 SearchBox.BorderSizePixel=0
SearchBox.ClearTextOnFocus=false SearchBox.Size=UDim2.new(1,-16,0,24)SearchBox.
Position=UDim2.new(0,8,0,62)SearchBox.TextXAlignment=Enum.TextXAlignment.Left
SearchBox.Parent=Sidebar AddCorner(3,SearchBox)HLine(Sidebar,90)local TreeScroll
=NewScroll({Size=UDim2.new(1,0,1,-91),Position=UDim2.new(0,0,0,91),Parent=
Sidebar})local Center=NewFrame({Size=UDim2.new(1,-(SidebarW+RightW),1,0),
Position=UDim2.new(0,SidebarW,0,0),BackgroundTransparency=1,Parent=Content})
local CenterHdr=NewFrame({Size=UDim2.new(1,0,0,52),BackgroundColor3=Colors.Panel
,Parent=Center})AddStroke(Colors.Border,1,CenterHdr)local SelName=NewLabel({Text
='\u{2014}',Size=UDim2.new(0.65,0,0,26),Position=UDim2.new(0,14,0,5),TextColor3=
Colors.Text,Font=FontBold,TextSize=20,Parent=CenterHdr})local SelClass=NewLabel(
{Text='',Size=UDim2.new(0.65,0,0,18),Position=UDim2.new(0,14,0,29),TextColor3=
Colors.Text2,TextSize=11,Parent=CenterHdr})local SelPath=NewLabel({Text=
'Select an instance',Size=UDim2.new(0.35,-14,0,18),Position=UDim2.new(0.65,0,0.5
,-9),TextColor3=Colors.Text3,TextSize=10,TextXAlignment=Enum.TextXAlignment.
Right,Parent=CenterHdr})local TabBar=NewFrame({Size=UDim2.new(1,0,0,28),Position
=UDim2.new(0,0,0,52),BackgroundColor3=Colors.Panel,Parent=Center})AddStroke(
Colors.Border,1,TabBar)local Tabs={'Properties','Children','Source'}local
TabBtns={}local ActiveTab='Properties'for I,Name in ipairs(Tabs)do local Tb=
NewButton({Text=Name:upper(),Size=UDim2.new(0,88,1,0),Position=UDim2.new(0,(I-1)
*90,0,0),BackgroundTransparency=1,TextColor3=I==1 and Colors.Text or Colors.
Text3,Font=FontBold,TextSize=9,Parent=TabBar})local Ul=NewFrame({Size=UDim2.new(
1,-16,0,2),Position=UDim2.new(0,8,1,-2),BackgroundColor3=Colors.Accent,
BackgroundTransparency=I==1 and 0 or 1,Parent=Tb})TabBtns[Name]={Btn=Tb,Line=Ul}
end local PropsScroll=NewScroll({Size=UDim2.new(1,0,1,-80),Position=UDim2.new(0,
0,0,80),Parent=Center})local RightPanel=NewFrame({Size=UDim2.new(0,RightW,1,0),
Position=UDim2.new(1,-RightW,0,0),BackgroundColor3=Colors.Panel,Parent=Content})
AddStroke(Colors.Border,1,RightPanel)local RightHdr=NewFrame({Size=UDim2.new(1,0
,0,30),BackgroundColor3=Colors.Panel,Parent=RightPanel})NewLabel({Text='METHODS'
,Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),TextColor3=Colors.Text3,
Font=FontBold,TextSize=9,Parent=RightHdr})HLine(RightPanel,30)local
MethodsScroll=NewScroll({Size=UDim2.new(1,0,1,-30),Position=UDim2.new(0,0,0,30),
Parent=RightPanel})local BottomBar=NewFrame({Size=UDim2.new(1,0,0,BBarH),
Position=UDim2.new(0,0,1,-BBarH),BackgroundColor3=Colors.Panel,Parent=Window})
AddStroke(Colors.Border,1,BottomBar)local StatusLbl=NewLabel({Text='',Size=UDim2
.new(1,-210,1,0),Position=UDim2.new(0,10,0,0),TextColor3=Colors.Text3,TextSize=
10,Parent=BottomBar})local StatusThread=nil local SetStatus=function(Msg,Col,
AutoClear)StatusLbl.Text=Msg StatusLbl.TextColor3=Col or Colors.Text3 if
StatusThread then task.cancel(StatusThread)end if AutoClear then StatusThread=
task.delay(AutoClear,function()StatusLbl.Text=''StatusLbl.TextColor3=Colors.
Text3 end)end end local IdeStatus=function(Msg,Col)SetStatus(Msg,Col,(Msg~=''and
Msg~='Press Decompile')and 4 or nil)end local MakeBBarBtn=function(Label,Col,XR,
Cb)local B=NewButton({Text=Label,Size=UDim2.new(0,95,0,22),Position=UDim2.new(1,
-XR,0.5,-11),BackgroundColor3=Col or Colors.Panel2,TextColor3=Col and Colors.
White or Colors.Text2,Font=FontMed,TextSize=10,Parent=BottomBar})AddCorner(3,B)B
.MouseButton1Click:Connect(Cb)return B end local SelInst=nil local ExpandedSet={
}local TreeRowRefs={}local SearchFilter=''local SearchPending=false local
SyncSelChip=function()SelChip.BackgroundColor3=FilterToSelected and Color3.new(
Colors.Teal.R*0.25,Colors.Teal.G*0.25,Colors.Teal.B*0.25)or Colors.Panel2 end
local RenderMethods=function(Inst)assert(typeof(Inst)=='Instance',
'Inst must be Instance')ClearChildren(MethodsScroll)local List={}if Methods[Inst
.ClassName]then for _,M in ipairs(Methods[Inst.ClassName])do table.insert(List,M
)end end for _,M in ipairs(Methods.__base)do table.insert(List,M)end local
RetColors={string=Colors.Yellow,number=Colors.Blue,bool=Colors.Green,void=Colors
.Text3,['Instance[]']=Colors.Purple,['Instance?']=Colors.Purple,Instance=Colors.
Purple,Variant=Colors.Teal,RBXScriptSignal=Colors.Orange}local RowH=36 for I,M
in ipairs(List)do local Y=(I-1)*RowH local Item=NewFrame({Size=UDim2.new(1,0,0,
RowH),Position=UDim2.new(0,0,0,Y),BackgroundTransparency=1,Parent=MethodsScroll}
)Item.MouseEnter:Connect(function()TweenService:Create(Item,TweenInfo.new(0.06),
{BackgroundTransparency=0,BackgroundColor3=Colors.Panel2}):Play()end)Item.
MouseLeave:Connect(function()TweenService:Create(Item,TweenInfo.new(0.06),{
BackgroundTransparency=1}):Play()end)NewLabel({Text=M[1]..'()',Size=UDim2.new(1,
-8,0,18),Position=UDim2.new(0,8,0,4),TextColor3=Colors.Text,TextSize=11,Parent=
Item})NewLabel({Text='\u{2192} '..M[2],Size=UDim2.new(1,-8,0,14),Position=UDim2.
new(0,8,0,20),TextColor3=RetColors[M[2] ]or Colors.Text3,TextSize=9,Parent=Item}
)NewFrame({Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3
=Colors.Border,BackgroundTransparency=0.6,Parent=Item})end MethodsScroll.
CanvasSize=UDim2.new(0,0,0,#List*RowH+4)end local IdeLib=nil local IdeLoadErr=
nil local GetIDE=function()if IdeLib then return IdeLib end if IdeLoadErr then
return nil,IdeLoadErr end local Ok2,Result=pcall(function()return loadstring(
game:HttpGet(
[[https://raw.githubusercontent.com/Awakenchan/Dear-ReGui/refs/heads/main/lib/ide.lua]]
))()end)if Ok2 then IdeLib=Result return IdeLib end IdeLoadErr=SafeString(Result
)return nil,IdeLoadErr end local SyntaxColors={Background=Color3.fromRGB(10,10,
12),Default=Color3.fromRGB(226,226,232),Keyword=Color3.fromRGB(192,132,252),
String=Color3.fromRGB(234,179,8),Number=Color3.fromRGB(96,165,250),Comment=
Color3.fromRGB(85,85,104),Function=Color3.fromRGB(34,197,94),Operator=Color3.
fromRGB(255,94,77),Identifier=Color3.fromRGB(226,226,232),LineNumber=Color3.
fromRGB(58,58,72),Selection=Color3.fromRGB(42,42,54),CurrentLine=Color3.fromRGB(
20,20,25)}local EditorFont=Font.fromEnum(Enum.Font.Code)local ActiveEditor=nil
local SafeName=function(Scr)local Name=typeof(Scr)=='Instance'and(Scr):
GetFullName()or SafeString(Scr)Name=Name:gsub('[\r\n%z%c]','')if#Name>99 then
local Last=Name:match('[^%.]+$')or Name local PrefixLen=90-(#Last+2)if PrefixLen
<1 then Name='..'..Last:sub(-88)else Name=Name:sub(1,PrefixLen)..'..'..Last end
end return Name end local RenderSource=function(Inst)assert(typeof(Inst)==
'Instance','Inst must be Instance')ClearChildren(PropsScroll)if ActiveEditor
then pcall(function()ActiveEditor:Destroy()end)ActiveEditor=nil end PropsScroll.
CanvasSize=UDim2.new(0,0,0,0)local Path=FullPath(Inst)local LastOutput=''local
ToolbarH=36 local Toolbar=NewFrame({Size=UDim2.new(1,0,0,ToolbarH),
BackgroundColor3=Colors.Panel2,Parent=PropsScroll})NewFrame({Size=UDim2.new(1,0,
0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=Colors.Border,Parent=Toolbar}
)NewLabel({Text=SafeName(Inst),Size=UDim2.new(1,-390,1,0),Position=UDim2.new(0,
10,0,0),TextColor3=Colors.Teal,TextSize=11,Font=FontMono,Parent=Toolbar})local
BtnH=24 local MakeToolBtn=function(Label,BgCol,TextCol,XR,W,Cb)local Btn=
NewButton({Text=Label,Size=UDim2.new(0,W,0,BtnH),Position=UDim2.new(1,-XR,0.5,-
BtnH/2),BackgroundColor3=BgCol,TextColor3=TextCol,Font=FontBold,TextSize=10,
Parent=Toolbar})AddCorner(4,Btn)Btn.MouseButton1Click:Connect(Cb)Btn.MouseEnter:
Connect(function()TweenService:Create(Btn,TweenInfo.new(0.08),{BackgroundColor3=
Color3.new(BgCol.R+0.08,BgCol.G+0.08,BgCol.B+0.08)}):Play()end)Btn.MouseLeave:
Connect(function()TweenService:Create(Btn,TweenInfo.new(0.08),{BackgroundColor3=
BgCol}):Play()end)return Btn end local M2,G=8,6 local XCopy=M2+68 local XByte=
XCopy+G+72 local XCpOut=XByte+G+92 local XDec=XCpOut+G+82 local EditorContainer=
NewFrame({Size=UDim2.new(1,0,1,-ToolbarH),Position=UDim2.new(0,0,0,ToolbarH),
BackgroundColor3=Colors.Bg,Parent=PropsScroll})local CodeEditor=nil local
InitEditor=function()if CodeEditor then return true end local Lib=GetIDE()if not
Lib then IdeStatus('IDE failed',Colors.Accent2)return false end local Ok2,Ce=
pcall(function()return Lib.CodeFrame.new({Editable=true,FontSize=13,Colors=
SyntaxColors,FontFace=EditorFont})end)if not Ok2 or not Ce then IdeStatus(
'Editor failed',Colors.Accent2)return false end CodeEditor=Ce ActiveEditor=Ce
pcall(function()local Gui=Ce.Frame or Ce.Instance or Ce.GUI if Gui then Gui.
Parent=EditorContainer Gui.Size=UDim2.new(1,0,1,0)Gui.Position=UDim2.new(0,0,0,0
)end end)return true end local SetEditorText=function(Text)if not CodeEditor
then return end pcall(function()CodeEditor:ClearText()end)pcall(function()
CodeEditor:AppendText(Text)end)end local GetEditorText=function()local T=''
pcall(function()T=CodeEditor:GetText()or''end)return T end local DarkBtn=Color3.
fromRGB(28,28,36)MakeToolBtn('Decompile',DarkBtn,Colors.Text,XDec,82,function()
IdeStatus('Decompiling...',Colors.Yellow)task.spawn(function()if not InitEditor(
)then return end local Ok2,Result for Attempt=1,2 do Ok2,Result=pcall(decompile,
Inst)if Ok2 and Result and Result~=''then break end if Attempt<2 then task.wait(
0.3)end end local Display=SafeName(Inst)if Ok2 and Result and Result~=''then
LastOutput=Result SetEditorText('-- Decompiled: '..Display..'\n'..Result)
IdeStatus(SafeString(#Result)..' chars',Colors.Green)else LastOutput=''
SetEditorText('-- Decompiled: '..Display..'\n-- Decompile failed\n-- Path: '..
Path)IdeStatus('Decompile failed',Colors.Accent2)end end)end)MakeToolBtn(
'Copy Output',DarkBtn,Colors.White,XCpOut,92,function()if LastOutput~=''then
pcall(function()setclipboard(LastOutput)end)IdeStatus('Output copied!',Colors.
Green)task.delay(2,function()IdeStatus('')end)else IdeStatus('No output yet',
Colors.Text3)task.delay(2,function()IdeStatus('')end)end end)MakeToolBtn(
'Bytecode',DarkBtn,Colors.White,XByte,72,function()IdeStatus('Saving...',Colors.
Yellow)task.spawn(function()if not InitEditor()then return end local FName=
SafeName(Inst):gsub('[^%w_%-]','_')local SaveOk,SaveErr=pcall(function()pcall(
function()makefolder('DEX_Bytecode')end)writefile('DEX_Bytecode/'..FName..
'_bytecode.luau',getscriptbytecode(Inst))end)if SaveOk then SetEditorText(
'-- Bytecode saved to:\n-- DEX_Bytecode/'..FName..
'_bytecode.luau\n\n-- Use a Luau disassembler.')IdeStatus('Saved!',Colors.Green)
else SetEditorText('-- Bytecode save failed:\n-- '..SafeString(SaveErr))
IdeStatus('Save failed',Colors.Accent2)end end)end)MakeToolBtn('Copy',DarkBtn,
Colors.White,XCopy,68,function()local Text=GetEditorText()if Text~=''then pcall(
function()setclipboard(Text)end)IdeStatus('Copied!',Colors.Green)task.delay(2,
function()IdeStatus('')end)else IdeStatus('Nothing to copy',Colors.Text3)end end
)task.spawn(function()task.wait(0.05)if not InitEditor()then return end
IdeStatus('Loading...',Colors.Yellow)local Src,Got='',false pcall(function()Src=
game:GetService('ScriptEditorService'):GetEditorSource(Inst)if Src and Src~=''
then Got=true end end)if not Got then for Attempt=1,2 do local Ok2,Result=pcall(
decompile,Inst)if Ok2 and Result and Result~=''then Src=Result Got=true
LastOutput=Result break end if Attempt<2 then task.wait(0.3)end end end if Got
and Src~=''then SetEditorText(Src)IdeStatus(SafeString(#Src)..' chars',Colors.
Green)else SetEditorText('-- unavailable.\n-- Script: '..SafeName(Inst)..
'\n-- Path:   '..Path..
[[


-- Press [Decompile] to attempt decompilation,
-- or [Bytecode] to save raw bytecode.]]
)IdeStatus('Press Decompile',Colors.Text3)end end)end local RenderProps=function
(Inst)assert(typeof(Inst)=='Instance','Inst must be Instance')ClearChildren(
PropsScroll)local Props=GetAllProperties(Inst)local Keys={}for K in pairs(Props)
do table.insert(Keys,K)end table.sort(Keys)local HdrH,RowH,Y=22,28,0 local
GroupHdr=function(Text)local R=NewFrame({Size=UDim2.new(1,0,0,HdrH),Position=
UDim2.new(0,0,0,Y),BackgroundColor3=Colors.Panel2,Parent=PropsScroll})NewLabel({
Text=Text,Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),TextColor3=
Colors.Text3,Font=FontBold,TextSize=9,Parent=R})Y=Y+HdrH end local PropRow=
function(Key,Val)local DispStr=ValStr(Val)local DispCol=ValColor(Val)local
IsCol3=typeof(Val)=='Color3'local Editable=IsEditable(Val)local Row=NewFrame({
Size=UDim2.new(1,0,0,RowH),Position=UDim2.new(0,0,0,Y),BackgroundTransparency=1,
Parent=PropsScroll})Row.MouseEnter:Connect(function()TweenService:Create(Row,
TweenInfo.new(0.06),{BackgroundTransparency=0,BackgroundColor3=Colors.Panel2}):
Play()end)Row.MouseLeave:Connect(function()TweenService:Create(Row,TweenInfo.
new(0.06),{BackgroundTransparency=1}):Play()end)NewFrame({Size=UDim2.new(1,0,0,1
),Position=UDim2.new(0,0,1,-1),BackgroundColor3=Colors.Border,
BackgroundTransparency=0.6,Parent=Row})NewLabel({Text=Key,Size=UDim2.new(0.38,0,
1,0),Position=UDim2.new(0,10,0,0),TextColor3=Colors.Text2,TextSize=11,Parent=Row
})local SwOff=0 if IsCol3 then local Sw=NewFrame({Size=UDim2.new(0,12,0,12),
Position=UDim2.new(0.38,2,0.5,-6),BackgroundColor3=Val,Parent=Row})AddCorner(3,
Sw)AddStroke(Colors.Border2,1,Sw)SwOff=18 end local ValLbl=NewLabel({Text=
DispStr,Size=UDim2.new(0.45,-SwOff-50,1,0),Position=UDim2.new(0.38,SwOff,0,0),
TextColor3=DispCol,TextSize=11,TextTruncate=Enum.TextTruncate.AtEnd,Parent=Row})
local CpBtn=NewButton({Text='\u{2398}',Size=UDim2.new(0,22,0,18),Position=UDim2.
new(1,-50,0.5,-9),BackgroundColor3=Colors.Green2,TextColor3=Colors.White,Font=
FontBold,TextSize=11,Parent=Row})AddCorner(3,CpBtn)CpBtn.MouseButton1Click:
Connect(function()pcall(function()setclipboard(DispStr)end)local Old=CpBtn.
BackgroundColor3 CpBtn.BackgroundColor3=Colors.Green task.delay(0.6,function()
CpBtn.BackgroundColor3=Old end)end)if Editable then local EditBtn=NewButton({
Text='\u{270e}',Size=UDim2.new(0,22,0,18),Position=UDim2.new(1,-24,0.5,-9),
BackgroundColor3=Colors.Blue2,TextColor3=Colors.White,Font=FontBold,TextSize=11,
Parent=Row})AddCorner(3,EditBtn)local Editing=false local EditBox=nil EditBtn.
MouseButton1Click:Connect(function()if Editing then return end Editing=true
ValLbl.Visible=false EditBtn.Visible=false EditBox=NewTextBox({Text=DispStr,Size
=UDim2.new(0.45,-SwOff-28,1,-6),Position=UDim2.new(0.38,SwOff,0,3),
BackgroundColor3=Colors.Panel3,TextColor3=Colors.Text,TextSize=11,Parent=Row})
AddCorner(3,EditBox);(EditBox):CaptureFocus()local CommitEdit=function()if not
Editing then return end Editing=false local Raw=(EditBox).Text local CurVal=
ReadProp(Inst,Key)local Parsed=ParseEdit(Raw,CurVal)if Parsed~=nil then
WriteProp(Inst,Key,Parsed)local NewVal=ReadProp(Inst,Key)DispStr=ValStr(NewVal)
ValLbl.Text=DispStr ValLbl.TextColor3=ValColor(NewVal)end(EditBox):Destroy()
EditBox=nil ValLbl.Visible=true EditBtn.Visible=true end(EditBox).FocusLost:
Connect(function(Enter)if Enter then CommitEdit()else Editing=false(EditBox):
Destroy()EditBox=nil ValLbl.Visible=true EditBtn.Visible=true end end)end)end Y=
Y+RowH end GroupHdr('PROPERTIES')for _,Key in ipairs(Keys)do PropRow(Key,Props[
Key])end local Attrs={}pcall(function()Attrs=Inst:GetAttributes()end)if next(
Attrs)then local AttrKeys={}for K in pairs(Attrs)do table.insert(AttrKeys,K)end
table.sort(AttrKeys)GroupHdr('CUSTOM ATTRIBUTES')for _,K in ipairs(AttrKeys)do
PropRow('['..K..']',Attrs[K])end end PropsScroll.CanvasSize=UDim2.new(0,0,0,Y+8)
end local RenderChildren=function(Inst)local holder=cloneref(Inst)assert(typeof(
holder)=='Instance','Inst must be Instance')ClearChildren(PropsScroll)local Kids
=holder:GetChildren()if#Kids==0 then NewLabel({Text='No children.',Size=UDim2.
new(1,0,0,30),Position=UDim2.new(0,10,0,4),TextColor3=Colors.Text3,TextSize=11,
Parent=PropsScroll})PropsScroll.CanvasSize=UDim2.new(0,0,0,34)return end local
RowH=30 for I,Child in Kids do Kids[I]=cloneref(Child)Child=Kids[I]local Yy=(I-1
)*RowH local Row=NewFrame({Size=UDim2.new(1,0,0,RowH),Position=UDim2.new(0,0,0,
Yy),BackgroundTransparency=1,Parent=PropsScroll})Row.MouseEnter:Connect(function
()TweenService:Create(Row,TweenInfo.new(0.06),{BackgroundTransparency=0,
BackgroundColor3=Colors.Panel2}):Play()end)Row.MouseLeave:Connect(function()
TweenService:Create(Row,TweenInfo.new(0.06),{BackgroundTransparency=1}):Play()
end)local Tag,TagCol=GetClassTag(Child)local Tl=NewLabel({Text=Tag,Size=UDim2.
new(0,34,0,16),Position=UDim2.new(0,8,0.5,-8),BackgroundColor3=Color3.new(TagCol
.R*0.2,TagCol.G*0.2,TagCol.B*0.2),BackgroundTransparency=0,TextColor3=TagCol,
Font=FontBold,TextSize=8,TextXAlignment=Enum.TextXAlignment.Center,Parent=Row})
AddCorner(2,Tl)NewLabel({Text=Child.Name,Size=UDim2.new(0.55,-48,1,0),Position=
UDim2.new(0,48,0,0),TextColor3=Colors.Text,TextSize=11,Parent=Row})NewLabel({
Text=Child.ClassName,Size=UDim2.new(0.45,-10,1,0),Position=UDim2.new(0.55,0,0,0)
,TextColor3=Colors.Text3,TextXAlignment=Enum.TextXAlignment.Right,TextSize=10,
Parent=Row})NewFrame({Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),
BackgroundColor3=Colors.Border,BackgroundTransparency=0.6,Parent=Row})Row.
InputBegan:Connect(function(Inp)if Inp.UserInputType~=Enum.UserInputType.
MouseButton1 then return end SelectInstance(Child)end)end PropsScroll.CanvasSize
=UDim2.new(0,0,0,#Kids*RowH+4)end function SelectInstance(Inst)assert(typeof(
Inst)=='Instance','Inst must be Instance')if SelInst and TreeRowRefs[SelInst]
then local Ref=TreeRowRefs[SelInst]if Ref.Row and Ref.Row.Parent then Ref.Row.
BackgroundTransparency=1 Ref.Accent.BackgroundTransparency=1 end end SelInst=
Inst SelName.Text=Inst.Name SelClass.Text=Inst.ClassName SelPath.Text=FullPath(
Inst)local IsSc=IsScriptClass(Inst)TabBtns['Source'].Btn.Visible=IsSc if
ActiveTab=='Source'and not IsSc then ActiveTab='Properties'end for TabName,Ref
in pairs(TabBtns)do local Active=TabName==ActiveTab Ref.Btn.TextColor3=Active
and Colors.Text or Colors.Text3 Ref.Line.BackgroundTransparency=Active and 0 or
1 end if ActiveTab=='Properties'then RenderProps(Inst)elseif ActiveTab==
'Children'then RenderChildren(Inst)elseif ActiveTab=='Source'then RenderSource(
Inst)end RenderMethods(Inst)if FilterToSelected then RebuildTree()end end local
TreeRowH=24 local BuildTreeRow=function(Inst,Depth,YPos,Scroll)assert(typeof(
Inst)=='Instance','Inst must be Instance')local Tag,TagCol=GetClassTag(Inst)
local IsSel=SelInst==Inst local Row=NewFrame({Size=UDim2.new(1,0,0,TreeRowH),
Position=UDim2.new(0,0,0,YPos),BackgroundColor3=IsSel and Color3.new(Colors.
Accent.R*0.12,Colors.Accent.G*0.12,Colors.Accent.B*0.12)or Colors.Bg,
BackgroundTransparency=IsSel and 0 or 1,Parent=Scroll})Row.MouseEnter:Connect(
function()if SelInst~=Inst then TweenService:Create(Row,TweenInfo.new(0.05),{
BackgroundTransparency=0,BackgroundColor3=Colors.Panel2}):Play()end end)Row.
MouseLeave:Connect(function()if SelInst~=Inst then TweenService:Create(Row,
TweenInfo.new(0.05),{BackgroundTransparency=1}):Play()end end)local Accent=
NewFrame({Size=UDim2.new(0,2,1,0),BackgroundColor3=Colors.Accent,
BackgroundTransparency=IsSel and 0 or 1,Parent=Row})TreeRowRefs[Inst]={Row=Row,
Accent=Accent}local IndX=Depth*13+4 local Kids=Inst:GetChildren()local HasKids=#
Kids>0 local ArrowLbl=NewLabel({Text=HasKids and(ExpandedSet[Inst]and'\u{25be}'
or'\u{25b8}')or'',Size=UDim2.new(0,14,1,0),Position=UDim2.new(0,IndX,0,0),
TextColor3=Colors.Text3,TextSize=11,TextXAlignment=Enum.TextXAlignment.Center,
Parent=Row})local Tl=NewLabel({Text=Tag,Size=UDim2.new(0,32,0,15),Position=UDim2
.new(0,IndX+15,0.5,-7),BackgroundColor3=Color3.new(TagCol.R*0.2,TagCol.G*0.2,
TagCol.B*0.2),BackgroundTransparency=0,TextColor3=TagCol,Font=FontBold,TextSize=
8,TextXAlignment=Enum.TextXAlignment.Center,Parent=Row})AddCorner(2,Tl)NewLabel(
{Text=Inst.Name,Size=UDim2.new(1,-(IndX+54),1,0),Position=UDim2.new(0,IndX+52,0,
0),TextColor3=IsSel and Colors.Text or Colors.Text2,TextSize=11,Parent=Row})Row.
InputBegan:Connect(function(Inp)if Inp.UserInputType~=Enum.UserInputType.
MouseButton1 then return end if HasKids then ExpandedSet[Inst]=not ExpandedSet[
Inst]end SelectInstance(Inst)Row.BackgroundColor3=Color3.new(Colors.Accent.R*
0.12,Colors.Accent.G*0.12,Colors.Accent.B*0.12)Row.BackgroundTransparency=0
Accent.BackgroundTransparency=0 ArrowLbl.Text=HasKids and(ExpandedSet[Inst]and
'\u{25be}'or'\u{25b8}')or''RebuildTree()end)end local function WalkTree(Inst,
Depth,YAcc,Filter,Scroll)local Lf=Filter:lower()local NameMatch=Lf==''or Inst.
Name:lower():find(Lf,1,true)if NameMatch then BuildTreeRow(Inst,Depth,YAcc,
Scroll)YAcc=YAcc+TreeRowH end local ChildDepth=NameMatch and Depth+1 or Depth if
ExpandedSet[Inst]or Lf~=''then for _,Child in ipairs(Inst:GetChildren())do YAcc=
WalkTree(Child,ChildDepth,YAcc,Filter,Scroll)end end return YAcc end local
FlatCollect=function(Root,ClsFilter,NameFilter,Out)assert(typeof(Root)==
'Instance','Root must be Instance')local Lf=NameFilter:lower()local Stack={Root}
while#Stack>0 do local Inst=(table.remove(Stack))local Ok2,Kids=pcall(function()
return Inst:GetChildren()end)if Ok2 then for I=#Kids,1,-1 do table.insert(Stack,
Kids[I])end end local ClsPass=ClsFilter==nil or ClsFilter[Inst.ClassName]==true
local NamePass=Lf==''or Inst.Name:lower():find(Lf,1,true)if ClsPass and NamePass
then table.insert(Out,Inst)end end end local RebuildPending=false function
RebuildTree()if RebuildPending then return end RebuildPending=true task.defer(
function()RebuildPending=false ClearChildren(TreeScroll)TreeRowRefs={}local Y=0
if ActiveSec=='GAME'then local ServiceRoots if FilterToSelected and SelInst then
local Svc=GetTopService(SelInst)ServiceRoots=Svc and{Svc}or{}if#ServiceRoots==0
then NewLabel({Text='No service found for selection.',Size=UDim2.new(1,0,0,30),
Position=UDim2.new(0,10,0,4),TextColor3=Colors.Text3,TextSize=10,Parent=
TreeScroll})TreeScroll.CanvasSize=UDim2.new(0,0,0,34)return end else
ServiceRoots=game:GetChildren()end if ActiveClassFilter~=nil or SearchFilter~=''
then local Matches={}for _,Child in ipairs(ServiceRoots)do FlatCollect(Child,
ActiveClassFilter,SearchFilter,Matches)end NodeCountLbl.Text=SafeString(#Matches
)local Chunk=40 local function DoChunk(I)if I>#Matches then TreeScroll.
CanvasSize=UDim2.new(0,0,0,Y+4)return end local Limit=math.min(I+Chunk-1,#
Matches)for J=I,Limit do BuildTreeRow(Matches[J],0,Y,TreeScroll)Y=Y+TreeRowH end
TreeScroll.CanvasSize=UDim2.new(0,0,0,Y+4)if Limit<#Matches then task.defer(
function()DoChunk(Limit+1)end)end end DoChunk(1)return else local Total=0
local function Cnt(I)Total=Total+1 for _,C in ipairs(I:GetChildren())do Cnt(C)
end end for _,Child in ipairs(ServiceRoots)do Cnt(Child)end NodeCountLbl.Text=
SafeString(Total)for _,Child in ipairs(ServiceRoots)do Y=WalkTree(Child,0,Y,
SearchFilter,TreeScroll)end end elseif ActiveSec=='NIL'then local NilInsts={}
pcall(function()NilInsts=getnilinstances()end)NodeCountLbl.Text=SafeString(#
NilInsts)if#NilInsts==0 then NewLabel({Text=
'getnilinstances() returned 0 results.',Size=UDim2.new(1,0,0,30),Position=UDim2.
new(0,10,0,4),TextColor3=Colors.Text3,TextSize=10,Parent=TreeScroll})Y=34 else
local Lf=SearchFilter:lower()for _,Inst in ipairs(NilInsts)do local ClsPass=
ActiveClassFilter==nil or ActiveClassFilter[Inst.ClassName]==true local NamePass
=Lf==''or Inst.Name:lower():find(Lf,1,true)if ClsPass and NamePass then
BuildTreeRow(Inst,0,Y,TreeScroll)Y=Y+TreeRowH end end end elseif ActiveSec==
'RUNNING'then local RunScripts={}pcall(function()RunScripts=getrunningscripts()
end)NodeCountLbl.Text=SafeString(#RunScripts)if#RunScripts==0 then NewLabel({
Text='getrunningscripts() returned 0 results.',Size=UDim2.new(1,0,0,30),Position
=UDim2.new(0,10,0,4),TextColor3=Colors.Text3,TextSize=10,Parent=TreeScroll})Y=34
else local Lf=SearchFilter:lower()for _,Inst in ipairs(RunScripts)do pcall(
function()local ClsPass=ActiveClassFilter==nil or ActiveClassFilter[Inst.
ClassName]==true local NamePass=Lf==''or Inst.Name:lower():find(Lf,1,true)if
ClsPass and NamePass then BuildTreeRow(Inst,0,Y,TreeScroll)Y=Y+TreeRowH end end)
end end end TreeScroll.CanvasSize=UDim2.new(0,0,0,Y+4)end)end for _,Cr in
ipairs(ChipRefs)do Cr.Chip.MouseButton1Click:Connect(function()ActiveClassFilter
=Cr.Flt.Classes FilterToSelected=false SyncSelChip()for _,Cr2 in ipairs(ChipRefs
)do local Active=Cr2.Flt==Cr.Flt local Fc=Cr2.Flt.Col Cr2.Chip.BackgroundColor3=
Active and Color3.new(Fc.R*0.25,Fc.G*0.25,Fc.B*0.25)or Colors.Panel2 end
RebuildTree()end)end SelChip.MouseButton1Click:Connect(function()if not SelInst
then SetStatus('Select an instance first',Colors.Accent2,3)return end
FilterToSelected=not FilterToSelected SyncSelChip()if FilterToSelected then
ActiveClassFilter=nil for _,Cr2 in ipairs(ChipRefs)do local Fc=Cr2.Flt.Col Cr2.
Chip.BackgroundColor3=Cr2.Flt.Classes==nil and Color3.new(Fc.R*0.25,Fc.G*0.25,Fc
.B*0.25)or Colors.Panel2 end end RebuildTree()end)for _,Sec in ipairs(Sections)
do SecBtns[Sec].Btn.MouseButton1Click:Connect(function()ActiveSec=Sec for _,S in
ipairs(Sections)do local A=S==Sec SecBtns[S].Btn.TextColor3=A and Colors.Text or
Colors.Text3 SecBtns[S].Line.BackgroundTransparency=A and 0 or 1 end
RebuildTree()end)end for TabName,Ref in pairs(TabBtns)do Ref.Btn.
MouseButton1Click:Connect(function()if TabName=='Source'and(not SelInst or not
IsScriptClass(SelInst))then return end ActiveTab=TabName for TN,TR in pairs(
TabBtns)do local A=TN==TabName TR.Btn.TextColor3=A and Colors.Text or Colors.
Text3 TR.Line.BackgroundTransparency=A and 0 or 1 end if SelInst then if
ActiveTab=='Properties'then RenderProps(SelInst)elseif ActiveTab=='Children'then
RenderChildren(SelInst)elseif ActiveTab=='Source'then RenderSource(SelInst)end
end end)end TabBtns['Source'].Btn.Visible=false SearchBox:
GetPropertyChangedSignal('Text'):Connect(function()SearchFilter=SearchBox.Text
if SearchPending then return end SearchPending=true task.delay(0.25,function()
SearchPending=false RebuildTree()end)end)MakeBBarBtn('Refresh',nil,100,function(
)RebuildTree()if SelInst then if ActiveTab=='Properties'then RenderProps(SelInst
)elseif ActiveTab=='Children'then RenderChildren(SelInst)elseif ActiveTab==
'Source'then RenderSource(SelInst)end RenderMethods(SelInst)end end)MakeBBarBtn(
'Copy Path',nil,204,function()if SelInst then local P=FullPath(SelInst)pcall(
function()setclipboard(P)end)SetStatus('Copied: '..P,Colors.Green,3)end end)
DotRed.InputBegan:Connect(function(Inp)if Inp.UserInputType==Enum.UserInputType.
MouseButton1 then SG:Destroy()end end)DotYellow.InputBegan:Connect(function(Inp)
if Inp.UserInputType==Enum.UserInputType.MouseButton1 then Window.Visible=false
end end)DotGreen.InputBegan:Connect(function(Inp)if Inp.UserInputType~=Enum.
UserInputType.MouseButton1 then return end if not IsFullscreen then PreFsSize=
Window.Size PreFsPos=Window.Position TweenService:Create(Window,TweenInfo.new(
0.2,Enum.EasingStyle.Quad),{Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0)}
):Play()IsFullscreen=true DotGreen.BackgroundColor3=Color3.fromRGB(22,160,60)
else TweenService:Create(Window,TweenInfo.new(0.2,Enum.EasingStyle.Quad),{Size=
PreFsSize,Position=PreFsPos}):Play()IsFullscreen=false DotGreen.BackgroundColor3
=Colors.Green end end)UserInputService.InputBegan:Connect(function(Inp,Gpe)if
Gpe then return end if Inp.KeyCode==Enum.KeyCode.End then Window.Visible=true
end end)do local Dragging,DStart,WStart TitleBar.InputBegan:Connect(function(Inp
)if Inp.UserInputType==Enum.UserInputType.MouseButton1 and not IsFullscreen then
Dragging=true DStart=Inp.Position WStart=Window.Position end end)
UserInputService.InputChanged:Connect(function(Inp)if Dragging and Inp.
UserInputType==Enum.UserInputType.MouseMovement then local D=Inp.Position-DStart
Window.Position=UDim2.new(WStart.X.Scale,WStart.X.Offset+D.X,WStart.Y.Scale,
WStart.Y.Offset+D.Y)end end)UserInputService.InputEnded:Connect(function(Inp)if
Inp.UserInputType==Enum.UserInputType.MouseButton1 then Dragging=false end end)
end local AutoExpand={Workspace=true,Players=true,ReplicatedStorage=true,
Lighting=true,StarterGui=true,ServerScriptService=true}for _,Child in ipairs(
game:GetChildren())do if AutoExpand[Child.ClassName]then ExpandedSet[Child]=true
end end RebuildTree()
