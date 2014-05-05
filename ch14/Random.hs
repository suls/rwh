import System.Random
import Control.Monad.State

data CountedRandom = CountedRandom {
    crGen :: StdGen
  , crCount :: Int
} 

type CRState = State CountedRandom

getCountedRandom :: Random a => CRState a
getCountedRandom = do
    st <- get
    let (val, gen') = random (crGen st)
    put CountedRandom { crGen = gen', crCount = crCount st + 1 }
    return val

type RandomState = State StdGen

getRandom :: Random a => RandomState a
getRandom = 
    get >>= \gen ->
    let (val, gen') = random gen in
    put gen' >>
    return val

getTwoRandoms :: Random a => RandomState (a, a)
getTwoRandoms = liftM2 (,) getRandom getRandom

runTwoRandoms :: IO (Int, Int)
runTwoRandoms = do
    oldState <- getStdGen
    let (result, newState) = runState getTwoRandoms oldState
    setStdGen newState
    return result
