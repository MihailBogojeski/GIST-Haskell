{-# LANGUAGE MultiParamTypeClasses
    ,FlexibleInstances#-}

data GiST p a  = Leaf [LeafEntry p a] | Node [NodeEntry p a]            -- | OrderedLeaf [OrderedLeafEntry a]
data Entry p a = LeafEntry (LeafEntry p a)  | NodeEntry (NodeEntry p a) -- | OrderedEntry(OrderedLeafEntry a) 


type LeafEntry p a    = (a, p a) 
--data OrderedLeafEntry a = OLeafEntry (OrderedLeafEntry a) (a,Predicate a) (OrderedLeafEntry a) | Nil

type NodeEntry p a    = (GiST p a, p a)
type Penalty        = Integer
type Level          = Integer
data Predicate a    = Predicate (a -> Bool) 

class Predicates p a  where
    consistent  :: (Entry p a)  ->  p a  -> Bool
    union       :: [(Entry p a)] ->  p a
    penalty     :: (Entry p a)    -> (Entry p a)    -> Penalty
    pickSplit   :: [(Entry p a)]  -> [[Entry p a]]

class GiSTs g p a where
    search          :: Predicates p a => g p a -> p a  -> [LeafEntry p a]
    insert          :: Predicates p a => g p a -> Entry p a      -> Level        -> g p a
    chooseSubtree   :: Predicates p a => g p a -> Entry p a      -> Level        -> g p a 
    split           :: Predicates p a => g p a -> g p a          -> Entry p a      -> g p a
    adjustKeys      :: Predicates p a => g p a -> g p a          -> g p a
    delete          :: Predicates p a => g p a -> LeafEntry p a  -> g p a 
    condenseTree    :: Predicates p a => g p a -> g p a          -> g p a


--class OrderedGiSTs g a where
--    findMin  ::  g a -> Predicate a -> OrderedLeafEntry a
--    next    ::  g a -> GiST a       -> OrderedLeafEntry a



instance (Eq a) => Predicates Predicate a where
    consistent e p = True
    union ((LeafEntry (a1, p)):es) = p
    union ((NodeEntry (g, p)):es) = p
    penalty e1 e2 =  0
    pickSplit  (e:es) = [es]
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

