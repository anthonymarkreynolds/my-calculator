module ExprParser where

import Text.Parsec
import Text.Parsec.String (Parser)

-- Define the expression type
data Expr = Add Expr Expr
          | Sub Expr Expr
          | Mul Expr Expr
          | Div Expr Expr
          | Val Double
  deriving (Show)

-- Define parsers for values and operators
double :: Parser Expr
double = do
  n <- many1 digit
  return $ Val (read n)

op :: Char -> (Expr -> Expr -> Expr) -> Parser (Expr -> Expr -> Expr)
op c opf = do
  char c
  return opf

-- Define the expression parser
expr :: Parser Expr
expr = do
  e1 <- term
  e2 <- optionMaybe (addop <|> subop)
  case e2 of
    Nothing -> return e1
    Just f  -> expr >>= return . f e1

term :: Parser Expr
term = do
  e1 <- factor
  e2 <- optionMaybe (mulop <|> divop)
  case e2 of
    Nothing -> return e1
    Just f  -> term >>= return . f e1

factor :: Parser Expr
factor = parens expr <|> double

-- Define the operators
addop :: Parser (Expr -> Expr -> Expr)
addop = op '+' Add

subop :: Parser (Expr -> Expr -> Expr)
subop = op '-' Sub

mulop :: Parser (Expr -> Expr -> Expr)
mulop = op '*' Mul

divop :: Parser (Expr -> Expr -> Expr)
divop = op '/' Div

parens :: Parser a -> Parser a
parens p = do
  char '('
  x <- p
  char ')'
  return x

-- Evaluate the expression
eval :: Expr -> Double
eval (Add e1 e2) = eval e1 + eval e2
eval (Sub e1 e2) = eval e1 - eval e2
eval (Mul e1 e2) = eval e1 * eval e2
eval (Div e1 e2) = eval e1 / eval e2
eval (Val n) = n