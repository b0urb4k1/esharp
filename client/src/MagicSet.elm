module MagicSet exposing (..)

import Json.Encode
import Json.Decode exposing ((:=))
import Json.Decode.Extra exposing ((|:))
import MagicCard exposing (..)

type alias Set =
    { name : String
    , code : String
    , releaseDate : String
    , border : String
    , setType : String
    -- , booster : List List String
    , cards : List Card
    }

decodeSet : Json.Decode.Decoder Set
decodeSet =
    Json.Decode.succeed Set
        |: ("name" := Json.Decode.string)
        |: ("code" := Json.Decode.string)
        |: ("releaseDate" := Json.Decode.string)
        |: ("border" := Json.Decode.string)
        |: ("type" := Json.Decode.string)
        -- |: ("booster" := Json.Decode.list Json.Decode.list Json.Decode.string)
        |: ("cards" := Json.Decode.list decodeCard)

encodeSet : Set -> Json.Encode.Value
encodeSet record =
    Json.Encode.object
        [ ("name",  Json.Encode.string <| record.name)
        , ("code",  Json.Encode.string <| record.code)
        , ("releaseDate",  Json.Encode.string <| record.releaseDate)
        , ("border",  Json.Encode.string <| record.border)
        , ("type",  Json.Encode.string <| record.setType)
        -- , ("booster",  Json.Encode.list <| List.map Json.Encode.list <| List.map Json.Encode.string <| record.booster)
        , ("cards",  Json.Encode.list <| List.map encodeCard <| record.cards)
        ]