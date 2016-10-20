// include Fake libs
#r "./packages/FAKE/tools/FakeLib.dll"

open Fake
open System

// Directories
let buildDir  = "./build/"

// Filesets
let appReferences  =
    !! "/**/*.csproj"
    ++ "/**/*.fsproj"

// version info
let version = "0.1"  // or retrieve from CI server

// Targets
Target "Clean" (fun _ ->
    CleanDirs [buildDir]
)

Target "Build" (fun _ ->
    // compile all projects below src/app/
    MSBuildDebug buildDir "Build" appReferences
    |> Log "AppBuild-Output: "
)

Target "Build-Elm" (fun _ ->
    let exitCode =
        ExecProcess (fun info ->
            info.FileName <- "elm-make.exe"
            info.WorkingDirectory <- "client"
            info.Arguments <- "src/main.elm --output=../build/main.html") TimeSpan.MaxValue
    trace "Elm Make"
)

// Build order
"Clean"
  ==> "Build"
  ==> "Build-Elm"

// start build
RunTargetOrDefault "Build-Elm"
