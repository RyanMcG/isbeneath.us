class BeneathApp < Sinatra::Base
  register Sinatra::Subdomain

  def worser(worst)
    "#{worst} is the worst."
  end

  def random_worser
    "derp"
  end

  get "/worsers/:worst" do
    self.worser(params[:worst])
  end

  get "/" do
    self.worser(random_worser)
  end

  subdomain do
    get "/" do
      self.worser(subdomain)
    end
  end
end
