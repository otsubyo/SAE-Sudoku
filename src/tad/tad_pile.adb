pragma Ada_2012;
package body TAD_Pile is

   --------------------
   -- ConstruirePile --
   --------------------

   function construirePile return Type_Pile is
      p : Type_Pile;
   begin
      p.nb_Elements := 0;
      return p;
   end construirePile;

   -------------
   -- Empiler --
   -------------

   function empiler (p : in Type_Pile; e : in T) return Type_Pile is
      pile: Type_Pile;
   begin
      pile := p;
      if pile.nb_Elements = TAILLE_MAX then
         raise PILE_PLEINE;
      end if;
      pile.nb_Elements              := pile.nb_Elements + 1;
      pile.elements (pile.nb_Elements) := e;
      return pile;
   end empiler;

   -------------
   -- Depiler --
   -------------

   function depiler (p : in Type_Pile) return Type_Pile is
      pile: Type_Pile;
   begin
      pile:= p;
      if estVide (pile) then
         raise PILE_VIDE;
      end if;
      pile.nb_Elements := pile.nb_Elements - 1;
      return pile;
   end depiler;

   -------------
   -- estVide --
   -------------

   function estVide (p : in Type_Pile) return Boolean is
      pile : Type_Pile;
   begin
      pile := p;
      if pile.nb_Elements = 0 then
         return True;
      else
         return False;
      end if;

   end estVide;

   -------------
   -- dernier --
   -------------

   function dernier (p : in Type_Pile) return T is
      pile: Type_Pile;
   begin
      pile := p;
      if estVide (pile) then
         raise PILE_VIDE;
      end if;
      return pile.elements (pile.nb_Elements);
   end dernier;

end TAD_Pile;
