É
RC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Common\Constants.cs
	namespace 	
OnlineShoppingApi
 
. 
Common "
{ 
public 

static 
class 
	Constants !
{ 
public 
static 
class 
AddressType '
{ 	
public 
const 
string 
ShippingAddress  /
=0 1
$str2 <
;< =
public 
const 
string 
BillingAddress  .
=/ 0
$str1 :
;: ;
}		 	
public 
static 
class 
OrderStatus '
{ 	
public 
const 
string 
Pending  '
=( )
$str* 3
;3 4
public 
const 
string 
Success  '
=( )
$str* 3
;3 4
public 
const 
string 
Cancel  &
=' (
$str) 1
;1 2
} 	
public 
static 
class 
	SortOrder %
{ 	
public 
const 
string 
Asc  #
=$ %
$str& +
;+ ,
public 
const 
string 
Desc  $
=% &
$str' -
;- .
} 	
public 
static 
class 
	GrantType %
{ 	
public 
const 
string 
Password  (
=) *
$str+ 5
;5 6
} 	
public 
static 
class 

ConfigKeys &
{ 	
public 
const 
string 
AuthO  %
=& '
$str( /
;/ 0
public 
const 
string 
ClientId  (
=) *
$str+ 5
;5 6
public   
const   
string   
ClientSecret    ,
=  - .
$str  / =
;  = >
public!! 
const!! 
string!! 

Connection!!  *
=!!+ ,
$str!!- 9
;!!9 :
public"" 
const"" 
string"" 
Audience""  (
="") *
$str""+ 5
;""5 6
public$$ 
const$$ 
string$$ 
	SignupUrl$$  )
=$$* +
$str$$, 7
;$$7 8
public%% 
const%% 
string%% 
AccessTokenUrl%%  .
=%%/ 0
$str%%1 A
;%%A B
}(( 	
})) 
}** ¢
\C:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Common\SwaggerHeaderConfig.cs
	namespace		 	
OnlineShoppingApi		
 
