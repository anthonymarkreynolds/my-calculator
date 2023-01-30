module Main (main) where

import Text.Parsec
import ExprParser

main :: IO ()
main = do
  putStr "> "
  input <- getLine
  case parse expr "" input of
    Left error -> print error
    Right expr -> print (eval expr)
  main
