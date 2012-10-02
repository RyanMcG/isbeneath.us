class BeneathApp < Sinatra::Base
  register Sinatra::Subdomain
  set :haml, format: :html5

  IMG_DIR = "http://dl.dropbox.com/u/1378350/ibu-images/"
  CANONICAL_NAME = 'isbeneath.us'
  SUBS = {
    avatar: {
      tag: "MLP > Avatar",
      img: IMG_DIR + 'mlp.jpg'
    },
    mlp: {
        tag: "Avatar > MLP",
        img: 'http://www.adventuresinpoortaste.com/wp-content/uploads/2012/02/avatarheader.jpg'
    }
  }

  def worser(worst)
    @worst = worst
    sub = SUBS[worst.to_sym]
    if sub.nil?
      not_found { "We're sorry, but that sub does not exist." }
    else
      # The tag line is HTML escaped in the view.
      @tag_line = sub[:tag]
      @img_url = URI.encode(sub[:img])
      haml :index
    end
  end

  def random_worser
    SUBS.keys[rand(SUBS.size)]
  end

  def redirect_to_sub(worst)
    if BeneathApp.production?
      redirect "http://#{worst}.#{CANONICAL_NAME}/"
    else
      redirect to("/worser/#{worst}")
    end
  end

  subdomain do
    get "/" do
      self.worser(subdomain)
    end
  end

  get "/worser/:worst" do
    worst = params[:worst]
    if BeneathApp.production?
      redirect_to_sub worst
    else
      self.worser(worst)
    end
  end

  get "/" do
    redirect_to_sub random_worser
  end
end
