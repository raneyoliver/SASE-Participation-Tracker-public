Given ('There is a string we need to returning') do
    @cukes = "Cukes are running"
end

Then('Cucumber will return the string') do
    puts @cukes
end