{-# LANGUAGE ForeignFunctionInterface #-}

module Library where

import Foreign.C.String (CString, peekCString)
import Foreign.C.Types ()

foreign export ccall
  printString :: CString -> IO ()

printString :: CString -> IO ()
printString cString = do
  string <- peekCString cString
  result <- internalPrintString string
  return ()

internalPrintString :: String -> IO ()
internalPrintString string = do
  putStrLn $ "Hello " ++ string