.		 
Common		 "
{

 
public 

class 
AddHeaderParameter #
:$ %
IOperationFilter& 6
{ 
public 
void 
Apply 
( 
OpenApiOperation *
	operation+ 4
,4 5"
OperationFilterContext6 L
contextM T
)T U
{ 	
var 
authAttributes 
=  
context! (
.( )

MethodInfo) 3
.3 4
DeclaringType4 A
.A B
GetCustomAttributesB U
(U V
trueV Z
)Z [
. 
Union 
( 
context 
. 

MethodInfo %
.% &
GetCustomAttributes& 9
(9 :
true: >
)> ?
)? @
. 
OfType 
< 
AuthorizeAttribute &
>& '
(' (
)( )
;) *
if 
( 
authAttributes 
. 
Any "
(" #
)# $
)$ %
{ 
if 
( 
	operation 
. 
Security &
==' )
null* .
). /
	operation 
. 
Security &
=' (
new) ,
List- 1
<1 2&
OpenApiSecurityRequirement2 L
>L M
(M N
)N O
;O P
var 
scheme 
= 
new  !
OpenApiSecurityScheme! 6
{7 8
	Reference9 B
=C D
newE H
OpenApiReferenceI Y
{Z [
Type\ `
=a b
ReferenceTypec p
.p q
SecuritySchemeq 
,	 Ä
Id
Å É
=
Ñ Ö
$str
Ü é
}
è ê
}
ë í
;
í ì
	operation 
. 
Security "
." #
Add# &
(& '
new' *&
OpenApiSecurityRequirement+ E
{ 
[ 
scheme 
] 
= 
new "
List# '
<' (
string( .
>. /
(/ 0
)0 1
} 
) 
; 
}   
}!! 	
}"" 
}## ‚Q
\C:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Controllers\CartController.cs
	namespace 	
OnlineShoppingApi
 
. 
Controllers '
{ 
[		 
	Authorize		 
]		 
[

 
Route

 

(


 
$str

 
)

 
]

 
[ 
ApiController 
] 
public 

class 
CartController 
:  !
ControllerBase" 0
{ 
private 
readonly 
ILogger  
<  !
CartController! /
>/ 0
_logger1 8
;8 9
private 
readonly 
ICartService %
_cartService& 2
;2 3
public 
CartController 
( 
ILogger %
<% &
CartController& 4
>4 5
logger6 <
,< =
ICartService> J
cartServiceK V
)V W
{ 	
_logger 
= 
logger 
; 
_cartService 
= 
cartService &
;& '
} 	
[ 	
HttpGet	 
] 
public 
IActionResult 
MyCart #
(# $
)$ %
{ 	
_logger 
. 
LogInformation "
(" #
$str# >
)> ?
;? @
string 
userId 
= 
User  
?  !
.! "
Claims" (
?( )
.) *
FirstOrDefault* 8
(8 9
c9 :
=>; =
c> ?
.? @
Type@ D
==E G

ClaimTypesH R
.R S
NameIdentifierS a
)a b
?b c
.c d
Valued i
;i j
var 
productsInCart 
=  
_cartService! -
.- .
GetCartDetails. <
(< =
userId= C
)C D
;D E
_logger 
. 
LogInformation "
(" #
$str# F
)F G
;G H
if 
( 
productsInCart 
== !
null" &
||' )
productsInCart* 8
.8 9
Count9 >
(> ?
)? @
==A C
$numD E
)E F
{   
_logger!! 
.!! 
LogInformation!! &
(!!& '
$str!!' 6
)!!6 7
;!!7 8
return"" 
NotFound"" 
(""  
$str""  N
)""N O
;""O P
}## 
_logger$$ 
.$$ 
LogInformation$$ "
($$" #
$"$$# %
{$$% &
productsInCart$$& 4
.$$4 5
Count$$5 :
($$: ;
)$$; <
}$$< =
$str$$= \
"$$\ ]
)$$] ^
;$$^ _
return%% 
Ok%% 
(%% 
productsInCart%% $
)%%$ %
;%%% &
}&& 	
[(( 	
HttpPost((	 
](( 
public)) 
IActionResult)) 
	AddToCart)) &
())& '
Cart))' +
cart)), 0
)))0 1
{** 	
string,, 
userId,, 
=,, 
User,,  
?,,  !
.,,! "
Claims,," (
?,,( )
.,,) *
FirstOrDefault,,* 8
(,,8 9
c,,9 :
=>,,; =
c,,> ?
.,,? @
Type,,@ D
==,,E G

ClaimTypes,,H R
.,,R S
NameIdentifier,,S a
),,a b
?,,b c
.,,c d
Value,,d i
;,,i j
cart-- 
.-- 
UserId-- 
=-- 
userId--  
;--  !
_logger.. 
... 
LogInformation.. "
(.." #
$str..# ;
)..; <
;..< =
bool// 
result// 
=// 
_cartService// &
.//& '
	AddToCart//' 0
(//0 1
cart//1 5
)//5 6
;//6 7
if11 
(11 
!11 
result11 
)11 
{22 
_logger33 
.33 
LogInformation33 &
(33& '
$str33' F
)33F G
;33G H
return44 

StatusCode44 !
(44! "
StatusCodes44" -
.44- .(
Status500InternalServerError44. J
,44J K
$str44L i
)44i j
;44j k
}55 
_logger66 
.66 
LogInformation66 "
(66" #
$str66# H
)66H I
;66I J
return77 
CreatedAtAction77 "
(77" #
nameof77# )
(77) *
MyCart77* 0
)770 1
,771 2
$str773 X
)77X Y
;77Y Z
}88 	
[== 	
HttpGet==	 
(== 
$str== 
)== 
]== 
public>> 
IActionResult>> 
MyOrders>> %
(>>% &
)>>& '
{?? 	
string@@ 
userId@@ 
=@@ 
User@@  
?@@  !
.@@! "
Claims@@" (
?@@( )
.@@) *
FirstOrDefault@@* 8
(@@8 9
c@@9 :
=>@@; =
c@@> ?
.@@? @
Type@@@ D
==@@E G

ClaimTypes@@H R
.@@R S
NameIdentifier@@S a
)@@a b
?@@b c
.@@c d
Value@@d i
;@@i j
_loggerAA 
.AA 
LogInformationAA "
(AA" #
$strAA# =
)AA= >
;AA> ?
varBB 
	orderListBB 
=BB 
_cartServiceBB (
.BB( )
GetOrderByUserIdBB) 9
(BB9 :
userIdBB: @
)BB@ A
;BBA B
_loggerCC 
.CC 
LogInformationCC "
(CC" #
$strCC# H
)CCH I
;CCI J
ifEE 
(EE 
	orderListEE 
==EE 
nullEE !
||EE" $
	orderListEE% .
.EE. /
CountEE/ 4
(EE4 5
)EE5 6
==EE7 9
$numEE: ;
)EE; <
{FF 
_loggerGG 
.GG 
LogInformationGG &
(GG& '
$strGG' ?
)GG? @
;GG@ A
returnII 
NotFoundII 
(II  
$strII  8
)II8 9
;II9 :
}JJ 
_loggerLL 
.LL 
LogInformationLL "
(LL" #
$"LL# %
{LL% &
	orderListLL& /
.LL/ 0
CountLL0 5
(LL5 6
)LL6 7
}LL7 8
$strLL8 D
"LLD E
)LLE F
;LLF G
returnMM 
OkMM 
(MM 
	orderListMM 
)MM  
;MM  !
}NN 	
[PP 	
HttpPostPP	 
(PP 
$strPP 
)PP 
]PP 
publicQQ 
IActionResultQQ 

PlaceOrderQQ '
(QQ' (
OrderQQ( -
orderQQ. 3
)QQ3 4
{RR 	
stringSS 
userIdSS 
=SS 
UserSS  
?SS  !
.SS! "
ClaimsSS" (
?SS( )
.SS) *
FirstOrDefaultSS* 8
(SS8 9
cSS9 :
=>SS; =
cSS> ?
.SS? @
TypeSS@ D
==SSE G

ClaimTypesSSH R
.SSR S
NameIdentifierSSS a
)SSa b
?SSb c
.SSc d
ValueSSd i
;SSi j
orderTT 
.TT 
UserIdTT 
=TT 
userIdTT !
;TT! "
_loggerVV 
.VV 
LogInformationVV "
(VV" #
$strVV# 5
)VV5 6
;VV6 7
varWW 
resultWW 
=WW 
_cartServiceWW %
.WW% &
OrderProductsWW& 3
(WW3 4
orderWW4 9
)WW9 :
;WW: ;
ifXX 
(XX 
!XX 
resultXX 
)XX 
{YY 
_loggerZZ 
.ZZ 
LogInformationZZ &
(ZZ& '
$strZZ' >
)ZZ> ?
;ZZ? @
return[[ 

StatusCode[[ !
([[! "
StatusCodes[[" -
.[[- .(
Status500InternalServerError[[. J
,[[J K
$str	[[L ™
)
[[™ ´
;
[[´ ¨
}\\ 
_logger]] 
.]] 
LogInformation]] "
(]]" #
$str]]# >
)]]> ?
;]]? @
return^^ 
CreatedAtAction^^ "
(^^" #
nameof^^# )
(^^) *
MyOrders^^* 2
)^^2 3
,^^3 4
$str^^5 Q
)^^Q R
;^^R S
}`` 	
[bb 	
HttpGetbb	 
(bb 
$strbb 
)bb 
]bb 
publiccc 
IActionResultcc 
GetAllOrderscc )
(cc) *
)cc* +
{dd 	
_loggeree 
.ee 
LogInformationee "
(ee" #
$stree# B
)eeB C
;eeC D
varff 
	orderListff 
=ff 
_cartServiceff (
.ff( )
GetAllOrdersff) 5
(ff5 6
)ff6 7
;ff7 8
_loggergg 
.gg 
LogInformationgg "
(gg" #
$strgg# F
)ggF G
;ggG H
ifhh 
(hh 
	orderListhh 
==hh 
nullhh !
||hh" $
	orderListhh% .
.hh. /
Counthh/ 4
(hh4 5
)hh5 6
==hh7 9
$numhh: ;
)hh; <
{ii 
_loggerjj 
.jj 
LogInformationjj &
(jj& '
$strjj' 7
)jj7 8
;jj8 9
returnkk 
NotFoundkk 
(kk  
$strkk  =
)kk= >
;kk> ?
}ll 
_loggermm 
.mm 
LogInformationmm "
(mm" #
$"mm# %
{mm% &
	orderListmm& /
.mm/ 0
Countmm0 5
(mm5 6
)mm6 7
}mm7 8
$strmm8 E
"mmE F
)mmF G
;mmG H
returnnn 
Oknn 
(nn 
	orderListnn 
)nn  
;nn  !
}oo 	
}rr 
}ss è
]C:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Controllers\ErrorController.cs
	namespace 	
OnlineShoppingApi
 
. 
Controllers '
{ 
public 

class 
ErrorController  
:! "
ControllerBase# 1
{ 
private 
readonly 
ILogger  
<  !
ErrorController! 0
>0 1
_logger2 9
;9 :
public		 
ErrorController		 
(		 
ILogger		 &
<		& '
ErrorController		' 6
>		6 7
logger		8 >
)		> ?
{

 	
_logger 
= 
logger 
; 
} 	
[ 	
Route	 
( 
$str #
)# $
]$ %
[ 	
ApiExplorerSettings	 
( 
	IgnoreApi &
=' (
true) -
)- .
]. /
public 
IActionResult "
HandleErrorDevelopment 3
(3 4
[ 
FromServices 
] 
IHostEnvironment +
hostEnvironment, ;
); <
{ 	
if 
( 
! 
hostEnvironment  
.  !
IsDevelopment! .
(. /
)/ 0
)0 1
{ 
return 
NotFound 
(  
)  !
;! "
} 
var #
exceptionHandlerFeature '
=( )
HttpContext 
. 
Features $
.$ %
Get% (
<( )$
IExceptionHandlerFeature) A
>A B
(B C
)C D
!D E
;E F
_logger 
. 
LogError 
( #
exceptionHandlerFeature 4
.4 5
Error5 :
.: ;
ToString; C
(C D
)D E
)E F
;F G
return 
Problem 
( 
detail 
: #
exceptionHandlerFeature /
./ 0
Error0 5
.5 6

StackTrace6 @
,@ A
title 
: #
exceptionHandlerFeature .
.. /
Error/ 4
.4 5
Message5 <
)< =
;= >
}   	
["" 	
Route""	 
("" 
$str"" 
)"" 
]"" 
[## 	
ApiExplorerSettings##	 
(## 
	IgnoreApi## &
=##' (
true##) -
)##- .
]##. /
public$$ 
IActionResult$$ 
HandleError$$ (
($$( )
)$$) *
{%% 	
return&& 
Problem&& 
(&& 
)&& 
;&& 
}'' 	
}(( 
})) ﬁ9
]C:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Controllers\LoginController.cs
	namespace 	
OnlineShoppingApi
 
. 
Controllers '
{ 
[ 
Route 

(
 
$str &
)& '
]' (
[		 
ApiController		 
]		 
public

 

class

 
LoginController

  
:

! "
ControllerBase

# 1
{ 
private 
readonly 
IConfiguration '
_config( /
;/ 0
public 
LoginController 
( 
IConfiguration -
config. 4
)4 5
{ 	
_config 
= 
config 
; 
} 	
[ 	
HttpPost	 
] 
public 
async 
Task 
< 
IActionResult '
>' (
Signup) /
(/ 0
User0 4
user5 9
)9 :
{ 	
string 
clientId 
= 
_config %
.% &

GetSection& 0
(0 1

ConfigKeys1 ;
.; <
AuthO< A
)A B
.B C

GetSectionC M
(M N

ConfigKeysN X
.X Y
ClientIdY a
)a b
.b c
Valuec h
;h i
string 
dbConnection 
=  !
_config" )
.) *

GetSection* 4
(4 5

ConfigKeys5 ?
.? @
AuthO@ E
)E F
.F G

GetSectionG Q
(Q R

ConfigKeysR \
.\ ]

Connection] g
)g h
.h i
Valuei n
;n o
string 
url 
= 
_config  
.  !

GetSection! +
(+ ,

ConfigKeys, 6
.6 7
AuthO7 <
)< =
.= >

GetSection> H
(H I

ConfigKeysI S
.S T
	SignupUrlT ]
)] ^
.^ _
Value_ d
;d e

HttpClient 
client 
= 
new  #

HttpClient$ .
(. /
)/ 0
;0 1
HttpResponseMessage 
response  (
=) *
await+ 0
client1 7
.7 8
PostAsJsonAsync8 G
(G H
urlH K
,K L
newM P
{Q R
	client_idS \
=] ^
clientId_ g
,g h
emaili n
=o p
userq u
.u v
Emailv {
,{ |
password	} Ö
=
Ü á
user
à å
.
å ç
Password
ç ï
,
ï ñ

connection
ó °
=
¢ £
dbConnection
§ ∞
}
± ≤
)
≤ ≥
;
≥ ¥
object 
responseContent "
=# $
await% *
response+ 3
.3 4
Content4 ;
.; <
ReadFromJsonAsync< M
<M N
objectN T
>T U
(U V
)V W
;W X
return 

StatusCode 
( 
( 
int "
)" #
response# +
.+ ,

StatusCode, 6
,6 7
responseContent8 G
)G H
;H I
} 	
[!! 	
HttpPost!!	 
]!! 
public"" 
async"" 
Task"" 
<"" 
IActionResult"" '
>""' (
GetAccessToken"") 7
(""7 8
User""8 <
user""= A
)""A B
{## 	
string$$ 
clientId$$ 
=$$ 
_config$$ %
.$$% &

GetSection$$& 0
($$0 1

ConfigKeys$$1 ;
.$$; <
AuthO$$< A
)$$A B
.$$B C

GetSection$$C M
($$M N

ConfigKeys$$N X
.$$X Y
ClientId$$Y a
)$$a b
.$$b c
Value$$c h
;$$h i
string%% 
clientSecret%% 
=%%  !
_config%%" )
.%%) *

GetSection%%* 4
(%%4 5

ConfigKeys%%5 ?
.%%? @
AuthO%%@ E
)%%E F
.%%F G

GetSection%%G Q
(%%Q R

ConfigKeys%%R \
.%%\ ]
ClientSecret%%] i
)%%i j
.%%j k
Value%%k p
;%%p q
string&& 
dbConnection&& 
=&&  !
_config&&" )
.&&) *

GetSection&&* 4
(&&4 5

ConfigKeys&&5 ?
.&&? @
AuthO&&@ E
)&&E F
.&&F G

GetSection&&G Q
(&&Q R

ConfigKeys&&R \
.&&\ ]

Connection&&] g
)&&g h
.&&h i
Value&&i n
;&&n o
string'' 
audience'' 
='' 
_config'' %
.''% &

GetSection''& 0
(''0 1

ConfigKeys''1 ;
.''; <
AuthO''< A
)''A B
.''B C

GetSection''C M
(''M N

ConfigKeys''N X
.''X Y
Audience''Y a
)''a b
.''b c
Value''c h
;''h i
string(( 
url(( 
=(( 
_config((  
.((  !

GetSection((! +
(((+ ,

ConfigKeys((, 6
.((6 7
AuthO((7 <
)((< =
.((= >

GetSection((> H
(((H I

ConfigKeys((I S
.((S T
AccessTokenUrl((T b
)((b c
.((c d
Value((d i
;((i j

HttpClient)) 
client)) 
=)) 
new))  #

HttpClient))$ .
()). /
)))/ 0
;))0 1
var** 
data** 
=** 
new** 
{++ 

grant_type,, 
=,, 
	GrantType,, &
.,,& '
Password,,' /
,,,/ 0
username-- 
=-- 
user-- 
.--  
Email--  %
,--% &
password.. 
=.. 
user.. 
...  
Password..  (
,..( )
audience// 
=// 
audience// #
,//# $
	client_id00 
=00 
clientId00 $
,00$ %
client_secret11 
=11 
clientSecret11  ,
}22 
;22 
HttpResponseMessage44 
response44  (
=44) *
await44+ 0
client441 7
.447 8
PostAsJsonAsync448 G
(44G H
url44H K
,44K L
data44M Q
)44Q R
;44R S
object55 
responseContent55 "
=55# $
await55% *
response55+ 3
.553 4
Content554 ;
.55; <
ReadFromJsonAsync55< M
<55M N
object55N T
>55T U
(55U V
)55V W
;55W X
return77 

StatusCode77 
(77 
(77 
int77 "
)77" #
response77# +
.77+ ,

StatusCode77, 6
,776 7
responseContent778 G
)77G H
;77H I
}88 	
}99 
}:: »?
_C:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Controllers\ProductController.cs
	namespace 	
OnlineShoppingApi
 
. 
Controllers '
{ 
[		 
Route		 

(		
 
$str		 
)		 
]		 
[

 
ApiController

 
]

 
public 

class 
ProductController "
:# $
ControllerBase% 3
{ 
private 
readonly 
ILogger  
<  !
ProductController! 2
>2 3
_logger4 ;
;; <
private 
readonly 
IProductService (
_productService) 8
;8 9
public 
ProductController  
(  !
ILogger! (
<( )
ProductController) :
>: ;
logger< B
,B C
IProductServiceD S
productServiceT b
)b c
{ 	
_logger 
= 
logger 
; 
_productService 
= 
productService ,
;, -
} 	
[ 	
HttpGet	 
] 
public 
IActionResult 
GetAllProducts +
(+ ,
string, 2
?2 3
orderBy4 ;
); <
{ 	
_logger 
. 
LogInformation "
(" #
$str# <
)< =
;= >
var 
productList 
= 
_productService -
.- .
GetAllProducts. <
(< =
orderBy= D
)D E
;E F
_logger 
. 
LogInformation "
(" #
$str# F
)F G
;G H
return 
Ok 
( 
productList !
)! "
;" #
} 	
[ 	
HttpGet	 
( 
$str $
)$ %
]% &
public   
IActionResult   
GetById   $
(  $ %
int  % (
id  ) +
)  + ,
{!! 	
_logger"" 
."" 
LogInformation"" "
(""" #
$"""# %
$str""% ?
{""? @
id""@ B
}""B C
"""C D
)""D E
;""E F
var## 
product## 
=## 
_productService## )
.##) *
GetProductById##* 8
(##8 9
id##9 ;
)##; <
;##< =
_logger$$ 
.$$ 
LogInformation$$ "
($$" #
$"$$# %
$str$$% B
"$$B C
)$$C D
;$$D E
if%% 
(%% 
product%% 
==%% 
null%% 
)%%  
{&& 
_logger'' 
.'' 
LogInformation'' &
(''& '
$"''' )
$str'') B
{''B C
id''C E
}''E F
"''F G
)''G H
;''H I
return(( 
NotFound(( 
(((  
$str((  3
)((3 4
;((4 5
})) 
_logger** 
.** 
LogInformation** "
(**" #
$"**# %
$str**% 2
"**2 3
)**3 4
;**4 5
return++ 
Ok++ 
(++ 
product++ 
)++ 
;++ 
}-- 	
[// 	
HttpGet//	 
(// 
$str// ,
)//, -
]//- .
public00 
IActionResult00 
SearchByCategory00 -
(00- .
string00. 4
category005 =
)00= >
{11 	
_logger22 
.22 
LogInformation22 "
(22" #
$"22# %
$str22% D
{22D E
category22E M
}22M N
"22N O
)22O P
;22P Q
var33 
productList33 
=33 
_productService33 -
.33- .!
GetProductsByCategory33. C
(33C D
category33D L
)33L M
;33M N
_logger44 
.44 
LogInformation44 "
(44" #
$"44# %
$str44% C
"44C D
)44D E
;44E F
if55 
(55 
productList55 
==55 
null55 #
||55$ &
productList55' 2
.552 3
Count553 8
(558 9
)559 :
==55; =
$num55> ?
)55? @
{66 
_logger77 
.77 
LogInformation77 &
(77& '
$"77' )
$str77) H
{77H I
category77I Q
}77Q R
"77R S
)77S T
;77T U
return88 
NotFound88 
(88  
$str88  D
)88D E
;88E F
}99 
_logger:: 
.:: 
LogInformation:: "
(::" #
$"::# %
{::% &
productList::& 1
.::1 2
Count::2 7
(::7 8
)::8 9
}::9 :
$str::: X
{::X Y
category::Y a
}::a b
"::b c
)::c d
;::d e
return;; 
Ok;; 
(;; 
productList;; !
);;! "
;;;" #
}<< 	
[@@ 	
HttpPost@@	 
]@@ 
publicAA 
IActionResultAA 

AddProductAA '
(AA' (
ProductAA( /
productAA0 7
)AA7 8
{BB 	
_loggerCC 
.CC 
LogInformationCC "
(CC" #
$strCC# 5
)CC5 6
;CC6 7
varDD 
isAddedDD 
=DD 
_productServiceDD )
.DD) *

AddProductDD* 4
(DD4 5
productDD5 <
)DD< =
;DD= >
ifEE 
(EE 
!EE 
isAddedEE 
)EE 
{FF 
_loggerGG 
.GG 
LogInformationGG &
(GG& '
$strGG' @
)GG@ A
;GGA B
returnHH 

StatusCodeHH !
(HH! "
StatusCodesHH" -
.HH- .(
Status500InternalServerErrorHH. J
,HHJ K
$strHHL c
)HHc d
;HHd e
}II 
_loggerJJ 
.JJ 
LogInformationJJ "
(JJ" #
$strJJ# ?
)JJ? @
;JJ@ A
returnKK 

StatusCodeKK 
(KK 
StatusCodesKK )
.KK) *
Status201CreatedKK* :
,KK: ;
$strKK< Y
)KKY Z
;KKZ [
}MM 	
[OO 	
HttpPostOO	 
(OO 
$strOO 
)OO 
]OO 
publicPP 
IActionResultPP 
AddProductInBulkPP -
(PP- .
IEnumerablePP. 9
<PP9 :
ProductPP: A
>PPA B
productListPPC N
)PPN O
{QQ 	
_loggerRR 
.RR 
LogInformationRR "
(RR" #
$strRR# >
)RR> ?
;RR? @
varSS 
isAddedSS 
=SS 
_productServiceSS )
.SS) *
AddProductsInBulkSS* ;
(SS; <
productListSS< G
)SSG H
;SSH I
ifTT 
(TT 
!TT 
isAddedTT 
)TT 
{UU 
_loggerVV 
.VV 
LogInformationVV &
(VV& '
$strVV' B
)VVB C
;VVC D
returnWW 

StatusCodeWW !
(WW! "
StatusCodesWW" -
.WW- .(
Status500InternalServerErrorWW. J
,WWJ K
$strWWL e
)WWe f
;WWf g
}XX 
_loggerYY 
.YY 
LogInformationYY "
(YY" #
$strYY# @
)YY@ A
;YYA B
returnZZ 

StatusCodeZZ 
(ZZ 
StatusCodesZZ )
.ZZ) *
Status201CreatedZZ* :
,ZZ: ;
$strZZ< ^
)ZZ^ _
;ZZ_ `
}\\ 	
}^^ 
}__ ã
gC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Controllers\WeatherForecastController.cs
	namespace 	
OnlineShoppingApi
 
. 
Controllers '
;' (
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public 
class %
WeatherForecastController &
:' (
ControllerBase) 7
{ 
private		 
static		 
readonly		 
string		 "
[		" #
]		# $
	Summaries		% .
=		/ 0
new		1 4
[		4 5
]		5 6
{

 
$str 
, 
$str 
, 
$str '
,' (
$str) /
,/ 0
$str1 7
,7 8
$str9 ?
,? @
$strA H
,H I
$strJ O
,O P
$strQ ]
,] ^
$str_ j
} 
; 
private 
readonly 
ILogger 
< %
WeatherForecastController 6
>6 7
_logger8 ?
;? @
public 
%
WeatherForecastController $
($ %
ILogger% ,
<, -%
WeatherForecastController- F
>F G
loggerH N
)N O
{ 
_logger 
= 
logger 
; 
} 
[ 
HttpGet 
( 
Name 
= 
$str (
)( )
]) *
public 

