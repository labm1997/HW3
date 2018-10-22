Given(/^the following movies exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |row|
    Movie.new(:title => row[:title], :rating => row[:rating], :release_date => row[:release_date]).save
  end
end

Given(/^I check all ratings$/) do
  @all_ratings = Movie.all_ratings
  @all_ratings.each do |rating|
    page.check("ratings[#{rating}]")
  end
end

Given(/^I (uncheck|check) the following ratings: ([\w, -]*)$/) do |funct,string|
  string.gsub(" ", "").split(",").each do |rating|
    page.send(funct, "ratings[#{rating}]")
  end
end

Then(/^I should see all of the movies$/) do
  Movie.all.each do |movie|
    expect(page).to have_content movie[:title]
  end
end

Then(/^I should see "([^"]*)" before "([^"]*)"$/) do |arg1, arg2|
  if page.body.index(arg1) >= page.body.index(arg2)
    assert false
  end
end
