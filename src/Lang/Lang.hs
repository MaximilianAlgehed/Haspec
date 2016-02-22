{-# LANGUAGE GADTs, DataKinds, KindSignatures #-}
import Data.Map.Strict (Map)

data Protocol = Protocol
    { pEndpoints :: [Endpoint]
    , pVersion   :: String
    }

data Endpoint = Endpoint
    { eUrl           :: String
    , eTransmissions :: Map Method Transmission
    }

data Method = GET | POST | OPTIONS | HEAD | PUT | DELETE

-- | A Transmission is a bundle consisting of a request and a response.
data Transmission = Transmission
    { tRequest  :: Request
    , tResponse :: Response
    }

data Request = Request
    { rqFields :: [Field]
    }

data Response = Response
    { reFields :: [Field]
    }

data Field = Field
    { fName        :: String
    , fLabel       :: String
    , fDescription :: String
    , fType        :: FieldType
    , fValidators  :: [Validator]
    }

data FieldType = FTInt
               | FTString
               | FTBool
               | FTDouble
               | FTList FieldType
               | FTMap FieldType FieldType -- I'm not sure about this one. We'll see if it's needed.

-- | The validator type, I'm not at all sure about if this is a good idea.
data Validator = Required Bool             -- ^ Is this field required? True by default.
               | NullAllowed Bool          -- ^ Do we get away with not supplying this field? False by default.
               | LowerBound Int            -- ^ Lower bound in length for strings and lists, and by value for numbers.
               | UpperBound Int            -- ^ Upper bound in length for strings and lists, and by value for numbers.
               | Chain Validator Validator -- ^ Combine two validators, both must pass for this validator to pass.

-- | Datakind for token validity
data Token where
    ValidToken   :: Token
    InvalidToken :: Token
    deriving Show

-- | Side effects that we can get from tokens
data TokenSideEffect :: Token -> * where
    Produce :: TokenSideEffect ValidToken
    Require :: TokenSideEffect ValidToken
    Consume :: TokenSideEffect InvalidToken

login :: TokenSideEffect ValidToken
login = Produce

updateUsername :: String -> TokenSideEffect ValidToken -> TokenSideEffect ValidToken
updateUsername = undefined

logout :: TokenSideEffect ValidToken -> TokenSideEffect InvalidToken
logout = const Consume

transaction = logout $ updateUsername "Bob" login
