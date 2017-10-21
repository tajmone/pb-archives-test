; ������������������������������������������������������������������������������
; ������������������������������������������������������������������������������
; ��������������������������� PureBasicPOO H�ritage ����������������������������
; ������������������������������������������������������������������������������
; ��������������������������������� Exemple 1 ����������������������������������
; ������������������������������������������������������������������������������
; ������������������������������������������������������������������������������
; by Dr�c, (c) 2005.
; ------------------------------------------------------------------------------
; "POO-Heritage-Ex1.pb"
; �PureBASIC Archives� release v1.0, December 6, 2016.
;
; Minor changes to the original code, by Tristano Ajmone (@tajmone):
;   -- renamed some vars, procedures
;   -- added/changed source comments
;   -- removed English comments
; ------------------------------------------------------------------------------
; Released under Creative Common Attribution (CC BY 4.0) license:
;   -- https://creativecommons.org/licenses/by/4.0/deed.fr
; ------------------------------------------------------------------------------
; original file: "POO_Heritage.pb"
;   -- http://drac.site.chez.tiscali.fr/Tutorials Programming PureBasic/indexTutorials.htm#POO 
; ==============================================================================
;                                  DESCRIPTION                                  
; ==============================================================================
; Cet exemple montre comment une Classe concr�te ('Rect1') h�rite d�une Classe
; abstraite ('Shape'). 
; Elle montre aussi comment acc�der aux attributs d�un objet: soit par des
; m�thodes, soit par un pointeur sur l�objet. 
; ------------------------------------------------------------------------------

Interface Shape
  Draw() 
  Cut() 
  Get_var1() 
  Get_var2() 
EndInterface 

Structure Shape_ 
  *Methods
  var1.l 
  var2.l 
EndStructure 

Procedure Draw_Shape(*this.Shape_) 
  Debug "Draw from Shape Class" 
EndProcedure 

Procedure Cut_Shape(*this.Shape_) 
  Debug "Cut from Shape Class" 
EndProcedure 

Procedure Get_var2_Shape(*this.Shape_) 
  ProcedureReturn *this\var2 
EndProcedure 

Structure Mthds_Shape 
  *Draw
  *Cut
  *Get_var1
  *Get_var2
EndStructure 

Procedure Init_Mthds_Shape(*Mthds.Mthds_Shape) 
  *Mthds\Draw=@Draw_Shape() 
  *Mthds\Cut=@Cut_Shape() 
  *Mthds\Get_var2=@Get_var2_Shape() 
EndProcedure 

Mthds_Shape.Mthds_Shape 

Init_Mthds_Shape(@Mthds_Shape) 

; Ici la m�thode Get_var1() n�est pas impl�ment�e: la Classe Form est une Classe Abstraite 
; On n�a donc pas besoin de d�clarer de Constructeur ni de Destructeur de cette Classe 

Procedure Init_Mbers_Shape(*this.Shape_, var1.l, var2.l) 
  *this\var1=var1 
  *this\var2=var2 
EndProcedure  

Procedure.l New_Shape(var1.l, var2.l) 
  Shared Mthds_Shape 
  *this.Shape_ = AllocateMemory(SizeOf(Shape_)) 
  *this\Methods=@Mthds_Shape 
  Init_Mbers_Shape(*this, var1, var2) 
  ProcedureReturn *this 
EndProcedure 

Procedure Free_Shape(*this) 
  FreeMemory(*this) 
EndProcedure 

; ---------------------------------- 

Interface Rect1 Extends Shape 
  Erase() 
  Get_var4() 
EndInterface 

Structure Rect1_ Extends Shape_ 
  var3.l 
  var4.l 
  rectname.s 
EndStructure 

Procedure Draw_Rect1(*this.Rect1_) 
  Debug "Draw from Rect Class: " + *this\rectname 
EndProcedure 

Procedure Erase_Rect1(*this.Rect1_) 
  Debug "Erase from Rect Class: " + *this\rectname
EndProcedure 

Procedure Get_var1_Rect1(*this.Rect1_) 
  ProcedureReturn *this\var1 
EndProcedure 

Procedure Get_var4_Rect1(*this.Rect1_) 
  ProcedureReturn *this\var4 
EndProcedure 

Structure Mthds_Rect1 Extends Mthds_Shape 
  *Erase
  *Get_var4
EndStructure 

Procedure Init_Mthds_Rect1(*Mthds.Mthds_Rect1) 
  Init_Mthds_Shape(*Mthds)
  *Mthds\Draw=@Draw_Rect1() 
  *Mthds\Erase=@Erase_Rect1() 
  *Mthds\Get_var1=@Get_var1_Rect1() ; La Classe concr�te Rect1 se charge de donner l�impl�mentation de Get_var1() 
  *Mthds\Get_var4=@Get_var4_Rect1()
EndProcedure 

Mthds_Rect1.Mthds_Rect1 

Init_Mthds_Rect1(@Mthds_Rect1) 

Procedure Init_Mbers_Rect1(*this.Rect1_, var1.l, var2.l, var4.l, name.s) 
  Init_Mbers_Shape(*this, var1,var2)
  *this\var4=var4 
  *this\rectname=name 
EndProcedure  

Procedure.l New_Rect1(var1.l, var2.l, var4.l, name.s) 
  Shared Mthds_Rect1 
  *this.Rect1_ = AllocateMemory(SizeOf(Rect1_)) 
  *this\Methods=@Mthds_Rect1 
  Init_Mbers_Rect1(*this, var1, var2, var4, name) 
  ProcedureReturn *this 
EndProcedure 

Procedure Free_Rect1(*this) 
  FreeMemory(*this) 
EndProcedure 

; ---------------------------------- 

RectA.Rect1 = New_Rect1(1, 2, 6, "RectA") 
RectB.Rect1 = New_Rect1(3, 4, 7, "RectB") 

Debug ">> Method Test" 

RectA\Draw() 
RectA\Cut() 
RectA\Erase() 

RectB\Draw() 

Debug"" 
Debug ">> Access Test"

Debug""
*Rect.Rect1_= RectA
Debug " <var1> de "+*Rect\rectname  
Debug *Rect\var1 
Debug RectA\Get_var1()
Debug " <var4> de "+*Rect\rectname
Debug *Rect\var4 
Debug RectA\Get_var4() 

Debug""
*Rect.Rect1_= RectB
Debug " <var1> de "+*Rect\rectname  
Debug *Rect\var1 
Debug RectB\Get_var1() 
Debug " <var4> de "+*Rect\rectname 
Debug *Rect\var4 
Debug RectB\Get_var4()

Debug"" 
Debug ">> Destruction Test" 
Free_Rect1(RectA) 
Free_Rect1(RectB) 

;Rect\Draw() ; --> Impossible car l�objet Rect n�existe plus!

