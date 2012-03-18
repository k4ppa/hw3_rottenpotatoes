# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
  #assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #  assert false, "Unimplmemented"
  re = /#{e1}.*#{e2}/m
  #puts re.inspect
  #puts page.source
  #puts re.match(page.source).inspect
  assert re.match(page.source), "Was expecting to see #{e1} before #{e2}"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(%r{,\s*})
  ratings.each do |rating|
    step %Q{I #{uncheck}check "ratings_#{rating}"}
  end   
end

Then /I should (not )?see all of the movies/ do |notsee|
  Movie.all.each do |movie|
    step %Q{I should see "#{movie.title}"}
  end
end

When /I sort movies by (.*)/ do |sort_by|
  click_link "#{sort_by}_header"
end