IEnumerable 
< 
WeatherForecast &
>& '
Get( +
(+ ,
), -
{ 
return 

Enumerable 
. 
Range 
(  
$num  !
,! "
$num# $
)$ %
.% &
Select& ,
(, -
index- 2
=>3 5
new6 9
WeatherForecast: I
{ 	
Date 
= 
DateTime 
. 
Now 
.  
AddDays  '
(' (
index( -
)- .
,. /
TemperatureC 
= 
Random !
.! "
Shared" (
.( )
Next) -
(- .
-. /
$num/ 1
,1 2
$num3 5
)5 6
,6 7
Summary 
= 
	Summaries 
[  
Random  &
.& '
Shared' -
.- .
Next. 2
(2 3
	Summaries3 <
.< =
Length= C
)C D
]D E
} 	
)	 

. 	
ToArray	 
( 
) 
; 
} 
}   Î
\C:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Data\OnlineShoppingContext.cs
	namespace 	
OnlineShoppingApi
 
. 
Data  
{ 
public 

class !
OnlineShoppingContext &
:' (
	DbContext) 2
{ 
public		 !
OnlineShoppingContext		 $
(		$ %
DbContextOptions		% 5
<		5 6!
OnlineShoppingContext		6 K
>		K L
options		M T
)		T U
:		V W
base		X \
(		\ ]
options		] d
)		d e
{

 	
} 	
public 
DbSet 
< 
Product 
> 
Products &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
public 
DbSet 
< 
Cart 
> 
Carts  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
DbSet 
< 
Order 
> 
Orders "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
DbSet 
< 
Address 
> 
	Addresses '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 
