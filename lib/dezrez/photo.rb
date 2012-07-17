require 'open-uri'
require 'cgi'
require 'mechanize'

class Photo
  attr_accessor :remote_url, :filename

  def initialize(args = {})
    args.each do |k,v|
      instance_variable_set("@#{k}", v)
    end
  end

  def download (download_directory)
    uri = URI.parse(@remote_url)
    uri_params = CGI.parse(uri.query)
    @filename = File.join(download_directory, "#{uri_params["PropertyID"][0]}.#{uri_params["photoID"][0]}.jpg")
		begin
			#image = open(@filename , "wb")
    	puts "Fetching photo fom #{@remote_url}"
			puts "Saving photo to #{@filename}"
			Mechanize.new.get(@remote_url + "&width=300").save(@filename)
		  #image.write(open(@remote_url + "&width=300").read)
    	#image.close
    rescue
			puts "Unable to download the photo located at #{@remote_url + "&width=300"}"
		end
		self
  end

end
