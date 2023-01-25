pragma Ada_2012;
package body TAD_grilleSudoku is

   ----------------------
   -- construireGrille --
   ----------------------

   function construireGrille return Type_Grille is
      g : Type_Grille;
   begin
      for i in 1 .. 9 loop
         for j in 1 .. 9 loop
            g(i, j) := 0;
         end loop;
      end loop;
      return g;

   end construireGrille;

   --------------
   -- caseVide --
   --------------
   function caseVide
     (g : in Type_Grille; c : in Type_Coordonnee) return Boolean
   is
   begin
      return g(obtenirLigne(c), obtenirColonne (c)) = 0;
   end caseVide;

   --------------------
   -- obtenirChiffre --
   --------------------

   function obtenirChiffre
     (g : in Type_Grille; c : in Type_Coordonnee) return Integer
   is
   begin
      if caseVide(g,c) then
         raise OBTENIR_CHIFFRE_NUL;
      end if;
      return (g (obtenirLigne (c), obtenirColonne (c)));
   end obtenirChiffre;

   --------------------
   -- nombreChiffres --
   --------------------

   function nombreChiffres (g : in Type_Grille) return Integer is
      n : Integer; -- le nombre d'elements dans la grille
   begin
      n := 0;
      for i in 1 .. 9 loop
         for j in 1 .. 9 loop
            if g (i, j) /= 0 then
               n := n + 1;
            end if;
         end loop;
      end loop;
      return n;
   end nombreChiffres;

   ------------------
   -- fixerChiffre --
   ------------------

   procedure fixerChiffre
     (g : in out Type_Grille; c : in Type_Coordonnee; v : in Integer; cpt : in out Integer)
   is
   begin

      if not caseVide(g,c) then
         raise FIXER_CHIFFRE_NON_NUL;
      end if;
      g (obtenirLigne (c), obtenirColonne (c)) := v;
      cpt := cpt + 1;

   end fixerChiffre;

   ---------------
   -- viderCase --
   ---------------
   procedure viderCase (g : in out Type_Grille; c : in out Type_Coordonnee) is
   begin
      if g(obtenirLigne (c), obtenirColonne (c)) = 0 then
         raise VIDER_CASE_VIDE;
      end if;
      g(obtenirLigne (c), obtenirColonne (c)) := 0;
   end viderCase;

   ----------------
   -- estRemplie --
   ----------------
   function estRemplie (g : in Type_Grille) return Boolean is
      n : Integer; -- le nombre de cases vides dans la grille
   begin

      n := 0;
      for i in 1 .. 9 loop
         for j in 1 .. 9 loop
            if g(i, j) = 0 then
               n := n + 1;
            end if;
         end loop;
      end loop;
      return (n = 0);

   end estRemplie;

   ------------------------------
   -- obtenirChiffresDUneLigne --
   ------------------------------
   function obtenirChiffresDUneLigne
     (g : in Type_Grille; numLigne : in Integer) return Type_Ensemble
   is
      e : Type_Ensemble;
   begin
      e := construireEnsemble;
      for i in 1 .. 9 loop
         if not caseVide (g, construireCoordonnees(numLigne, i)) then
            ajouterChiffre (e, (g (numLigne, i)));
         end if;
      end loop;
      return e;
   end obtenirChiffresDUneLigne;

   --------------------------------
   -- obtenirChiffresDUneColonne --
   --------------------------------
   function obtenirChiffresDUneColonne
     (g : in Type_Grille; numColonne : in Integer) return Type_Ensemble
   is
      e : Type_Ensemble;
   begin
      e := construireEnsemble;
      for i in 1 .. 9 loop
         if not caseVide (g, construireCoordonnees (i, numColonne)) then
            ajouterChiffre (e, (g (i, numColonne)));
         end if;
      end loop;
      return e;
   end obtenirChiffresDUneColonne;

   -----------------------------
   -- obtenirChiffresDUnCarre --
   -----------------------------
   function obtenirChiffresDUnCarre(g : in Type_Grille; numCarre : in Integer) return Type_Ensemble
   is
      c : Type_Coordonnee;
      r : Type_Ensemble;
   begin
      r := construireEnsemble;
      c := obtenirCoordonneeCarre (numCarre);
      for i in obtenirLigne (c) .. obtenirLigne (c) + 2 loop
         for j in obtenirColonne (c) .. obtenirColonne (c) + 2 loop
            if not caseVide (g, construireCoordonnees (i, j)) then
               ajouterChiffre(r, obtenirChiffre(g, construireCoordonnees(i, j)));
            end if;
         end loop;
      end loop;
      return r;
   end obtenirChiffresDUnCarre;

end TAD_grilleSudoku;
