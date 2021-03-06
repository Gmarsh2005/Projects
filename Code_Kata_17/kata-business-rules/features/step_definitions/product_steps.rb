When /^I order (\d+) "([^"]*)"/ do |qty, item|
  @items ||= []
  @items << [qty, item]
end

Then /^I should see a packing slip:/ do |slip|

  input =
    @items.map do |pair|
      '%s;%s' % pair
    end.join("\n")

  create_file("input.txt", input)

  run "ruby ../../runner.rb"

  regexp = Regexp.escape(slip)
  combined_output.chomp.should match(/#{regexp}/m)
end

When /^I order a copy of "([^"]*)"$/ do |book|
  @items ||= []
  @items << [1, book]
end


Then /^the packing slip should be sent to the royalty department$/ do
  combined_output.should =~ /A copy of the packing slip was sent to the royalty department/
end

When /^I purchase a membership$/ do
  @items ||= []
  @items << [1, "Membership"]
end

Then /^my membership should be activated$/ do
  combined_output.should =~ /Your membership has been activated/
end

When /^I upgrade my membership$/ do
  @items ||= []
  @items << [1, "Upgrade Member"]
end

Then /^my membership should be upgraded$/ do
  combined_output.should =~ /Your membership has been upgraded/
end

Then /^the sales agent should receive a commission payment$/ do
  combined_output.should =~ /The sales agent has received a commission payment/
end


