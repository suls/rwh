{-# LANGUAGE GeneralizedNewtypeDeriving, FlexibleInstances, MultiParamTypeClasses #-}

import SupplyClass
import Control.Monad

newtype Reader e a = R { runReader :: e -> a } 

instance Monad (Reader e) where
    return a = R $ \_ -> a 
    m >>= k = R $ \r -> runReader (k (runReader m r)) r

ask :: Reader e e 
ask = R id    

newtype ReaderSupply e a = ReaderSupply x y { runReaderSupply :: Reader e a } deriving (Monad)

instance MonadSupply e (ReaderSupply e) where
    next = ReaderSupply (Just `liftM` ask)    

xy :: (Num s, MonadSupply s m) => m s
xy = do
    Just x <- next
    Just y <- next
    return (x*y)

runMS :: ReaderSupply i a -> i -> a
runMS = runReader . runReaderSupply