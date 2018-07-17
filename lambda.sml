signature LExpr = sig
    exception Bad of string	
    datatype expr = var   of string 
	          | apply of expr   * expr 
	          | abs   of string * expr
    type 'a Set
    val toString : expr -> string
    val freeV    : expr -> string Set
    val newName  : string Set -> string

    val subst    : string -> expr -> expr -> expr
    val alpha    : expr -> string Set -> expr
    val normal   : expr -> bool
    val beta     : expr -> expr
    val simp     : expr -> expr
end;

structure Lambda : LExpr = struct 
   type 'a Set  = 'a LSet.Set
   datatype expr =  var of string 
                  | apply of expr  * expr
                  | abs of  string * expr
   exception Bad of string

   fun toString (var x) = x
     | toString (apply(a,b)) = "(" ^ (toString a) ^ " " ^ (toString b) ^ ")"
     | toString (abs(v,e))   = "L"^ v ^ "." ^ (toString e)    


   fun freeV (var x)       = LSet.single x 
     | freeV (apply(a,b))  = LSet.union (freeV a) (freeV b)
     | freeV (abs(x,e))    = LSet.remove x (freeV e)

   fun newName s =  let fun genTest x n s = 
                          let val nn = x ^ "_" ^ (Int.toString n)
                          in if LSet.member nn s
                             then genTest x (n+1) s
                             else nn
                          end
                    in genTest "x" 0 s
                    end

   fun subst x y (var z)        = if x=z then y else var(z)
     | subst x y (abs(z,e))     = if x=z then abs(z,e) else abs(z,subst x y e)
     | subst x y (apply(a,b))   = apply(subst x y a,subst x y b)
       
   fun alpha (abs(x,e)) l  = if LSet.member x l
                             then let val y = (newName l)
                                  in abs(y,subst x (var y) e)
                                  end
                             else abs(x,alpha e l)
     | alpha t l = t

   fun normal (var x)              = true
     | normal (apply(abs(f,b),a))  = false
     | normal (apply(x,y))         = (normal x) andalso (normal y)
     | normal (abs(v,t))           = normal t

   fun beta (abs(x,e))          = abs(x,beta e)
     | beta (apply(abs(x,b),a)) = let val body = alpha b (freeV a)
                                  in subst x a body
                                  end
     | beta(apply(a,b)) = if (normal a)
                          then if (normal b) 
                               then apply(a,b)
                               else apply(a,beta b)
                          else apply(beta a,b)
     | beta(var x)      = var x

  fun simp e =     if normal e
                   then e
                   else simp (beta e)
end
