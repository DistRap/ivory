{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}


-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module Heartbeat where

import           Ivory.Language
import           Ivory.Serialize

heartbeatMsgId :: Uint8
heartbeatMsgId = 0

heartbeatCrcExtra :: Uint8
heartbeatCrcExtra = 50

heartbeatModule :: Module
heartbeatModule = package "mavlink_heartbeat_msg" $ do
  depend serializeModule
  defStruct (Proxy :: Proxy "heartbeat_msg")
  wrappedPackMod heartbeatWrapper
  incl packUnpack

[ivory|
struct heartbeat_msg
  { custom_mode :: Stored Uint32
  ; mavtype :: Stored Uint8
  ; autopilot :: Stored Uint8
  ; base_mode :: Stored Uint8
  ; system_status :: Stored Uint8
  ; mavlink_version :: Stored Uint8
  }
|]

heartbeatWrapper :: WrappedPackRep ('Struct "heartbeat_msg")
heartbeatWrapper = wrapPackRep "mavlink_heartbeat" $ packStruct
  [ packLabel custom_mode
  , packLabel mavtype
  , packLabel autopilot
  , packLabel base_mode
  , packLabel system_status
  , packLabel mavlink_version
  ]

packUnpack :: Def ('[Ref s1 ('Struct "heartbeat_msg")] :-> ())
packUnpack = proc "heartbeat_pack_unpack" $ \ msg -> body $ do
  let rep = wrappedPackRep heartbeatWrapper
  buf <- local (iarray [] :: Init ('Array 9 ('Stored Uint8)))
  packInto' rep buf 0 (constRef msg)
  msg' <- local (istruct [] :: Init ('Struct "heartbeat_msg"))
  unpackFrom' rep (constRef buf) 0 msg'
  let same :: (IvoryStore a, IvoryEq a) => Label "heartbeat_msg" ('Stored a) -> Ivory eff ()
      same label = do
        v1 <- deref (msg ~> label)
        v2 <- deref (msg' ~> label)
        assert $ v1 ==? v2
  same custom_mode
  same mavtype
  same autopilot
  same base_mode
  same system_status
  same mavlink_version
