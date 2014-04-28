module PrettyStub where

import SimpleJSON
import Prettify (Doc)

text :: String -> Doc
text str = undefined

double :: Double -> Doc
double num = undefined

char :: Char -> Doc
char = undefined

(<>) :: Doc -> Doc -> Doc
a <> b = undefined

hcat :: [Doc] -> Doc
hcat = undefined

fsep :: [Doc] -> Doc
fsep xs = undefined