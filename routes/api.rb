class App

  before do
    content_type 'application/json'
  end

  get '/images' do
    status 200
    Image.all.to_json
  end

  get '/images/:id' do
    if (image = Image.find_by(id: params[:id]))
      image.to_json
    else
      status 404
      { errors: 'That Image doesn\'t exist' }.to_json
    end
  end

  post '/images' do
    image = Image.new(params[:image])
    if image.save
      status 201
      image.to_json
    else
      status 422
      { errors: image.errors.full_messages.join(',') }.to_json
    end
  end

  put '/images/:id' do
    image = Image.find_by(id: params[:id])
    halt 404 if image.nil?

    if image.update(params[:image])
      status 200
      image.to_json
    else
      status 422
      { errors: image.errors.full_messages.join(',') }.to_json
    end
  end

  delete '/images/:id' do
    Image.destroy(params[:id])
    status 204
  end
end
