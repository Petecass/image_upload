require File.join(File.dirname(__FILE__), '..', 'spec_helper')

RSpec.describe 'Api functionality', type: :controller do
  describe 'GET /images' do
    before do
      3.times { create(:image) }
      get '/images', format: :json
    end

    it 'returns a json representation of all images' do
      expect(last_response.status).to eq 200
      expect(last_response.content_type).to eq 'application/json'
      expect(json_response.size).to eq 3
    end
  end

  describe 'POST /images' do
    context 'successful creation with tags' do
      let(:image_attributes) { attributes_for(:image, all_tags: 'candid, urban') }

      before do
        post '/images', { image: image_attributes }.to_json, format: :json
      end

      it 'creates the tags' do
        returned_id = json_response[:id]
        expect(Image.find(returned_id).tags.count).to eq 2
      end
    end

    context 'successful creation' do
      let(:file) { File.open(File.join(File.dirname(__FILE__), '..', 'factories', 'test.jpg')) }
      let(:encoded_image) { Base64.encode64(file.read) }
      let(:image_attributes) { attributes_for(:image, image: "data:image/jpg;base64,#{encoded_image}") }

      before do
        post '/images', { image: image_attributes }.to_json, format: :json
      end

      it 'returns a json representation of the image' do
        binding.pry
        returned_id = json_response[:id]
        expect(last_response.body).to eq Image.find(returned_id).to_json
      end

      it 'return 201' do
        expect(last_response.status).to eq 201
      end
    end

    context 'unsuccessful creation' do
      let(:invalid_attributes) { attributes_for(:image, title: nil) }

      before do
        post '/images', { image: invalid_attributes }.to_json, format: :json
      end

      it 'returns a json error' do
        expect(json_response[:errors]).to include('can\'t be blank')
        expect(last_response.status).to eq 422
      end
    end
  end

  describe 'PUT /images/:id' do
    let!(:image) { create(:image) }

    context 'successful update' do
      let(:image_attributes) { attributes_for(:image, title: 'wookie') }

      before do
        put "/images/#{image.id}", { image: image_attributes }.to_json, format: :json
      end

      it 'returns a json representation of the updated image' do
        returned_id = json_response[:id]
        updated_image = Image.find(returned_id)
        expect(json_response[:title]).to eq updated_image.title
        expect(updated_image.title).to eq image_attributes[:title]
      end

      it 'return 200' do
        expect(last_response.status).to eq 200
      end
    end

    context 'unsuccessful update' do
      let(:invalid_attributes) { attributes_for(:image, title: nil) }

      before do
        put "/images/#{image.id}", { image: invalid_attributes }.to_json, format: :json
      end

      it 'returns a json error' do
        expect(json_response[:errors]).to include('can\'t be blank')
        expect(last_response.status).to eq 422
      end
    end

    context 'when image does not exist' do
      it 'returns 404' do
        put '/images/23', nil, format: :json
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'GET /images/:id' do
    context 'when image exists' do
      let!(:image) { create(:image) }
      before do
        get "/images/#{image.id}", format: :json
      end

      it 'returns json representation of image' do
        expect(last_response.body).to eq image.to_json
      end
    end

    context 'when image does not exist' do
      before do
        get '/images/12', format: :json
      end

      it 'returns json errror' do
        expect(last_response.status).to eq 404
        expect(json_response[:errors]).to eq 'That Image doesn\'t exist'
      end
    end
  end

  describe 'Delete /images/:id' do
    let!(:image) { create(:image) }

    before do
      delete "/images/#{image.id}", format: :json
    end

    it 'deletes the record' do
      expect(last_response.status).to eq 204
      expect { Image.find(image.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET /search' do
    before do
      create(:image, all_tags: 'candid')
      create(:image, all_tags: 'urban')
      create(:image, all_tags: 'candid')
    end

    context 'when tag is present' do
      it 'returns an array of matching images' do
        get '/search/candid', format: :json
        expect(json_response.count).to eq 2
        expect(last_response.status).to eq 200
      end
    end

    context 'when tag is not present' do
      it 'returns an array of matching images' do
        get '/search', nil, format: :json
        expect(json_response.count).to eq 3
        expect(last_response.status).to eq 200
      end
    end
  end
end