DbSet 
< 
PaymentDetail "
>" #
PaymentDetails$ 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
	protected 
override 
void 
OnModelCreating  /
(/ 0
ModelBuilder0 <
modelBuilder= I
)I J
{ 	
} 	
}   
}!! •Ö
iC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Migrations\20220630144355_InitialCreate.cs
	namespace 	
OnlineShoppingApi
 
. 

Migrations &
{ 
public 

partial 
class 
InitialCreate &
:' (
	Migration) 2
{		 
	protected

 
override

 
void

 
Up

  "
(

" #
MigrationBuilder

# 3
migrationBuilder

4 D
)

D E
{ 	
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str &
,& '
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 6
,6 7
nullable8 @
:@ A
falseB G
)G H
. 

Annotation #
(# $
$str$ 8
,8 9
$str: @
)@ A
,A B
TotalAmount 
=  !
table" '
.' (
Column( .
<. /
decimal/ 6
>6 7
(7 8
type8 <
:< =
$str> M
,M N
nullableO W
:W X
falseY ^
)^ _
,_ `
PaymentType 
=  !
table" '
.' (
Column( .
<. /
string/ 5
>5 6
(6 7
type7 ;
:; <
$str= L
,L M
nullableN V
:V W
falseX ]
)] ^
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 8
,8 9
x: ;
=>< >
x? @
.@ A
IdA C
)C D
;D E
} 
) 
; 
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str  
,  !
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 6
,6 7
nullable8 @
:@ A
falseB G
)G H
. 

Annotation #
(# $
$str$ 8
,8 9
$str: @
)@ A
,A B
Name   
=   
table    
.    !
Column  ! '
<  ' (
string  ( .
>  . /
(  / 0
type  0 4
:  4 5
$str  6 E
,  E F
nullable  G O
:  O P
false  Q V
)  V W
,  W X
Price!! 
=!! 
table!! !
.!!! "
Column!!" (
<!!( )
decimal!!) 0
>!!0 1
(!!1 2
type!!2 6
:!!6 7
$str!!8 G
,!!G H
nullable!!I Q
:!!Q R
false!!S X
)!!X Y
,!!Y Z
Description"" 
=""  !
table""" '
.""' (
Column""( .
<"". /
string""/ 5
>""5 6
(""6 7
type""7 ;
:""; <
$str""= L
,""L M
nullable""N V
:""V W
true""X \
)""\ ]
,""] ^
Category## 
=## 
table## $
.##$ %
Column##% +
<##+ ,
string##, 2
>##2 3
(##3 4
type##4 8
:##8 9
$str##: I
,##I J
nullable##K S
:##S T
false##U Z
)##Z [
,##[ \
	DateAdded$$ 
=$$ 
table$$  %
.$$% &
Column$$& ,
<$$, -
DateTime$$- 5
>$$5 6
($$6 7
type$$7 ;
:$$; <
$str$$= H
,$$H I
nullable$$J R
:$$R S
false$$T Y
)$$Y Z
}%% 
,%% 
constraints&& 
:&& 
table&& "
=>&&# %
{'' 
table(( 
.(( 

PrimaryKey(( $
((($ %
$str((% 2
,((2 3
x((4 5
=>((6 8
x((9 :
.((: ;
Id((; =
)((= >
;((> ?
})) 
))) 
;)) 
migrationBuilder++ 
.++ 
CreateTable++ (
(++( )
name,, 
:,, 
$str,, 
,,, 
columns-- 
:-- 
table-- 
=>-- !
new--" %
{.. 
OrderId// 
=// 
table// #
.//# $
Column//$ *
<//* +
int//+ .
>//. /
(/// 0
type//0 4
://4 5
$str//6 ;
,//; <
nullable//= E
://E F
false//G L
)//L M
.00 

Annotation00 #
(00# $
$str00$ 8
,008 9
$str00: @
)00@ A
,00A B
BillingAddressId11 $
=11% &
table11' ,
.11, -
Column11- 3
<113 4
int114 7
>117 8
(118 9
type119 =
:11= >
$str11? D
,11D E
nullable11F N
:11N O
false11P U
)11U V
,11V W
	PaymentId22 
=22 
table22  %
.22% &
Column22& ,
<22, -
int22- 0
>220 1
(221 2
type222 6
:226 7
$str228 =
,22= >
nullable22? G
:22G H
false22I N
)22N O
,22O P
OrderStatus33 
=33  !
table33" '
.33' (
Column33( .
<33. /
string33/ 5
>335 6
(336 7
type337 ;
:33; <
$str33= L
,33L M
nullable33N V
:33V W
true33X \
)33\ ]
,33] ^
UserId44 
=44 
table44 "
.44" #
Column44# )
<44) *
string44* 0
>440 1
(441 2
type442 6
:446 7
$str448 G
,44G H
nullable44I Q
:44Q R
true44S W
)44W X
}55 
,55 
constraints66 
:66 
table66 "
=>66# %
{77 
table88 
.88 

PrimaryKey88 $
(88$ %
$str88% 0
,880 1
x882 3
=>884 6
x887 8
.888 9
OrderId889 @
)88@ A
;88A B
table99 
.99 

ForeignKey99 $
(99$ %
name:: 
::: 
$str:: B
,::B C
column;; 
:;; 
x;;  !
=>;;" $
x;;% &
.;;& '
	PaymentId;;' 0
,;;0 1
principalTable<< &
:<<& '
$str<<( 8
,<<8 9
principalColumn== '
:==' (
$str==) -
,==- .
onDelete>>  
:>>  !
ReferentialAction>>" 3
.>>3 4
Cascade>>4 ;
)>>; <
;>>< =
}?? 
)?? 
;?? 
migrationBuilderAA 
.AA 
CreateTableAA (
(AA( )
nameBB 
:BB 
$strBB !
,BB! "
columnsCC 
:CC 
tableCC 
=>CC !
newCC" %
{DD 
IdEE 
=EE 
tableEE 
.EE 
ColumnEE %
<EE% &
intEE& )
>EE) *
(EE* +
typeEE+ /
:EE/ 0
$strEE1 6
,EE6 7
nullableEE8 @
:EE@ A
falseEEB G
)EEG H
.FF 

AnnotationFF #
(FF# $
$strFF$ 8
,FF8 9
$strFF: @
)FF@ A
,FFA B
AddressLine1GG  
=GG! "
tableGG# (
.GG( )
ColumnGG) /
<GG/ 0
stringGG0 6
>GG6 7
(GG7 8
typeGG8 <
:GG< =
$strGG> M
,GGM N
nullableGGO W
:GGW X
falseGGY ^
)GG^ _
,GG_ `
AddressLine2HH  
=HH! "
tableHH# (
.HH( )
ColumnHH) /
<HH/ 0
stringHH0 6
>HH6 7
(HH7 8
typeHH8 <
:HH< =
$strHH> M
,HHM N
nullableHHO W
:HHW X
falseHHY ^
)HH^ _
,HH_ `
CityII 
=II 
tableII  
.II  !
ColumnII! '
<II' (
stringII( .
>II. /
(II/ 0
typeII0 4
:II4 5
$strII6 E
,IIE F
nullableIIG O
:IIO P
falseIIQ V
)IIV W
,IIW X
StateJJ 
=JJ 
tableJJ !
.JJ! "
ColumnJJ" (
<JJ( )
stringJJ) /
>JJ/ 0
(JJ0 1
typeJJ1 5
:JJ5 6
$strJJ7 F
,JJF G
nullableJJH P
:JJP Q
falseJJR W
)JJW X
,JJX Y
ZipCodeKK 
=KK 
tableKK #
.KK# $
ColumnKK$ *
<KK* +
intKK+ .
>KK. /
(KK/ 0
typeKK0 4
:KK4 5
$strKK6 ;
,KK; <
nullableKK= E
:KKE F
falseKKG L
)KKL M
,KKM N
AddressTypeLL 
=LL  !
tableLL" '
.LL' (
ColumnLL( .
<LL. /
stringLL/ 5
>LL5 6
(LL6 7
typeLL7 ;
:LL; <
$strLL= L
,LLL M
nullableLLN V
:LLV W
falseLLX ]
)LL] ^
,LL^ _
OrderIdMM 
=MM 
tableMM #
.MM# $
ColumnMM$ *
<MM* +
intMM+ .
>MM. /
(MM/ 0
typeMM0 4
:MM4 5
$strMM6 ;
,MM; <
nullableMM= E
:MME F
falseMMG L
)MML M
}NN 
,NN 
constraintsOO 
:OO 
tableOO "
=>OO# %
{PP 
tableQQ 
.QQ 

PrimaryKeyQQ $
(QQ$ %
$strQQ% 3
,QQ3 4
xQQ5 6
=>QQ7 9
xQQ: ;
.QQ; <
IdQQ< >
)QQ> ?
;QQ? @
tableRR 
.RR 

ForeignKeyRR $
(RR$ %
nameSS 
:SS 
$strSS ;
,SS; <
columnTT 
:TT 
xTT  !
=>TT" $
xTT% &
.TT& '
OrderIdTT' .
,TT. /
principalTableUU &
:UU& '
$strUU( 0
,UU0 1
principalColumnVV '
:VV' (
$strVV) 2
,VV2 3
onDeleteWW  
:WW  !
ReferentialActionWW" 3
.WW3 4
CascadeWW4 ;
)WW; <
;WW< =
}XX 
)XX 
;XX 
migrationBuilderZZ 
.ZZ 
CreateTableZZ (
(ZZ( )
name[[ 
:[[ 
$str[[ 
,[[ 
columns\\ 
:\\ 
table\\ 
=>\\ !
new\\" %
{]] 
CartId^^ 
=^^ 
table^^ "
.^^" #
Column^^# )
<^^) *
int^^* -
>^^- .
(^^. /
type^^/ 3
:^^3 4
$str^^5 :
,^^: ;
nullable^^< D
:^^D E
false^^F K
)^^K L
.__ 

Annotation__ #
(__# $
$str__$ 8
,__8 9
$str__: @
)__@ A
,__A B
UserId`` 
=`` 
table`` "
.``" #
Column``# )
<``) *
string``* 0
>``0 1
(``1 2
type``2 6
:``6 7
$str``8 G
,``G H
nullable``I Q
:``Q R
true``S W
)``W X
,``X Y
	ProductIdaa 
=aa 
tableaa  %
.aa% &
Columnaa& ,
<aa, -
intaa- 0
>aa0 1
(aa1 2
typeaa2 6
:aa6 7
$straa8 =
,aa= >
nullableaa? G
:aaG H
falseaaI N
)aaN O
,aaO P
Quantitybb 
=bb 
tablebb $
.bb$ %
Columnbb% +
<bb+ ,
intbb, /
>bb/ 0
(bb0 1
typebb1 5
:bb5 6
$strbb7 <
,bb< =
nullablebb> F
:bbF G
falsebbH M
)bbM N
,bbN O
OrderIdcc 
=cc 
tablecc #
.cc# $
Columncc$ *
<cc* +
intcc+ .
>cc. /
(cc/ 0
typecc0 4
:cc4 5
$strcc6 ;
,cc; <
nullablecc= E
:ccE F
trueccG K
)ccK L
}dd 
,dd 
constraintsee 
:ee 
tableee "
=>ee# %
{ff 
tablegg 
.gg 

PrimaryKeygg $
(gg$ %
$strgg% /
,gg/ 0
xgg1 2
=>gg3 5
xgg6 7
.gg7 8
CartIdgg8 >
)gg> ?
;gg? @
tablehh 
.hh 

ForeignKeyhh $
(hh$ %
nameii 
:ii 
$strii 7
,ii7 8
columnjj 
:jj 
xjj  !
=>jj" $
xjj% &
.jj& '
OrderIdjj' .
,jj. /
principalTablekk &
:kk& '
$strkk( 0
,kk0 1
principalColumnll '
:ll' (
$strll) 2
)ll2 3
;ll3 4
tablemm 
.mm 

ForeignKeymm $
(mm$ %
namenn 
:nn 
$strnn ;
,nn; <
columnoo 
:oo 
xoo  !
=>oo" $
xoo% &
.oo& '
	ProductIdoo' 0
,oo0 1
principalTablepp &
:pp& '
$strpp( 2
,pp2 3
principalColumnqq '
:qq' (
$strqq) -
,qq- .
onDeleterr  
:rr  !
ReferentialActionrr" 3
.rr3 4
Cascaderr4 ;
)rr; <
;rr< =
}ss 
)ss 
;ss 
migrationBuilderuu 
.uu 
CreateIndexuu (
(uu( )
namevv 
:vv 
$strvv ,
,vv, -
tableww 
:ww 
$strww "
,ww" #
columnxx 
:xx 
$strxx !
)xx! "
;xx" #
migrationBuilderzz 
.zz 
CreateIndexzz (
(zz( )
name{{ 
:{{ 
$str{{ (
,{{( )
table|| 
:|| 
$str|| 
,|| 
column}} 
:}} 
$str}} !
)}}! "
;}}" #
migrationBuilder 
. 
CreateIndex (
(( )
name
ÄÄ 
:
ÄÄ 
$str
ÄÄ *
,
ÄÄ* +
table
ÅÅ 
:
ÅÅ 
$str
ÅÅ 
,
ÅÅ 
column
ÇÇ 
:
ÇÇ 
$str
ÇÇ #
)
ÇÇ# $
;
ÇÇ$ %
migrationBuilder
ÑÑ 
.
ÑÑ 
CreateIndex
ÑÑ (
(
ÑÑ( )
name
ÖÖ 
:
ÖÖ 
$str
ÖÖ +
,
ÖÖ+ ,
table
ÜÜ 
:
ÜÜ 
$str
ÜÜ 
,
ÜÜ  
column
áá 
:
áá 
$str
áá #
)
áá# $
;
áá$ %
}
àà 	
	protected
ää 
override
ää 
void
ää 
Down
ää  $
(
ää$ %
MigrationBuilder
ää% 5
migrationBuilder
ää6 F
)
ääF G
{
ãã 	
migrationBuilder
åå 
.
åå 
	DropTable
åå &
(
åå& '
name
çç 
:
çç 
$str
çç !
)
çç! "
;
çç" #
migrationBuilder
èè 
.
èè 
	DropTable
èè &
(
èè& '
name
êê 
:
êê 
$str
êê 
)
êê 
;
êê 
migrationBuilder
íí 
.
íí 
	DropTable
íí &
(
íí& '
name
ìì 
:
ìì 
$str
ìì 
)
ìì 
;
ìì  
migrationBuilder
ïï 
.
ïï 
	DropTable
ïï &
(
ïï& '
name
ññ 
:
ññ 
$str
ññ  
)
ññ  !
;
ññ! "
migrationBuilder
òò 
.
òò 
	DropTable
òò &
(
òò& '
name
ôô 
:
ôô 
$str
ôô &
)
ôô& '
;
ôô' (
}
öö 	
}
õõ 
}úú ë
lC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Migrations\20220630152545_RemovedBillingId.cs
	namespace 	
OnlineShoppingApi
 
. 

Migrations &
{ 
public 

partial 
class 
RemovedBillingId )
:* +
	Migration, 5
{ 
	protected		 
override		 
void		 
Up		  "
(		" #
MigrationBuilder		# 3
migrationBuilder		4 D
)		D E
{

 	
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
} 	
} 
} 
sC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Migrations\20220630152826_RemovedBillingIdInOrder.cs
	namespace 	
OnlineShoppingApi
 
. 

Migrations &
{ 
public 

partial 
class #
RemovedBillingIdInOrder 0
:1 2
	Migration3 <
{ 
	protected		 
override		 
void		 
Up		  "
(		" #
MigrationBuilder		# 3
migrationBuilder		4 D
)		D E
{

 	
migrationBuilder 
. 

DropColumn '
(' (
name 
: 
$str (
,( )
table 
: 
$str 
)  
;  !
} 	
	protected 
override 
void 
Down  $
($ %
MigrationBuilder% 5
migrationBuilder6 F
)F G
{ 	
migrationBuilder 
. 
	AddColumn &
<& '
int' *
>* +
(+ ,
name 
: 
$str (
,( )
table 
: 
$str 
,  
type 
: 
$str 
, 
nullable 
: 
false 
,  
defaultValue 
: 
$num 
)  
;  !
} 	
} 
} §
PC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Models\Address.cs
	namespace 	
OnlineShoppingApi
 
. 
Models "
{ 
public 

class 
Address 
{ 
[		 	
Key			 
]		 
[

 	

JsonIgnore

	 
]

 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
[ 	
Required	 
] 
public 
string 
AddressLine1 "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
AddressLine2 "
{# $
get% (
;( )
set* -
;- .
}/ 0
[ 	
Required	 
] 
public 
string 
City 
{ 
get  
;  !
set" %
;% &
}' (
[ 	
Required	 
] 
public 
string 
State 
{ 
get !
;! "
set# &
;& '
}( )
[ 	
Required	 
] 
public 
int 
ZipCode 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
AddressType !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	

JsonIgnore	 
] 
[ 	

ForeignKey	 
( 
$str !
)! "
]" #
public 
int 
OrderId 
{ 
get  
;  !
set" %
;% &
}' (
[ 	

JsonIgnore	 
] 
public 
Order 
? 
OrderDetail !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} ™
MC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Models\Cart.cs
	namespace 	
OnlineShoppingApi
 
. 
Models "
{ 
public 

class 
Cart 
{		 
[

 	
Key

	 
]

 
public 
int 
CartId 
{ 
get 
;  
set! $
;$ %
}& '
[ 	

JsonIgnore	 
] 
public 
string 
? 
UserId 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

ForeignKey	 
( 
$str #
)# $
]$ %
public 
int 
	ProductId 
{ 
get "
;" #
set$ '
;' (
}) *
[ 	
Required	 
] 
public 
int 
Quantity 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

ForeignKey	 
( 
$str !
)! "
]" #
public 
int 
? 
OrderId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

JsonIgnore	 
] 
public 
Order 
? 
OrderDetail !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
Product 
? 
ProductDetail %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
} 
} Í
NC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Models\Order.cs
	namespace 	
OnlineShoppingApi
 
. 
Models "
{ 
public		 

class		 
Order		 
{

 
[ 	

JsonIgnore	 
] 
[ 	
Key	 
] 
public	 
int 
OrderId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

ForeignKey	 
( 
$str !
)! "
]" #
[ 	

JsonIgnore	 
] 
public 
int 
	PaymentId 
{ 
get "
;" #
set$ '
;' (
}) *
public 
ICollection 
< 
Address "
>" #
	Addresses$ -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
public 
PaymentDetail 
PaymentInfo (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
[ 	

JsonIgnore	 
] 
public 
string 
? 
OrderStatus "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
ICollection 
< 
Cart 
>  
?  !
Products" *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
[ 	

JsonIgnore	 
] 
public   
string   
?   
UserId   
{   
get    #
;  # $
set  % (
;  ( )
}  * +
}'' 
})) ‡
VC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Models\PaymentDetail.cs
	namespace 	
OnlineShoppingApi
 
. 
Models "
{ 
public 

class 
PaymentDetail 
{ 
[ 	
Key	 
] 
[		 	

JsonIgnore			 
]		 
public

 
int

 
Id

 
{

 
get

 
;

 
set

  
;

  !
}

" #
public 
decimal 
TotalAmount "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
PaymentType !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} ˛
PC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Models\Product.cs
	namespace 	
OnlineShoppingApi
 
. 
Models "
{ 
public 

class 
Product 
{ 
[ 	
Key	 
] 
[ 	
Required	 
] 
public		 
int		 
Id		 
{		 
get		 
;		 
set		  
;		  !
}		" #
[

 	
Required

	 
]

 
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
[ 	
Required	 
] 
public 
Decimal 
Price 
{ 
get "
;" #
set$ '
;' (
}) *
public 
string 
? 
Description "
{# $
get% (
;( )
set* -
;- .
}/ 0
[ 	
Required	 
] 
public 
string 
Category 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	
Required	 
] 
public 
DateTime 
	DateAdded !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} ‡
MC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Models\User.cs
	namespace 	
OnlineShoppingApi
 
. 
Models "
{ 
[ 
	NotMapped 
] 
public 

class 
User 
{		 
[

 	

JsonIgnore

	 
]

 
public 
string 
? 
UserId 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} ∫6
IC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Program.cs
var		 
builder		 
=		 
WebApplication		 
.		 
CreateBuilder		 *
(		* +
args		+ /
)		/ 0
;		0 1
var 
loggerConfiguration 
= 
new 
LoggerConfiguration 1
(1 2
)2 3
.3 4
WriteTo4 ;
.; <
File< @
(@ A
builderA H
.H I
ConfigurationI V
[V W
$strW h
]h i
,i j
rollOnFileSizeLimitk ~
:~ 
true	 É
,
É Ñ 
fileSizeLimitBytes
Ñ ñ
:
ñ ó
$num
ó õ
)
õ ú
.
ú ù
ReadFrom 
. 	
Configuration	 
( 
builder 
. 
Configuration ,
), -
. 
Enrich 
. 
FromLogContext 
( 
) 
. 
CreateLogger %
(% &
)& '
;' (
builder 
. 
Logging 
. 
ClearProviders 
( 
)  
;  !
builder 
. 
Logging 
. 

AddSerilog 
( 
loggerConfiguration .
). /
;/ 0
builder 
. 
Services 
. 
AddControllers 
(  
)  !
;! "
builder 
. 
Services 
. 
AddAuthentication "
(" #
options# *
=>+ -
{ 
options   
.   %
DefaultAuthenticateScheme   %
=  & '
JwtBearerDefaults  ( 9
.  9 : 
AuthenticationScheme  : N
;  N O
options!! 
.!! "
DefaultChallengeScheme!! "
=!!# $
JwtBearerDefaults!!% 6
.!!6 7 
AuthenticationScheme!!7 K
;!!K L
}"" 
)"" 
."" 
AddJwtBearer"" 
("" 
options"" 
=>"" 
{## 
options$$ 
.$$ 
	Authority$$ 
=$$ 
$str$$ C
;$$C D
options%% 
.%% 
Audience%% 
=%% 
$str%% 1
;%%1 2
}&& 
)&& 
;&& 
builder(( 
.(( 
Services(( 
.(( 
AddDbContext(( 
<(( !
OnlineShoppingContext(( 3
>((3 4
(((4 5
(((5 6
options((6 =
)((= >
=>((? A
options)) 
.)) 
UseSqlServer)) 
()) 
builder)) 
.)) 
Configuration)) *
.))* +
GetConnectionString))+ >
())> ?
$str))? W
)))W X
)))X Y
)))Y Z
;))Z [
builder++ 
.++ 
Services++ 
.++ 
	AddScoped++ 
<++ 
IProductService++ *
,++* +
ProductService++, :
>++: ;
(++; <
)++< =
;++= >
builder,, 
.,, 
Services,, 
.,, 
	AddScoped,, 
<,, 
ICartService,, '
,,,' (
CartService,,) 4
>,,4 5
(,,5 6
),,6 7
;,,7 8
builder// 
.// 
Services// 
.// #
AddEndpointsApiExplorer// (
(//( )
)//) *
;//* +
builder00 
.00 
Services00 
.00 
AddSwaggerGen00 
(00 
options00 &
=>00' )
{11 
options22 
.22 !
AddSecurityDefinition22 !
(22! "
$str22" *
,22* +
new22, /!
OpenApiSecurityScheme220 E
{33 
Type44 
=44 
SecuritySchemeType44 !
.44! "
Http44" &
,44& '
BearerFormat55 
=55 
$str55 
,55 
In66 

=66 
ParameterLocation66 
.66 
Header66 %
,66% &
Scheme77 
=77 
$str77 
}88 
)88 
;88 
options:: 
.:: 
OperationFilter:: 
<:: 
AddHeaderParameter:: .
>::. /
(::/ 0
)::0 1
;::1 2
};; 
);; 
;;; 
var== 
app== 
=== 	
builder==
 
.== 
Build== 
(== 
)== 
;== 
if@@ 
(@@ 
app@@ 
.@@ 
Environment@@ 
.@@ 
IsDevelopment@@ !
(@@! "
)@@" #
)@@# $
{AA 
appBB 
.BB 

UseSwaggerBB 
(BB 
)BB 
;BB 
appCC 
.CC 
UseSwaggerUICC 
(CC 
)CC 
;CC 
appDD 
.DD 
UseExceptionHandlerDD 
(DD 
$strDD 0
)DD0 1
;DD1 2
}EE 
elseFF 
{FF 
}HH 
appJJ 
.JJ 
UseHttpsRedirectionJJ 
(JJ 
)JJ 
;JJ 
appKK 
.KK 
UseAuthenticationKK 
(KK 
)KK 
;KK 
appMM 
.MM 
UseAuthorizationMM 
(MM 
)MM 
;MM 
usingOO 
(OO 
varOO 

scopeOO 
=OO 
appOO 
.OO 
ServicesOO 
.OO  
CreateScopeOO  +
(OO+ ,
)OO, -
)OO- .
{PP 
varQQ 
	dbContextQQ 
=QQ 
scopeQQ 
.QQ 
ServiceProviderQQ )
.QQ) *
GetRequiredServiceQQ* <
<QQ< =!
OnlineShoppingContextQQ= R
>QQR S
(QQS T
)QQT U
;QQU V
	dbContextRR 
.RR 
DatabaseRR 
.RR 
MigrateRR 
(RR 
)RR  
;RR  !
}SS 
appUU 
.UU 
MapControllersUU 
(UU 
)UU 
;UU 
varWW 
loggerWW 

=WW 
appWW 
.WW 
ServicesWW 
.WW 
GetRequiredServiceWW ,
<WW, -
ILoggerWW- 4
<WW4 5
ProgramWW5 <
>WW< =
>WW= >
(WW> ?
)WW? @
;WW@ A
loggerXX 
.XX 
LogInformationXX 
(XX 
$strXX 1
)XX1 2
;XX2 3
appZZ 
.ZZ 
RunZZ 
(ZZ 
)ZZ 	
;ZZ	 
ô;
UC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Service\CartService.cs
	namespace 	
OnlineShoppingApi
 
. 
Service #
{ 
public 

class 
CartService 
: 
ICartService +
{		 
private

 
readonly

 !
OnlineShoppingContext

 .
_context

/ 7
;

7 8
public 
CartService 
( !
OnlineShoppingContext 0
context1 8
)8 9
{ 	
_context 
= 
context 
; 
} 	
public 
bool 
	AddToCart 
( 
Cart "
cart# '
)' (
{ 	
_context 
. 
Carts 
. 
Add 
( 
cart #
)# $
;$ %
var 
result 
= 
_context !
.! "
SaveChanges" -
(- .
). /
;/ 0
return 
result 
> 
$num 
; 
} 	
public 

IQueryable 
< 
Cart 
> 
GetCartDetails  .
(. /
string/ 5
userId6 <
)< =
{ 	
var 
productsInCart 
=  
_context! )
.) *
Carts* /
./ 0
Where0 5
(5 6
x6 7
=>8 :
x; <
.< =
UserId= C
==D F
userIdG M
&&N P
xQ R
.R S
OrderIdS Z
==[ ]
null^ b
)b c
.c d
Included k
(k l
xl m
=>n p
xq r
.r s
ProductDetail	s Ä
)
Ä Å
;
Å Ç
return 
productsInCart !
;! "
} 	
public 
bool 
OrderProducts !
(! "
Order" '
orderDetails( 4
)4 5
{ 	
var   
productsInCart   
=    
_context  ! )
.  ) *
Carts  * /
.  / 0
Where  0 5
(  5 6
x  6 7
=>  8 :
x  ; <
.  < =
UserId  = C
==  D F
orderDetails  G S
.  S T
UserId  T Z
&&  [ ]
x  ^ _
.  _ `
OrderId  ` g
==  h j
null  k o
)  o p
.  p q
Include  q x
(  x y
x  y z
=>  { }
x  ~ 
.	   Ä
ProductDetail
  Ä ç
)
  ç é
.
  é è
ToList
  è ï
(
  ï ñ
)
  ñ ó
;
  ó ò
if!! 
(!! 
productsInCart!! 
==!! !
null!!" &
||!!' )
productsInCart!!* 8
.!!8 9
Count!!9 >
(!!> ?
)!!? @
==!!A C
$num!!D E
)!!E F
{"" 
return## 
false## 
;## 
}$$ 
var%% 

orderTotal%% 
=%% 
productsInCart%% +
.%%+ ,
Sum%%, /
(%%/ 0
x%%0 1
=>%%2 4
x%%5 6
.%%6 7
ProductDetail%%7 D
.%%D E
Price%%E J
*%%K L
x%%M N
.%%N O
Quantity%%O W
)%%W X
;%%X Y
orderDetails&& 
.&& 
PaymentInfo&& $
.&&$ %
TotalAmount&&% 0
=&&1 2

orderTotal&&3 =
;&&= >
orderDetails'' 
.'' 
OrderStatus'' $
=''% &
OrderStatus''' 2
.''2 3
Success''3 :
;'': ;
orderDetails(( 
.(( 
	Addresses(( "
.((" #
First((# (
(((( )
)(() *
.((* +
AddressType((+ 6
=((7 8
AddressType((9 D
.((D E
ShippingAddress((E T
;((T U
orderDetails)) 
.)) 
	Addresses)) "
.))" #
Last))# '
())' (
)))( )
.))) *
AddressType))* 5
=))6 7
AddressType))8 C
.))C D
BillingAddress))D R
;))R S
_context++ 
.++ 
Orders++ 
.++ 
Add++ 
(++  
orderDetails++  ,
)++, -
;++- .
_context-- 
.-- 
SaveChanges--  
(--  !
)--! "
;--" #
foreach.. 
(.. 
var.. 
product..  
in..! #
productsInCart..$ 2
)..2 3
{// 
product00 
.00 
OrderId00 
=00  !
orderDetails00" .
.00. /
OrderId00/ 6
;006 7
}11 
_context22 
.22 
SaveChanges22  
(22  !
)22! "
;22" #
return44 
true44 
;44 
}55 	
public77 

IQueryable77 
<77 
Order77 
>77  
GetAllOrders77! -
(77- .
)77. /
{88 	

IQueryable99 
<99 
Order99 
>99 
	orderList99 '
=99( )
_context99* 2
.992 3
Orders993 9
.999 :
Include99: A
(99A B
x99B C
=>99D F
x99G H
.99H I
	Addresses99I R
)99R S
.99S T
Include99T [
(99[ \
x99\ ]
=>99^ `
x99a b
.99b c
PaymentInfo99c n
)99n o
.99o p
Include99p w
(99w x
x99x y
=>99z |
x99} ~
.99~ 
Products	99 á
)
99á à
.
99à â
ThenInclude
99â î
(
99î ï
x
99ï ñ
=>
99ó ô
x
99ö õ
.
99õ ú
ProductDetail
99ú ©
)
99© ™
;
99™ ´
return:: 
	orderList:: 
