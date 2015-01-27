class MoviesController < ApplicationController
  def index
    source = RestClient.get("http://gschool.github.io/student-apis/")
    html_doc = Nokogiri::HTML(source)
    @link_list = html_doc.css('ul').text.split(" ")


    @api_movies = []

    @link_list.each do |link|
      response = RestClient.get(link + '/all')
      movies = JSON.parse(response)

      movies.each do |movie|
        @api_movies << movie
      end
    end
  end
end
