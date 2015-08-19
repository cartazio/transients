--------------------------------------------------------------------------------
-- |
-- Copyright   : (c) Edward Kmett 2015
-- License     : BSD-style
-- Maintainer  : Edward Kmett <ekmett@gmail.com>
-- Portability : non-portable
--
-- This module suppose a Word64-based array-mapped PATRICIA Trie.
--
-- The most significant nybble is isolated by using techniques based on
-- <https://www.fpcomplete.com/user/edwardk/revisiting-matrix-multiplication/part-4>
-- but modified to work nybble-by-nybble rather than bit-by-bit.
--
-- This structure secretly maintains a finger to the previous mutation to
-- speed access and repeated operations.
--
-- In addition, we support transient access patterns.
--------------------------------------------------------------------------------
module Data.Transient.WordMap
  ( 
  -- Persistent API
    WordMap
  , singleton
  , empty
  , insert
  , delete
  , lookup
  , focus
  , trim

  -- * Conversion
  , Transient
  , freeze
  , thaw
  , modify
  , query

  -- * Transient API
  , singletonM
  , emptyM
  , insertM
  , deleteM
  , lookupM
  , focusM
  , trimM

  -- * Enumeration
  , fromList
  , Exts.toList

  -- * Misc.
  , Key
  ) where

import Data.Transient.Frozen
import Data.Transient.WordMap.Internal
import GHC.Exts as Exts
import Prelude hiding (lookup)
