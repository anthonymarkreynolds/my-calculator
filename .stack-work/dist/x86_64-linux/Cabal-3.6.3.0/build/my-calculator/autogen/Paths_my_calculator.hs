{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_my_calculator (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/anthony/Repos/haskell-projects/my-calculator/.stack-work/install/x86_64-linux/4f39758d1da1ff3408988f8d4806918e9cb1eb0a2cb3c2433f4448a64bb93569/9.2.5/bin"
libdir     = "/home/anthony/Repos/haskell-projects/my-calculator/.stack-work/install/x86_64-linux/4f39758d1da1ff3408988f8d4806918e9cb1eb0a2cb3c2433f4448a64bb93569/9.2.5/lib/x86_64-linux-ghc-9.2.5/my-calculator-0.1.0.0-5oqkYf6AvlY8NfCBndNZve-my-calculator"
dynlibdir  = "/home/anthony/Repos/haskell-projects/my-calculator/.stack-work/install/x86_64-linux/4f39758d1da1ff3408988f8d4806918e9cb1eb0a2cb3c2433f4448a64bb93569/9.2.5/lib/x86_64-linux-ghc-9.2.5"
datadir    = "/home/anthony/Repos/haskell-projects/my-calculator/.stack-work/install/x86_64-linux/4f39758d1da1ff3408988f8d4806918e9cb1eb0a2cb3c2433f4448a64bb93569/9.2.5/share/x86_64-linux-ghc-9.2.5/my-calculator-0.1.0.0"
libexecdir = "/home/anthony/Repos/haskell-projects/my-calculator/.stack-work/install/x86_64-linux/4f39758d1da1ff3408988f8d4806918e9cb1eb0a2cb3c2433f4448a64bb93569/9.2.5/libexec/x86_64-linux-ghc-9.2.5/my-calculator-0.1.0.0"
sysconfdir = "/home/anthony/Repos/haskell-projects/my-calculator/.stack-work/install/x86_64-linux/4f39758d1da1ff3408988f8d4806918e9cb1eb0a2cb3c2433f4448a64bb93569/9.2.5/etc"

getBinDir     = catchIO (getEnv "my_calculator_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "my_calculator_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "my_calculator_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "my_calculator_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "my_calculator_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "my_calculator_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
