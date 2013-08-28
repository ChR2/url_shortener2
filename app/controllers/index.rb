get '/' do
  # let user create new short URL, display a list of shortened URLs
  @short_urls = Url.last(10)
  erb :index
end

post '/urls' do
  @long_url = params[:long_url]
  puts @long_url
  if Url.url_valid?(@long_url)
    @new_url = Url.new(:long_url => @long_url)
    @new_url.save
    @short_urls = Url.last(10)
    erb :index
  else
    @error_message = "This is not a valid URL"
    @short_urls = Url.last(10)
    erb :index
  end
end

get '/:short_url' do
  short_url = params[:short_url]
  url_obj = Url.where(:short_url => short_url).first
  redirect to(url_obj.long_url)
end
