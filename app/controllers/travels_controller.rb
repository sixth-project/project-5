class TravelsController < ApplicationController

  def index
  end

  def search
    country = params[:country]
    currency = params[:currency]
    locale = params[:locale]
    originplace = params[:originplace]
    destinationplace = params[:destinationplace]
    outbounddate = params[:outbounddate]
    url = "#{country}/#{currency}/#{locale}/#{originplace}/#{destinationplace}/#{outbounddate}?inboundpartialdate=2019-12-01"
    tickets = find_ticket(url)
   unless tickets
    flash.now[:alert] = 'ticket not found'
    return render action: :index
   end
   @ticket = tickets
  end

  private

   def find_ticket(url)
    request_api("https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/#{url}")
   end

  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => Rails.application.credentials.rapid[:api_key]
      }
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end
end
