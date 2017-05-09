{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Network.Wai.Middleware.Static
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Text

import qualified Views.List as L
blaze = html . renderHtml

main = do
  scotty 3000 $ do
    middleware $ staticPolicy (noDots >-> addBase "static")

    get "/" $ do
      html "Hello there!"

    put "/" $ do
      text "put was called"

    post "/" $ do
      text "posting!"

    delete "/" $ do
      text "Are you sure?"

    get "/hello" $ do
      name <- param "name"
      text name

    get "/pet/:name" $ do
      word <- param "name"
      html $ mconcat ["<h1>Scotty's pet is called ", word, "</h1>"]

    get "/list" $ do
      blaze L.render

    get "/index" $ do
      file "/Users/AKA/Development/Haskell/haskell-scotty/src/static/index.html"
