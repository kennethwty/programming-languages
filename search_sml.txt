val callcc = SMLofNJ.Cont.callcc
val throw  = SMLofNJ.Cont.throw
type 'a cont  = 'a SMLofNJ.Cont.cont

type choice   = int cont * (int -> int) * int
val cpStack : choice list ref = ref nil
fun pushCP p = cpStack := p::(!cpStack)
fun popCP () = let val (a::bs)= !cpStack
		   val _      = cpStack := bs
	       in a
	       end
	       
fun label (lb,ub) =
    let val s = callcc (fn k =>let fun branch c = if (c < ub)
						  then (pushCP (k,branch,c+1);c)
						  else ub
			       in (pushCP(k,branch,lb+1);lb)
			       end)
    in {value=s,dom=(lb,ub)}
    end
    
fun backtrack() = if null (!cpStack)
		  then ()
		  else let val (k,C,n) = popCP ()
		       in throw k (C n)
		       end

fun labelList [] = nil
  | labelList (a::bs) = (label a)::(labelList bs)

fun printList nil = "\n"
  | printList ({value=a,dom=(lb,ub)}::bs) = Int.toString(a) ^ "," ^ (printList bs)

fun makeVars 0 l u = nil
  | makeVars n l u = (l,u)::(makeVars (n-1) l u)

fun onRow r1 d nil = false
  | onRow r1 d ({value=r2,dom=(lb,ub)}::qs) = if r1 = r2 orelse r1 = r2 + d orelse r1 = r2 - d
					      then true
					      else onRow r1 (d+1) qs
					 
fun check nil = true
  | check ({value=r,dom=(lb,ub)}::qs) = if (onRow r 1 qs)
					then (backtrack();false)
					else check qs
    
fun main () = let val n  = 8
		  val l  = makeVars n 0 (n-1)
		  val nb = ref 0
		  val x  = labelList l
	      in if check x
		 then (print (printList x);nb := !nb + 1;backtrack())
		 else print ("\n#sol = " ^ (Int.toString(!nb)) ^ "\n")
	      end
