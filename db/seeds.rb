# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#This will be our master user
User.create(username: "RoRSnippet",
            first_name: "RoR",
            last_name: "Snippet",
            email: "ror@rorsnippet.com",
            password: "rorsnippet",
            avatar: Faker::Avatar.image
                 )

10.times do
   User.create(username: Faker::Internet.user_name,
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               email: Faker::Internet.email,
               password: Faker::Internet.password(8),
               avatar: Faker::Avatar.image
                    )
end

# First Snippet
  @masteruser = User.find_by(email: "ror@rorsnippet.com")
    @masteruser.snippets.create(snippet_title: 'Figure out shopify shop status',
    snippet_description: 'Figure out shopify shop status',
    snippet_content: 'begin
  ShopifyAPI::Shop.current
rescue ActiveResource::ResourceNotFound
  Rails.logger.info "Shop #{shop.id} (#{shop.subdomain}) appears to have gone bye bye"
  shop.destroy
rescue ActiveResource::UnauthorizedAccess => e
  Rails.logger.info "Shop #{shop.id} (#{shop.subdomain}) does not authorize us"
rescue ActiveResource::ForbiddenAccess => e
  Rails.logger.info "Shop #{shop.id} (#{shop.subdomain}) is a forbidden garden"
rescue ActiveResource::Redirection
  Rails.logger.info "Shop #{shop.id} (#{shop.subdomain}) bounced us"
end')

#Second snippets

  @masteruser.snippets.create(snippet_title: 'Convert Seconds to Human Readable time (up to days)',
  snippet_description: 'Pass in seconds and get back the amount of time in human readable format! ie: puts Utils.secondstostring(129) :=> 2 minutes, 9 seconds',
  snippet_content: 'class Utils

  def self.seconds_to_string(s)

    # d = days, h = hours, m = minutes, s = seconds
    m = (s / 60).floor
    s = s % 60
    h = (m / 60).floor
    m = m % 60
    d = (h / 24).floor
    h = h % 24

    output = "#{s} second#{Utils.pluralize(s)}" if (s > 0)
    output = "#{m} minute#{Utils.pluralize(m)}, #{s} second#{Utils.pluralize(s)}" if (m > 0)
    output = "#{h} hour#{Utils.pluralize(h)}, #{m} minute#{Utils.pluralize(m)}, #{s} second#{Utils.pluralize(s)}" if (h > 0)
    output = "#{d} day#{Utils.pluralize(d)}, #{h} hour#{Utils.pluralize(h)}, #{m} minute#{Utils.pluralize(m)}, #{s} second#{Utils.pluralize(s)}" if (d > 0)

    return output
  end

  def self.pluralize number
    return "s" unless number == 1
    return ""
  end

end')

  @masteruser.snippets.create(snippet_title: 'Get string between two character',
  snippet_description: "If you're using Rails and want to make this a global function, drop this into your application_controller and call it as a function.

Example: # getstringbetween('hellomyfriendmoto', 'o', 'm') # > myfriend",
  snippet_content: 'def get_string_between(my_string, start_at, end_at)
    my_string = " #{my_string}"
    ini = my_string.index(start_at)
    return my_string if ini == 0
    ini += start_at.length
    length = my_string.index(end_at, ini).to_i - ini
    my_string[ini,length]
end')

  @masteruser.snippets.create(snippet_title: 'Ruby: Search Spotify API',
  snippet_description: "URL: http://developer.spotify.com/en/metadata-api/overview/

Simple test showing how to make a request to Spotify's API.",
  snippet_content: '=begin
http://developer.spotify.com/en/metadata-api/overview/

Requests: http://ws.spotify.com/service/version/method[.format]?parameters

http://ws.spotify.com/search/1/track.json?q=kaizers+orchestra

Track Lookup
http://ws.spotify.com/lookup/1/.json?uri=spotify:track:6NmXV4o6bmp704aPGyTVVG

Artist lookup
http://ws.spotify.com/lookup/1/.json?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ
http://ws.spotify.com/lookup/1/.json?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ&extras=album
http://ws.spotify.com/lookup/1/.json?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ&extras=albumdetail

Album lookup
http://ws.spotify.com/lookup/1/.json?uri=spotify:album:6G9fHYDCoyEErUkHrFYfs4
http://ws.spotify.com/lookup/1/.json?uri=spotify:album:6G9fHYDCoyEErUkHrFYfs4&extras=track
http://ws.spotify.com/lookup/1/.json?uri=spotify:album:6G9fHYDCoyEErUkHrFYfs4&extras=trackdetail

Search Example
http://ws.spotify.com/search/1/artist?q=Bj%C3%B6rk.

=end

class SpotifyAPIRequest
  require "open-uri"

  def initialize

  end

  def lookup( keyword )
    open("http://ws.spotify.com/search/1/track.json?q=" + keyword){
      |f|
      #Get the Full response which should be the full HTML
      @req = f.read
      #Find the first place where "No match is found", if nothing is found, it will return "nil"
      puts @req

=begin
      @txt = @req.index("No match")
      puts @txt

      if @txt.nil?
        puts "Domain " + word + ".com is available"
      else
        puts "Domain " + word + ".com is taken"
      end
=end
    }
  end
end

spotify = SpotifyAPIRequest.new
spotify.lookup("beethoven")')

  @masteruser.snippets.create(snippet_title: 'Rescuing From RecordNotUnique error',
  snippet_description: "Use rescue_from ActiveRecord::RecordNotUnique when DB transaction fail on uniqueness check",
  snippet_content: 'rescue_from ActiveRecord::RecordNotUnique, :with => :my_rescue_method
....
protected
 def my_rescue_method
   ...
 end')

@otheruser = User.find_by(id: 2)
 @otheruser.snippets.create(snippet_title: 'Validate a Credit Card Number',
 snippet_description: "Download the Credit Card Library from Lucas Carlson user$ sudo gem install creditcard",
 snippet_content: "#Checksum Digit, there is an algorithm that checksum must match
#A. Import the libraries
require 'rubygems'
require 'creditcard'

#B. Boolean test as to whether this number is a valid credit card
puts '5276 4400 6542 1319'.creditcard?

#C. Check the type of credit card it is
puts '5276 4400 6542 1319'.creditcard_type")

@otheruser.snippets.create(snippet_title: 'Display Image in Link_to',
snippet_description: "Displays a image inside link_to instead of text.",
snippet_content: '<%= link_to image_tag("search.gif", :border=>0), :action => "show", :id => user %>')
