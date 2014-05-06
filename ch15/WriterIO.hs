{-# LANGUAGE GeneralizedNewtypeDeriving, TypeSynonymInstances, FlexibleInstances, MultiParamTypeClasses #-}

module WriterIO where

import Control.Monad.Writer
import System.IO (IOMode(..))
import SafeHello
import MonadHandle

data Event = Open FilePath IOMode
           | Put String String
           | Close String
           | GetContents String
             deriving (Show)

newtype WriterIO a = W { runW :: Writer [Event] a } 
    deriving (Monad, MonadWriter [Event])

instance MonadHandle FilePath WriterIO where
    openFile path mode = tell [Open path mode] >> return path
    hPutStr path str = tell [Put path str]
    hClose path = tell [Close path]
    hGetContents path = undefined

runWriterIO :: WriterIO a -> (a, [Event])
runWriterIO = runWriter . runW

