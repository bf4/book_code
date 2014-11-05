intToType : Int -> Type
intToType 0 = Char
intToType _ = Int

pair : Type -> Type -> Type
pair a b = (a, b)

typeAndValue : (a:Type ** Integer)
typeAndValue = (Integer ** 3)

Measurement : (Result : Type ** (Integer -> Result))

Trip : (Location : Type) -> (Float -> Location)

total strToType : String -> Type
strToType "String" = String
strToType "Int" = Int
strToType _ = _|_
