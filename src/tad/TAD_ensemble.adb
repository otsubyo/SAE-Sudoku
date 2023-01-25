pragma Ada_2012;
package body TAD_ensemble is

   ------------------------
   -- construireEnsemble --
   ------------------------

   function construireEnsemble return Type_Ensemble is
      e : Type_Ensemble;
   begin
      for i in 1..9 loop
         e(i) := False;
      end loop;
      return e;
   end construireEnsemble;

   ------------------
   -- ensembleVide --
   ------------------

   function ensembleVide (e : in Type_Ensemble) return Boolean is
   begin
      return (e = (False, False, False, False, False, False, False, False, False));
   end ensembleVide;

   -----------------------
   -- appartientChiffre --
   -----------------------

   function appartientChiffre(e : in Type_Ensemble; v : in Integer) return Boolean is
   begin
      return (e(v) = True);
   end appartientChiffre;

   --------------------
   -- nombreChiffres --
   --------------------

   function nombreChiffres (e : in Type_Ensemble) return Integer is
      n : Integer; -- nombre d'elements dans l'ensemble
   begin
      n := 0;
      for i in 1 .. 9 loop
         if e(i) = True then
            n := n + 1;
         end if;
      end loop;
      return n;
   end nombreChiffres;

   --------------------
   -- ajouterChiffre --
   --------------------

   procedure ajouterChiffre (e : in out Type_Ensemble; v : in Integer) is
   begin
      if e(v) = True then
         raise APPARTIENT_ENSEMBLE;
      end if;
      e(v) := True;
   end ajouterChiffre;

   --------------------
   -- retirerChiffre --
   --------------------

   procedure retirerChiffre (e : in out Type_Ensemble; v : in Integer) is
   begin
      if e(v) = False then
         raise NON_APPARTIENT_ENSEMBLE;
      end if;
      e(v) := False;
   end retirerChiffre;

end TAD_ensemble;
