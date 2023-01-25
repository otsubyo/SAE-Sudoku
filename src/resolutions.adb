pragma Ada_2012;
package body resolutions is

   -----------------------
   -- estChiffreValable --
   -----------------------

   function estChiffreValable
     (g : in Type_Grille; v : in Integer; c : in Type_Coordonnee) return Boolean
   is
      e,xL,yC,zCa : Type_Ensemble;
      x,y,z : Integer;
   begin
      if not caseVide(g,c) then
         raise CASE_NON_VIDE;
      end if;
      e := construireEnsemble;
      x := obtenirLigne(c);
      y := obtenirColonne(c);
      z := obtenirCarre(c);
      xL := obtenirChiffresDUneLigne(g,x);
      yC := obtenirChiffresDUneColonne(g,y);
      zCa := obtenirChiffresDUnCarre(g,z);

      if not appartientChiffre(xL,v) and not appartientChiffre(yC,v) and not appartientChiffre(zCa,v) then
         return True; -- Le chiffre est valable
      else
         return False;
      end if;

   end estChiffreValable;

   -------------------------------
   -- obtenirSolutionsPossibles --
   -------------------------------

   function obtenirSolutionsPossibles (g : in Type_Grille; c : in Type_Coordonnee) return Type_Ensemble is
      e: Type_Ensemble;
   begin
      if not caseVide(g,c) then
         raise CASE_NON_VIDE;
      end if;

      -- Les valeurs possible allant de 1 a 9
      for i in 1..9 loop
         if estChiffreValable(g,i,c) then
            ajouterChiffre(e,i); -- On ajoute les valeurs possibles a l'ensemble
         end if;
      end loop;
      return e;
   end obtenirSolutionsPossibles;

   ------------------------------------------
   -- rechercherSolutionUniqueDansEnsemble --
   ------------------------------------------

   function rechercherSolutionUniqueDansEnsemble(resultats : in Type_Ensemble) return Integer is
      solution: Integer;
   begin
      if ensembleVide(resultats) then
         raise ENSEMBLE_VIDE;
      end if;
      if nombreChiffres(resultats) > 1 then
         raise PLUS_DE_UN_CHIFFRE;
      end if;

      for i in 1..9 loop
         if appartientChiffre(resultats,i) then
            solution := i;
         end if;
      end loop;
      return solution;
   end rechercherSolutionUniqueDansEnsemble;

   --------------------
   -- resoudreSudoku --
   --------------------

   procedure resoudreSudoku (g : in out Type_Grille; trouve : out Boolean; cpt: out Integer) is
      miniCarre,a: Type_Coordonnee; -- mini carre
      p,pile: Type_Pile;
      cp: Type_cas_possibles;
      compteurCp: Integer;
   begin
      p := construirePile;
      trouve := False;
      cpt := 0;
      while not trouve loop
         for i in 1..9 loop
            for j in 1..9 loop
               miniCarre := construireCoordonnees(i,j);
               if caseVide(g,miniCarre) then
                  compteurCp := 0;
                  for k in 1..9 loop
                     if estChiffreValable(g,k,miniCarre) then
                        cp.c := miniCarre;
                        cp.n := k;
                        p := empiler(p,cp);
                        compteurCp := compteurCp + 1;
                     end if;
                  end loop;
                  if compteurCp = 0 then
                     p := depiler(p);
                     p := depiler(pile);
                     viderCase(g,a);
                     fixerChiffre(g,dernier(p).c,dernier(p).n,cpt);
                  else
                     fixerChiffre(g,dernier(p).c,dernier(p).n,cpt);
                  end if;
               end if;
            end loop;
         end loop;
         if estRemplie(g) then
            trouve := True;
         end if;
      end loop;
   end resoudreSudoku;
end resolutions;
