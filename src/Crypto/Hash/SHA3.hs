{-# LANGUAGE OverloadedStrings, JavaScriptFFI, ForeignFunctionInterface, InterruptibleFFI #-}

module Crypto.Hash.SHA3
    (

   --  hash     -- :: Int -> ByteString -> ByteString
    hashFFI
    ,hashIO
    , hash
    ) where

import Prelude hiding (init)

import GHCJS.Foreign
import GHCJS.Types
import GHCJS.Marshal

import  Control.Monad.IO.Class   (MonadIO (liftIO))
import  Data.ByteString 
import           Data.ByteString.Char8 as BC


foreign import javascript unsafe "var sha3 = require('crypto-js/sha3'); hash = sha3($2, { outputLength: $1 }); $r = hash.toString()"
    hashFFI :: Int -> JSString -> IO (JSString)

foreign import javascript unsafe "var sha3 = require('crypto-js/sha3'); hash = sha3($2, { outputLength: $1 }); $r = hash.toString()"
    hashFFI' :: Int -> JSString -> JSString



hashIO :: Int -> ByteString -> IO (ByteString)
hashIO n bs = do
    test <- liftIO $ hashFFI n (toJSString $ BC.unpack bs)
    return (BC.pack $ fromJSString test)

hash :: Int -> ByteString -> ByteString
hash n bs =  BC.pack $ fromJSString $ hashFFI' n (toJSString $ BC.unpack bs)