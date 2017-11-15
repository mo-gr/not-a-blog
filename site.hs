--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.List             (isSuffixOf, find)
import           Data.Maybe            (isJust)
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

    tags <- buildTags "posts/*" (fromCapture "tags/*/index.html")

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
            >>= loadAndApplyTemplate "templates/post.html"    (postCtxWithTags tags)
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" (postCtxWithTags tags)
            >>= relativizeUrls
            >>= cleanIndexUrls

    match "tags/*" $ do
        route cleanRoute
        tagsRules tags $ \tag pattern -> do
          let title = "Posts tagged " ++ tag
          route idRoute
          compile $ do
              posts <- recentFirst =<< loadAll pattern
              let ctx = constField "title" title
                        `mappend` listField "posts" postCtx (return posts)
                        `mappend` defaultContext
              makeItem ""
                  >>= loadAndApplyTemplate "templates/tag.html" ctx
                  >>= loadAndApplyTemplate "templates/default.html" ctx
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
            skipFirst <- return $ (drop 1) posts
            firstPost <- fmap (take 1) . recentFirst =<< loadAllSnapshots "posts/*" "content"

            let indexCtx =
                    listField "posts" postCtx (return skipFirst) `mappend`
                    constField "title" "Welcome to yet another pointless blog" `mappend`
                    listField "firstPost" postCtx (return firstPost) `mappend`
                    --(bodyField . itemBody) firstPost `mappend`
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

postCtxWithTags :: Tags -> Context String
postCtxWithTags tags = hasTagsField `mappend` tagsField "tags" tags `mappend` postCtx
  where
    hasTagsField = boolField "hasTags" $ \(Item itemId body') -> isJust . find (elem itemId) $ snd <$> tagsMap tags

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
