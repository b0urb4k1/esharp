module Magic exposing (decodeSet, Set, Card, imageLocation)

import Json.Encode
import Json.Decode exposing ((:=))
import Json.Decode.Extra exposing ((|:))
import String
import Regex

type alias Set =
    { name : String
    , code : String
    , releaseDate : String
    , setType : String
    , cards : List Card
    }

decodeSet : Json.Decode.Decoder Set
decodeSet =
    Json.Decode.succeed Set
        |: ("name" := Json.Decode.string)
        |: ("code" := Json.Decode.string)
        |: ("releaseDate" := Json.Decode.string)
        |: ("type" := Json.Decode.string)
        |: ("cards" := Json.Decode.list decodeCard)

encodeSet : Set -> Json.Encode.Value
encodeSet record =
    Json.Encode.object
        [ ("name",  Json.Encode.string <| record.name)
        , ("code",  Json.Encode.string <| record.code)
        , ("releaseDate",  Json.Encode.string <| record.releaseDate)
        , ("type",  Json.Encode.string <| record.setType)
        , ("cards",  Json.Encode.list <| List.map encodeCard <| record.cards)
        ]

type alias Card =
    { artist : String
    -- , cmc : Int
    -- , colorIdentity : List String
    -- , colors : List String
    -- , flavor : String
    , id : String
    -- , imageName : String
    -- , layout : String
    -- , manaCost : String
    , multiverseid : Int
    , name : String
    -- , number : String
    -- , rarity : String
    -- , text : String
    , cardType : String
    -- , types : List String
    }

decodeCard : Json.Decode.Decoder Card
decodeCard =
    Json.Decode.succeed Card
        |: ("artist" := Json.Decode.string)
        -- |: ("cmc" := Json.Decode.int)
        -- |: ("colorIdentity" := Json.Decode.list Json.Decode.string)
        -- |: ("colors" := Json.Decode.list Json.Decode.string)
        -- |: ("flavor" := Json.Decode.string)
        |: ("id" := Json.Decode.string)
        -- |: ("imageName" := Json.Decode.string)
        -- |: ("layout" := Json.Decode.string)
        -- |: ("manaCost" := Json.Decode.string)
        |: ("multiverseid" := Json.Decode.int)
        |: ("name" := Json.Decode.string)
        -- |: ("number" := Json.Decode.string)
        -- |: ("rarity" := Json.Decode.string)
        -- |: ("text" := Json.Decode.string)
        |: ("type" := Json.Decode.string)
        -- |: ("types" := Json.Decode.list Json.Decode.string)

encodeCard : Card -> Json.Encode.Value
encodeCard record =
    Json.Encode.object
        [ ("artist",  Json.Encode.string <| record.artist)
        -- , ("cmc",  Json.Encode.int <| record.cmc)
        -- , ("colorIdentity",  Json.Encode.list <| List.map Json.Encode.string <| record.colorIdentity)
        -- , ("colors",  Json.Encode.list <| List.map Json.Encode.string <| record.colors)
        -- , ("flavor",  Json.Encode.string <| record.flavor)
        , ("id",  Json.Encode.string <| record.id)
        -- , ("imageName",  Json.Encode.string <| record.imageName)
        -- , ("layout",  Json.Encode.string <| record.layout)
        -- , ("manaCost",  Json.Encode.string <| record.manaCost)
        , ("multiverseid",  Json.Encode.int <| record.multiverseid)
        , ("name",  Json.Encode.string <| record.name)
        -- , ("number",  Json.Encode.string <| record.number)
        -- , ("rarity",  Json.Encode.string <| record.rarity)
        -- , ("text",  Json.Encode.string <| record.text)
        , ("type",  Json.Encode.string <| record.cardType)
        -- , ("types",  Json.Encode.list <| List.map Json.Encode.string <| record.types)
        ]

-- imageLocation : String -> String -> Int -> String
-- imageLocation set cardName mid =
--     let cn = String.toLower cardName |> Regex.replace Regex.All (Regex.regex " ") (\_ -> "-")
--     in "http://cdmvi.s3-website-us-east-1.amazonaws.com/Staging/Crop-190x147/" ++ set ++ "/" ++ cn ++ "-CDMV-" ++ (toString mid) ++ ".jpg"

imageLocation : Int -> String
imageLocation mid =
    "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=" ++ (toString mid) ++ "&type=card"