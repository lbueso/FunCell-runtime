{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Text (Text)
import Data.Aeson (decode, encode)
import Control.Monad (forever)
import qualified Network.WebSockets as WS

import Lib
import ParsingLib

type ServerState = [Text]

newServerState :: ServerState
newServerState = []

application :: ServerState -> WS.ServerApp
application state pending = do
  putStrLn "Connection started!"
  conn <- WS.acceptRequest pending
  forever $ do
    msg  <- WS.receiveData conn
    putStrLn $ "[ENCODED]: " <> (show msg)
    let cells = (decode msg) :: Maybe [Cell]
        json  = maybe "Error" (encode . map updateEvalResult) cells
    putStrLn $ "[DECODED]: " <> maybe "Error" show cells
    WS.sendTextData conn $ json
      where updateEvalResult cell = cell { evalResult = parseAndEval (cellContent cell) }
            cellContent cell = maybe "" id (content cell)

main :: IO ()
main = do
  putStr "Starting Server... "
  putStrLn "Done!"
  WS.runServer "127.0.0.1" 9160 $ application newServerState
