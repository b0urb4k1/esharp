import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Http exposing (..)
import Task exposing (..)
import WebSocket


main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { input : String
  , messages : List String
  }


getJson : Cmd Msg
getJson = Task.perform HttpError HttpSuccess (getString "https://mtgjson.com/json/EMA.json")
-- getJson = Task.perform HttpError HttpSuccess (getString "http://localhost:8083/KLD.json")

init : (Model, Cmd Msg)
init =
  (Model "" [], getJson)


-- UPDATE

type Msg
  = Input String
  | Send
  | NewMessage String
  | HttpError Http.Error
  | HttpSuccess String

update : Msg -> Model -> (Model, Cmd Msg)
update msg {input, messages} =
  case msg of
    Input newInput ->
      (Model newInput messages, Cmd.none)

    Send ->
      (Model "" messages, WebSocket.send "ws://localhost:8083/websocket" input)

    NewMessage str ->
      (Model input (str :: messages), Cmd.none)

    HttpError error ->
      (Model "" ("" :: messages), Cmd.none)

    HttpSuccess str ->
      (Model "" (str :: messages), Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "ws://localhost:8083/websocket" NewMessage


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div [] (List.map viewMessage model.messages)
    , input [onInput Input] []
    , button [onClick Send] [text "xxxxxx"]
    ]


viewMessage : String -> Html msg
viewMessage msg =
  div [] [ text msg ]