require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe 'My Sinatra Application' do
  it 'returns hello world' do
    get '/'
    expect(last_response.body).to eq 'Hello World'
    expect(last_response.content_type).to eq 'application/json'
    expect(last_response.status).to eq 200
  end
end
