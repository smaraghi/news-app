class ArticlesController < ApplicationController
  
  
  require 'open-uri'

  URL1 = "https://newsapi.org/v2/top-headlines?country=us&category="
  URL2 = "&pageSize=21&apiKey="

  KEY = Rails.application.credentials.apikeys[:news_api_key]

  def get_fetch()
    fetch(URL1 + params[:category] + URL2 + KEY) 
  end

  def create
    @article = Article.find_or_create_by(title: params[:article][:title]) do |article|
      article.author = params[:article][:author] 
      article.description = params[:article][:description]
      article.url = params[:article][:url]
      article.image = params[:article][:urlToImage]
      article.date = params[:article][:publishedAt]
      article.likes = 0
      article.dislikes = 0
    end
    @article.likes += 1
    @article.save
    render json: @article 
  end 

  def get_likes
    @article = Article.find_by(title: params[:article][:title])
    if @article
      like_obj = { likes: @article.likes, dislikes: @article.dislikes }
    else
      like_obj = { likes: 0, dislikes: 0 }
    end
    render json: like_obj
  end

  private

  def fetch(url)
    req = open(url)
    body = req.read
    render json: body 
  end
end
