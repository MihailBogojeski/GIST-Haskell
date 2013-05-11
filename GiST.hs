{-# LANGUAGE MultiParamTypeClasses
    ,FlexibleInstances#-}

data GiST a         = Leaf [LeafEntry a] | Node [NodeEntry a]            -- | OrderedLeaf [OrderedLeafEntry a]
data Entry a        = LeafEntry (LeafEntry a)  | NodeEntry (NodeEntry a) -- | OrderedEntry(OrderedLeafEntry a) 


type LeafEntry a    = (a,Predicate a) 
--data OrderedLeafEntry a = OLeafEntry (OrderedLeafEntry a) (a,Predicate a) (OrderedLeafEntry a) | Nil

type NodeEntry a    = (GiST a,Predicate a)
type Penalty        = Integer
type Level          = Integer
data Predicate a    = Predicate (a -> Bool)

class Predicates p a  where
    consistent  ::  p a  -> (Entry a)    ->  p a  -> Bool
    union       ::  p a  -> [(Entry a)]  ->  p a
    penalty     ::  p a  -> (Entry a)    -> (Entry a)    -> Penalty
    pickSplit   ::  p a  ->[(Entry a)]  -> [[Entry a]]

class GiSTs g a where
    search          ::  g a -> Predicate a  -> [LeafEntry a]
    insert          ::  g a -> Entry a      -> Level        -> g a
    chooseSubtree   ::  g a -> Entry a      -> Level        -> g a 
    split           ::  g a -> g a          -> Entry a      -> g a
    adjustKeys      ::  g a -> g a          -> g a
    delete          ::  g a -> LeafEntry a  -> g a 
    condenseTree    ::  g a -> g a          -> g a


--class OrderedGiSTs g a where
--    findMin  ::  g a -> Predicate a -> OrderedLeafEntry a
--    next    ::  g a -> GiST a       -> OrderedLeafEntry a



instance (Eq a) => Predicates Predicate a where
    consistent p1 e p = True
    union p1  (e:es) =  p1
    penalty p1 e1 e2 =  0
    pickSplit p1 (e:es) = [es]
 --class Predicates p a where
--	consistent :: (Entry a) -> Predicate a-> Bool
--	union :: [(Entry a)] -> Predicate a
--	penalty :: (Entry a) -> (Entry a) -> a
--
--type Predicate a = (a -> Bool)
--type Node = [(Entry a)]
--
--  
--data Entry a = Entry (Predicate a)  Node	

