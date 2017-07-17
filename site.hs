--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.List             (isSuffixOf)
import           Data.Monoid           (mappend)
import           Hakyll
import           System.FilePath.Posix (takeBaseName, takeDirectory, (</>))


--------------------------------------------------------------------------------

feedConfiguration :: FeedConfiguration
feedConfiguration = FeedConfiguration
    { feedTitle       = "Not a blog"
    , feedDescription = "Yet another pointless personal blog"
    , feedAuthorName  = "Moritz Grauel"
    , feedAuthorEmail = "mo@notadomain.com"
    , feedRoot        = "http://blog.notadomain.com"
    }

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["CNAME", "404.html", "robots.txt"]) $ do
        route   idRoute
        compile copyFileCompiler

    match (fromList ["about.markdown", "impressum.markdown"]) $ do
        route cleanRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls
            >>= cleanIndexUrls

    match "posts/*" $ do
        route cleanRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls
            >>= cleanIndexUrls

    create ["archive.html"] $ do
        route cleanRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls
                >>= cleanIndexUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- fmap (take 5) . recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Welcome to yet another pointless blog" `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls
                >>= cleanIndexUrls

    match "templates/*" $ compile templateBodyCompiler

    create ["atom.xml"] $ do
      route idRoute
      compile $ do
          let feedCtx = postCtx `mappend` bodyField "description"
          posts <- fmap (take 20) . recentFirst =<<
              loadAllSnapshots "posts/*" "content"
          renderAtom feedConfiguration feedCtx posts


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

cleanRoute :: Routes
cleanRoute = customRoute createIndexRoute
  where
    createIndexRoute ident = takeDirectory p </> takeBaseName p </> "index.html"
                            where p = toFilePath ident

cleanIndexUrls :: Item String -> Compiler (Item String)
cleanIndexUrls = return . fmap (withUrls cleanIndex)

cleanIndex :: String -> String
cleanIndex url
    | idx `isSuffixOf` url = take (length url - length idx) url
    | otherwise            = url
  where idx = "index.html"
