class BeneathApp < Sinatra::Base
  register Sinatra::Subdomain
  set :haml, format: :html5

  def initialize
    Mongoid.load!("mongoid.yml", BeneathApp.environment)
  end

  def worser(worst)
    "#{worst} is the worst."
  end

  def random_worser
    "derp"
  end

  get "/worsers/:worst" do
    self.worser(params[:worst])
  end

  def redirect_to_sub(worst)
    if BeneathApp.production?
      redirect "http://#{worst}.isbeneath.us/"
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
