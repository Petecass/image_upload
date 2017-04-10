class App
  helpers do
    def json_error(code, reason)
      status code
      {
        errors: reason,
        status: code
      }.to_json
    end
  end

  before do
    content_type 'application/json'
  end

  # Index
  get '/images' do
    status 200
    Image.all.to_json
  end

  # Show
  get '/images/:id' do
    if (image = Image.find_by(id: params[:id]))
      image.to_json
    else
      json_error 404, 'That Image doesn\'t exist'
    end
  end

  # Create
  post '/images' do
    data = JSON.parse(request.body.read)
    image = Image.new(data['image'])
    if image.save
      status 201
      image.to_json
    else
      json_error 422, image.errors.full_messages.join(',')
    end
  end

  # Update
  put '/images/:id' do
    image = Image.find_by(id: params[:id])
    halt 404 if image.nil?

    data = JSON.parse(request.body.read)
    if image.update(data['image'])
      status 200
      image.to_json
    else
      json_error 422, image.errors.full_messages.join(',')
    end
  end

  # Destroy
  delete '/images/:id' do
    Image.destroy(params[:id])
    status 204
  end

  # Search
  get '/search/?:tag?' do
    if params[:tag]
      Image.tagged_with(params[:tag]).to_json
    else
      Image.all.to_json
    end
  end

  # misc handlers: error, etc.
  get '*' do
    status 404
  end

  post '*' do
    status 404
  end

  put '*' do
    status 404
  end

  delete '*' do
    status 404
  end

  error do
    json_error 500, env['sinatra.error'].message
  end
end
