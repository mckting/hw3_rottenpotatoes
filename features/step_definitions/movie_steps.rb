# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end

  
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  myarr = rating_list.split(",")
  myarr.each do |myrating|
        if uncheck == ""
  	  check("ratings_" + myrating)
        elsif uncheck == "un" 
  	  uncheck("ratings_" + myrating)
        end
        #@all_ratings = Movie.all_ratings
        #@selected_ratings = params[:ratings] || session[:ratings] || {}
  end
end

Then /^I should see all of the movies$/ do
	startpos = page.body.index('table id="movies"') 
	endpos   = page.body.index('/table') 
	mystr = page.body[startpos, endpos+5]	
        mycount = mystr.scan(/<tr>/).count - 1
	
        if mycount.respond_to? :should
    	   mycount.should == Movie.count
  	else
	   assert_equal Movie.count, mycount
 	end
end

	
	
 


