module MagicCard exposing (..)

import Json.Encode
import Json.Decode exposing ((:=))
import Json.Decode.Extra exposing ((|:))

type alias Card =
    { artist : String
    , cmc : Int
    , colorIdentity : List String
    , colors : List String
    , flavor : String
    , id : String
    , imageName : String
    , layout : String
    , manaCost : String
    , multiverseid : Int
    , name : String
    , number : String
    , rarity : String
    , text : String
    , cardType : String
    , types : List String
    }

decodeCard : Json.Decode.Decoder Card
decodeCard =
    Json.Decode.succeed Card
        |: ("artist" := Json.Decode.string)
        |: ("cmc" := Json.Decode.int)
        |: ("colorIdentity" := Json.Decode.list Json.Decode.string)
        |: ("colors" := Json.Decode.list Json.Decode.string)
        |: ("flavor" := Json.Decode.string)
        |: ("id" := Json.Decode.string)
        |: ("imageName" := Json.Decode.string)
        |: ("layout" := Json.Decode.string)
        |: ("manaCost" := Json.Decode.string)
        |: ("multiverseid" := Json.Decode.int)
        |: ("name" := Json.Decode.string)
        |: ("number" := Json.Decode.string)
        |: ("rarity" := Json.Decode.string)
        |: ("text" := Json.Decode.string)
        |: ("type" := Json.Decode.string)
        |: ("types" := Json.Decode.list Json.Decode.string)

encodeCard : Card -> Json.Encode.Value
encodeCard record =
    Json.Encode.object
        [ ("artist",  Json.Encode.string <| record.artist)
        , ("cmc",  Json.Encode.int <| record.cmc)
        , ("colorIdentity",  Json.Encode.list <| List.map Json.Encode.string <| record.colorIdentity)
        , ("colors",  Json.Encode.list <| List.map Json.Encode.string <| record.colors)
        , ("flavor",  Json.Encode.string <| record.flavor)
        , ("id",  Json.Encode.string <| record.id)
        , ("imageName",  Json.Encode.string <| record.imageName)
        , ("layout",  Json.Encode.string <| record.layout)
        , ("manaCost",  Json.Encode.string <| record.manaCost)
        , ("multiverseid",  Json.Encode.int <| record.multiverseid)
        , ("name",  Json.Encode.string <| record.name)
        , ("number",  Json.Encode.string <| record.number)
        , ("rarity",  Json.Encode.string <| record.rarity)
        , ("text",  Json.Encode.string <| record.text)
        , ("type",  Json.Encode.string <| record.cardType)
        , ("types",  Json.Encode.list <| List.map Json.Encode.string <| record.types)
        ]