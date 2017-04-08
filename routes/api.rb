class App

  before do
    content_type 'application/json'
  end

  get '/' do
    'Hello World'
  end
end
