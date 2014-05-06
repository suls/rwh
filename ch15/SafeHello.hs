module SafeHello where

import MonadHandle
import System.IO (IOMode(..))
import MonadHandleIO

safeHello :: MonadHandle h m => FilePath -> m ()
safeHello path = do
    h <- openFile path WriteMode
    hPutStrLn h "hello world!"
    hClose h