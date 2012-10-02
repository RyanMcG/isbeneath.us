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

  get "/" do
    self.worser(random_worser)
  end

  subdomain do
    get "/" do
      self.worser(subdomain)
    end
  end
end
