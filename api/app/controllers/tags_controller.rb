class TagsController < ApplicationController

  DATABASE = "http://localhost:5984"


  ##
  # Return data in mixare format to display on app 
  ##
  def indexs


    #application/mixare-json 

  	slat = params[:slat]
  	slon = params[:slon]
  	elat = params[:elat]
  	elon = params[:elon]

  	# /hgt/_design/hgt/_view/tags?startkey=[-27,27]\&endkey=[-25,28]
    #uri = "#{DATABASE}/hgt/_design/hgt/_view/tags?startkey=[#{slat},#{slon}]&endkey=[#{elat},#{elon}]"
    uri = "#{DATABASE}/hgt/_design/hgt/_view/tags"

   request = RestClient.get uri

   request = Yajl::Parser.parse(request)

   puts request.inspect

   response = {}
   response[:results] = []

   request["rows"].each do |row|

    title = row["value"]["kind"] == "recommendation" ? "Go There - " : "Don't Go There - "
    title = "#{title}#{row['value']['description']}"

    response[:results] << {
      id: row["id"],
      lat: row["value"]["lat"].to_s,
      lng: row["value"]["lon"].to_s,
      elevation: "0.0",
      title: title,
      distance: "1",
      has_detail_page: "0",
      webpage: ""
    }
   end
   response[:status] = "OK"
   response[:num_results] = response[:results].length
   render json: response, :content_type => 'application/mixare-json'
  end




  ################--------------------------------------------------


#   geonames: [
# {
# summary: "Carlswald is a suburb of Johannesburg, South Africa. It is located in Region 2.",
# distance: "1.3064",
# rank: 5,
# title: "Carlswald, Gauteng",
# wikipediaUrl: "en.wikipedia.org/wiki/Carlswald%2C_Gauteng",
# elevation: 1520,
# lng: 28.103611111111114,
# lang: "en",
# lat: -25.982777777777777
# },
# {
# summary: "Vorna Valley is a suburb of Johannesburg, South Africa. It is located in Region 2.",
# distance: "1.9162",
# rank: 13,
# title: "Vorna Valley, Gauteng",
# wikipediaUrl: "en.wikipedia.org/wiki/Vorna_Valley%2C_Gauteng",
# elevation: 1505,
# countryCode: "ZA",
# lng: 28.10722,
# feature: "city",
# lang: "en",
# lat: -25.99833
# },




end
