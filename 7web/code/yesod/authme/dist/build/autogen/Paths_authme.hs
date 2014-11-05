module Paths_authme (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/Users/jack/.cabal/bin"
libdir     = "/Users/jack/.cabal/lib/authme-0.0.0/ghc-7.6.3"
datadir    = "/Users/jack/.cabal/share/authme-0.0.0"
libexecdir = "/Users/jack/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "authme_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "authme_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "authme_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "authme_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
