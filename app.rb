require 'sinatra'
require 'sendgrid-ruby'

include SendGrid

get '/' do
    erb :index
end

# get '/responses' do
#     puts ENV[SENDGRID_API_KEY]
#     erb :responses   
# end

post '/contact' do

    @email = params[:email]
    @opinion = params[:opinion]

    from = Email.new(email: @email)
    to = Email.new(email: 'azhar.mashal@gmail.com')
    subject = 'This is my opinion on the election'
    content = Content.new(type: 'text/plain', value: @opinion)
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    # puts "EVERYTING UNDER ME IS THE RESPONSE"
    puts response.status_code
    # puts response.body
    # # puts response.parsed_body
    # puts response.headers

    erb :contact
end 

# post ‘/contact’ do
# end 