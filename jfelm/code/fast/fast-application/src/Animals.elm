module Animals exposing (breeds, catBreeds, collectBreeds, decode, dogBreeds, fetch, save)

import Animal exposing (Animal)
import Animal.Kind exposing (Kind(Dog))
import Http
import Json.Decode exposing (Decoder, list)
import Set


fetch : String -> (Result Http.Error (List Animal) -> msg) -> Cmd msg
fetch url onReceive =
    Http.get url decode
        |> Http.send onReceive


decode : Decoder (List Animal)
decode =
    list Animal.decode


breeds : List Animal -> List String
breeds animals =
    animals
        |> List.map .breed
        |> unique
        |> List.sort


dogBreeds : List Animal -> List String
dogBreeds animals =
    animals
        |> collectBreeds
        |> Tuple.first


catBreeds : List Animal -> List String
catBreeds animals =
    animals
        |> collectBreeds
        |> Tuple.second


collectBreeds : List Animal -> ( List String, List String )
collectBreeds animals =
    animals
        |> List.partition (\animal -> animal.kind == Dog)
        |> Tuple.mapFirst (List.map .breed >> unique)
        |> Tuple.mapSecond (List.map .breed >> unique)


save : Animal -> List Animal -> List Animal
save newAnimal animals =
    List.map
        (\animal ->
            if animal.id == newAnimal.id then
                newAnimal
            else
                animal
        )
        animals


unique : List comparable -> List comparable
unique list =
    list
        |> Set.fromList
        |> Set.toList
