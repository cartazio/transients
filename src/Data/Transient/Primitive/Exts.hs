{-# LANGUAGE CPP #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}
{-# LANGUAGE Unsafe #-}
module Data.Transient.Primitive.Exts
  ( casArray
  , casIntArray
  , atomicReadIntArray
  , atomicWriteIntArray
  , fetchAddIntArray
  , fetchSubIntArray
  , fetchAndIntArray
  , fetchNandIntArray
  , fetchOrIntArray
  , fetchXorIntArray
  , prefetchByteArray0
  , prefetchByteArray1
  , prefetchByteArray2
  , prefetchByteArray3
  , prefetchMutableByteArray0
  , prefetchMutableByteArray1
  , prefetchMutableByteArray2
  , prefetchMutableByteArray3
  , prefetchValue0
  , prefetchValue1
  , prefetchValue2
  , prefetchValue3
  ) where

import Control.Monad.Primitive
import Data.Primitive.Array
import Data.Primitive.ByteArray
import Data.Transient.Primitive.Instances ()
import GHC.Prim
import GHC.Types

casArray :: PrimMonad m => MutableArray (PrimState m) a -> Int -> a -> a -> m (Int, a)
casArray (MutableArray m) (I# i) x y = primitive $ \s -> case casArray# m i x y s of
  (# s', i', z #) -> (# s', (I# i', z) #)

casIntArray :: PrimMonad m => MutableByteArray (PrimState m) -> Int -> Int -> Int -> m Int 
casIntArray (MutableByteArray m) (I# i) (I# x) (I# y) = primitive $ \s -> case casIntArray# m i x y s of
  (# s', i' #) -> (# s', I# i' #) 

atomicReadIntArray :: PrimMonad m => MutableByteArray (PrimState m) -> Int -> m Int
atomicReadIntArray (MutableByteArray m) (I# i) = primitive $ \s -> case atomicReadIntArray# m i s of
  (# s', i' #) -> (# s', I# i' #) 

atomicWriteIntArray :: PrimMonad m => MutableByteArray (PrimState m) -> Int -> Int -> m ()
atomicWriteIntArray (MutableByteArray m) (I# i) (I# j) = primitive_ $ \s -> atomicWriteIntArray# m i j s

fetchAddIntArray  :: PrimMonad m => MutableByteArray (PrimState m) -> Int -> Int -> m Int
fetchAddIntArray (MutableByteArray m) (I# i) (I# j) = primitive $ \s -> case fetchAddIntArray# m i j s of
  (# s', k #) -> (# s', I# k #)

fetchSubIntArray  :: PrimMonad m => MutableByteArray (PrimState m) -> Int -> Int -> m Int
fetchSubIntArray (MutableByteArray m) (I# i) (I# j) = primitive $ \s -> case fetchSubIntArray# m i j s of
  (# s', k #) -> (# s', I# k #)

fetchAndIntArray  :: PrimMonad m => MutableByteArray (PrimState m) -> Int -> Int -> m Int
fetchAndIntArray (MutableByteArray m) (I# i) (I# j) = primitive $ \s -> case fetchAndIntArray# m i j s of
  (# s', k #) -> (# s', I# k #)

fetchNandIntArray :: PrimMonad m => MutableByteArray (PrimState m) -> Int -> Int -> m Int
fetchNandIntArray (MutableByteArray m) (I# i) (I# j) = primitive $ \s -> case fetchNandIntArray# m i j s of
  (# s', k #) -> (# s', I# k #)

fetchOrIntArray   :: PrimMonad m => MutableByteArray (PrimState m) -> Int -> Int -> m Int
fetchOrIntArray (MutableByteArray m) (I# i) (I# j) = primitive $ \s -> case fetchOrIntArray# m i j s of
  (# s', k #) -> (# s', I# k #)

fetchXorIntArray  :: PrimMonad m => MutableByteArray (PrimState m) -> Int -> Int -> m Int
fetchXorIntArray (MutableByteArray m) (I# i) (I# j) = primitive $ \s -> case fetchXorIntArray# m i j s of
  (# s', k #) -> (# s', I# k #)

prefetchByteArray0, prefetchByteArray1, prefetchByteArray2, prefetchByteArray3 :: PrimMonad m => ByteArray -> Int -> m ()
prefetchByteArray0 (ByteArray m) (I# i) = primitive_ $ \s -> prefetchByteArray0# m i s
prefetchByteArray1 (ByteArray m) (I# i) = primitive_ $ \s -> prefetchByteArray1# m i s
prefetchByteArray2 (ByteArray m) (I# i) = primitive_ $ \s -> prefetchByteArray2# m i s
prefetchByteArray3 (ByteArray m) (I# i) = primitive_ $ \s -> prefetchByteArray3# m i s

prefetchMutableByteArray0, prefetchMutableByteArray1, prefetchMutableByteArray2, prefetchMutableByteArray3 :: PrimMonad m => MutableByteArray (PrimState m) -> Int -> m ()
prefetchMutableByteArray0 (MutableByteArray m) (I# i) = primitive_ $ \s -> prefetchMutableByteArray0# m i s
prefetchMutableByteArray1 (MutableByteArray m) (I# i) = primitive_ $ \s -> prefetchMutableByteArray1# m i s
prefetchMutableByteArray2 (MutableByteArray m) (I# i) = primitive_ $ \s -> prefetchMutableByteArray2# m i s
prefetchMutableByteArray3 (MutableByteArray m) (I# i) = primitive_ $ \s -> prefetchMutableByteArray3# m i s

prefetchValue0, prefetchValue1, prefetchValue2, prefetchValue3 :: PrimMonad m => a -> m ()
prefetchValue0 a = primitive_ $ \s -> prefetchValue0# a s
prefetchValue1 a = primitive_ $ \s -> prefetchValue1# a s
prefetchValue2 a = primitive_ $ \s -> prefetchValue2# a s
prefetchValue3 a = primitive_ $ \s -> prefetchValue3# a s
