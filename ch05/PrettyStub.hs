module PrettyStub where

import SimpleJSON

data Doc = ToBeDefined
    deriving (Show)


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