;:: 
};; 	
public== 

IQueryable== 
<== 
Order== 
>==  
GetOrderByUserId==! 1
(==1 2
string==2 8
userId==9 ?
)==? @
{>> 	

IQueryable?? 
<?? 
Order?? 
>?? 
	orderList?? '
=??( )
_context??* 2
.??2 3
Orders??3 9
.??9 :
Where??: ?
(??? @
x??@ A
=>??B D
x??E F
.??F G
UserId??G M
==??N P
userId??Q W
)??W X
.??X Y
Include??Y `
(??` a
x??a b
=>??c e
x??f g
.??g h
	Addresses??h q
)??q r
.??r s
Include??s z
(??z {
x??{ |
=>??} 
x
??Ä Å
.
??Å Ç
PaymentInfo
??Ç ç
)
??ç é
.
??é è
Include
??è ñ
(
??ñ ó
x
??ó ò
=>
??ô õ
x
??ú ù
.
??ù û
Products
??û ¶
)
??¶ ß
.
??ß ®
ThenInclude
??® ≥
(
??≥ ¥
x
??¥ µ
=>
??∂ ∏
x
??π ∫
.
??∫ ª
ProductDetail
??ª »
)
??» …
;
??…  
return@@ 
	orderList@@ 
;@@ 
}AA 	
}BB 
}DD ≥
VC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Service\ICartService.cs
	namespace 	
