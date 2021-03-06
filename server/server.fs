
open Suave
open Suave.Http
open Suave.Operators
open Suave.Filters
open Suave.Successful
open Suave.Files
open Suave.RequestErrors
open Suave.Logging
open Suave.Utils
open Suave.Writers

open System
open System.Net

open Suave.Sockets
open Suave.Sockets.Control
open Suave.WebSocket

let echo (webSocket : WebSocket) =
  fun cx -> socket {
    let loop = ref true
    while !loop do
      let! msg = webSocket.read()
      match msg with
      | (Text, data, true) ->
        do! webSocket.send Text data true
      | (Ping, _, _) ->
        do! webSocket.send Pong [||] true
      | (Close, _, _) ->
        do! webSocket.send Close [||] true
        loop := false
      | _ -> ()
  }
let noCache =
  setHeader "Cache-Control" "no-cache, no-store, must-revalidate"
  >=> setHeader "Pragma" "no-cache"
  >=> setHeader "Expires" "0"

let app : WebPart =
  choose [
    path "/websocket" >=> handShake echo
    GET >=> choose
      [ path "/" >=> noCache >=> file "main.html"
      ; browseHome
      ]
    NOT_FOUND "Found no handlers."
    ]

[<EntryPoint>]
let main _ =
  startWebServer defaultConfig app
  0