class TagsController < ApplicationController

  DATABASE = "http://localhost:5984"


  ##
  # Return data in mixare format to display on app 
  ##
  def index


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
      lat: row["value"]["lat"].to_f,
      lng: row["value"]["lon"].to_f,
      elevation: 0.0,
      title: title
    }
   end

   response[:status] = "OK"
   response[:num_results] = response[:results].length

    #    "status": "OK",
    # "num_results": 3,

   render json: response, :content_type => 'application/mixare-json'
  end





end