OnlineShoppingApi
 
. 
Service #
{ 
public 

	interface 
ICartService !
{ 
bool 
	AddToCart 
( 
Cart 
cart  
)  !
;! "

IQueryable		 
<		 
Cart		 
>		 
GetCartDetails		 '
(		' (
string		( .
userId		/ 5
)		5 6
;		6 7
bool

 
OrderProducts

 
(

 
Order

  
orderDetails

! -
)

- .
;

. /

IQueryable 
< 
Order 
> 
GetAllOrders &
(& '
)' (
;( )

IQueryable 
< 
Order 
> 
GetOrderByUserId *
(* +
string+ 1
userId2 8
)8 9
;9 :
} 
} ¯
YC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Service\IProductService.cs
	namespace 	
OnlineShoppingApi
 
. 
Service #
{ 
public 

	interface 
IProductService $
{ 

IQueryable 
< 
Product 
> 
GetAllProducts *
(* +
string+ 1
orderBy2 9
)9 :
;: ;
Product		 
GetProductById		 
(		 
int		 "
id		# %
)		% &
;		& '

IQueryable

 
<

 
Product

 
>

 !
GetProductsByCategory

 1
(

1 2
string

2 8
category

9 A
)

A B
;

B C
bool 

AddProduct 
( 
Product 
product  '
)' (
;( )
bool 
AddProductsInBulk 
( 
IEnumerable *
<* +
Product+ 2
>2 3
productList4 ?
)? @
;@ A
} 
} Ë"
XC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\Service\ProductService.cs
	namespace 	
OnlineShoppingApi
 
. 
Service #
{ 
public 

class 
ProductService 
:  !
IProductService" 1
{ 
private		 
readonly		 !
OnlineShoppingContext		 .
_context		/ 7
;		7 8
public

 
ProductService

 
(

 !
OnlineShoppingContext

 3
context

4 ;
)

; <
{ 	
_context 
= 
context 
; 
} 	
public 

IQueryable 
< 
Product !
>! "
GetAllProducts# 1
(1 2
string2 8
orderBy9 @
)@ A
{ 	

IQueryable 
< 
Product 
> 
products  (
;( )
switch 
( 
orderBy 
) 
{ 
case 
	SortOrder 
. 
Asc "
:" #
products 
= 
_context '
.' (
Products( 0
.0 1
OrderBy1 8
(8 9
p9 :
=>; =
p> ?
.? @
Price@ E
)E F
;F G
break 
; 
case 
	SortOrder 
. 
Desc #
:# $
products 
= 
_context '
.' (
Products( 0
.0 1
OrderByDescending1 B
(B C
pC D
=>E G
pH I
.I J
PriceJ O
)O P
;P Q
break 
; 
default 
: 
products 
= 
_context '
.' (
Products( 0
;0 1
break 
; 
} 
return 
products 
; 
} 	
public!! 
Product!! 
GetProductById!! %
(!!% &
int!!& )
id!!* ,
)!!, -
{"" 	
return## 
_context## 
.## 
Products## $
.##$ %
Find##% )
(##) *
id##* ,
)##, -
;##- .
}$$ 	
public&& 

IQueryable&& 
<&& 
Product&& !
>&&! "!
GetProductsByCategory&&# 8
(&&8 9
string&&9 ?
category&&@ H
)&&H I
{'' 	

IQueryable(( 
<(( 
Product(( 
>(( 
products((  (
=(() *
_context((+ 3
.((3 4
Products((4 <
.((< =
Where((= B
(((B C
p((C D
=>((E G
p((H I
.((I J
Category((J R
.((R S
ToLower((S Z
(((Z [
)(([ \
.((\ ]
Contains((] e
(((e f
category((f n
.((n o
ToLower((o v
(((v w
)((w x
)((x y
)((y z
;((z {
return)) 
products)) 
;)) 
}** 	
public++ 
bool++ 

AddProduct++ 
(++ 
Product++ &
product++' .
)++. /
{,, 	
_context-- 
.-- 
Add-- 
(-- 
product--  
)--  !
;--! "
var.. 
result.. 
=.. 
_context.. !
...! "
SaveChanges.." -
(..- .
)... /
;../ 0
return// 
result// 
>// 
$num// 
;// 
}00 	
public22 
bool22 
AddProductsInBulk22 %
(22% &
IEnumerable22& 1
<221 2
Product222 9
>229 :
productList22; F
)22F G
{33 	
_context44 
.44 
AddRange44 
(44 
productList44 )
)44) *
;44* +
var55 
result55 
=55 
_context55 !
.55! "
SaveChanges55" -
(55- .
)55. /
;55/ 0
return66 
result66 
>66 
$num66 
;66 
}77 	
}88 
}99 ⁄
QC:\Users\prachaub2\Project\OnlineShoppingApi\OnlineShoppingApi\WeatherForecast.cs
	namespace 	
OnlineShoppingApi
 
; 
public 
class 
WeatherForecast 
{ 
public 

DateTime 
Date 
{ 
get 
; 
set  #
;# $
}% &
public 

int 
TemperatureC 
{ 
get !
;! "
set# &
;& '
}( )
public		 

int		 
TemperatureF		 
=>		 
$num		 !
+		" #
(		$ %
int		% (
)		( )
(		) *
TemperatureC		* 6
/		7 8
$num		9 ?
)		? @
;		@ A
public 

string 
? 
Summary 
{ 
get  
;  !
set" %
;% &
}' (
} 