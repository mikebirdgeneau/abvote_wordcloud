getTweets<-function(keyword="#yyc",n=200, exclude.words = c("http"))
{
  require(twitteR)
  require(RCurl)
  require(RJSONIO)
  require(stringr)
  require(tm)
  require(wordcloud)
  
  options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
  
  source("secrets.R")
  suppressMessages(setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret))
  
  db_key = "f374549557850096769c0c9982de1006"
  
  ####################################################################
  
  clean.text <- function(some_txt)
  {
    some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
    some_txt = gsub("@\\w+", "", some_txt)
    some_txt = gsub("[[:punct:]]", "", some_txt)
    some_txt = gsub("[[:digit:]]", "", some_txt)
    some_txt = gsub("http\\w+", "", some_txt)
    some_txt = gsub("[ \t]{2,}", " ", some_txt)
    some_txt = gsub("^\\s+|\\s+$", " ", some_txt)
    some_txt = gsub("amp", " ", some_txt)
    # define "tolower error handling" function
    try.tolower = function(x)
    {
      y = NA
      try_error = tryCatch(tolower(x), error=function(e) e)
      if (!inherits(try_error, "error"))
        y = tolower(x)
      return(y)
    }
    
    some_txt = sapply(some_txt, try.tolower)
    some_txt = some_txt[some_txt != ""]
    names(some_txt) = NULL
    return(some_txt)
  }
  
  
  
  ###########################################################
  
  
  
  print("Getting tweets...")
  # get some tweets
  tweets = searchTwitter(keyword, n, lang="en")
  # get text 
  tweet_txt = sapply(tweets, function(x) x$getText())
  
  # clean text
  tweet_clean = clean.text(tweet_txt)
  # data frame (text, sentiment)
  tweet_clean = removeWords(tweet_clean, c(stopwords("english"),"http"))
  tweet_clean = removeWords(tweet_clean, exclude.words)
  tweet_df = data.frame(text=tweet_clean,stringsAsFactors=FALSE)
  
  
  
  corpus = Corpus(VectorSource(tweet_df))
  tdm = TermDocumentMatrix(corpus)
  tdm = as.matrix(tdm)
  
  m <- as.matrix(tdm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  return(d)
}
