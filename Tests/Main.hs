{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import           Test.Tasty
import           Crypto.Hash.SHA3

import GHCJS.Foreign
import GHCJS.Types
import GHCJS.Marshal

import  Control.Monad.IO.Class   (MonadIO (liftIO))
import  Data.ByteString 
import           Data.ByteString.Char8 as BC
    
testHash :: IO ()
testHash = do
    --test <- hash 256 "hello world"
    test1 <- liftIO $ hashFFI 256 "hello world"
    Prelude.putStrLn $ fromJSString test1
    test2 <- liftIO $ hashIO 256 $ BC.pack "hello world"
    Prelude.putStrLn $ BC.unpack test2
    Prelude.putStrLn $ BC.unpack $ hash 256 $ BC.pack "hello world"
    return ()


-- ("SHA3-256", sha3Hash 256, [
--         "c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470",
--         "4d741b6f1eb29cb2a9b9911c82f56fa8d73b04959d3d9d222895df6c0b28aa15",
--         "ed6c07f044d7573cc53bf1276f8cba3dac497919597a45b4599c8f73e22aa334" ])

main :: IO ()
--main = defaultMain $ testGroup "Tests" [testHash]
main = testHash