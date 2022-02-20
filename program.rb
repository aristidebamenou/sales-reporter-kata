# frozen_string_literal: true
require 'byebug'
require 'date'

class Program
  # lots of comments!
  def main(*args)
    # add a title to our app
    output = "=== Sales Viewer ===\n"
    # extract the command name from the args
    command = args.length.positive? ? args[0] : 'unknown'
    file = args.length >= 2 ? args[1] : './data.csv'
    # read content of our data file
    # [2012-10-30] rui : actually it only works with this file, maybe it's a good idea to pass file //name as parameter
    # to this app later?
    data_content_string = File.readlines(file)
    # if command is print
    if command == 'print'
      # get the header line
      line1 = data_content_string[0]
      # get other content lines
      other_lines = data_content_string[1..]
      column_infos = []
      # build the header of the table with column names from our data file
      i = 0

      line1.split(',').each do |column_name|
        column_infos << { index: i + 1, size: column_name.length, name: column_name }
      end

      header_string = column_infos.map { |x| x[:name].gsub("\n", '').rjust(16) }.join(' | ')
      output += <<~END
      +#{Array.new(header_string.length + 2, '-').join('')}+
      | #{header_string} |
      +#{Array.new(header_string.length + 2, '-').join('')}+
      END
      # then add each line to the table
      other_lines.each do |line|
        # extract columns from our csv line and add all these cells to the line
        cells = line.split(',')
        table_line = line.gsub("\n", '').split(',').map { |x| x.rjust(16) }.join(' | ')
        output += "| #{table_line} |\n"
      end
      output += "+#{Array.new(header_string.length + 2, '-').join('')}+\n"
      # if command is report
    elsif command == "report"
      # get all the lines without the header in the first line
      other_lines = data_content_string[1..]
      # declare variables for our conters
      number1 = 0
      number2 = 0
      number4 = 0.0
      number5 = 0.0
      number3 = 0
      clients = Hash.new
      last = DateTime.new
      # do the counts for each line
      other_lines.each do |line|
        cells = line.split(',')
        number1 += 1 # increment the total of sales
        # to count the number of clients, we put only distinct names in a hashset //then we'll count the number of entries if (!clients.Contains(cells[1])) clients.Add(cells[1]);
	 			number2 += cells[2].to_i # we sum the total of items sold here
	 			number3 += cells[3].to_f # we sum the amount of each sell
        # we compare the current cell date with the stored one and pick the higher last = DateTime.Parse(cells[4]) > last ? DateTime.Parse(cells[4]) : last
      end
      # we compute the average basket amount per sale
      number4 = (number3 / number1).round(2)
      # we compute the average item price sold
      number5 = (number3 / number2).round(2)
      output += "+#{Array.new(45, '-').join('')}+\n"
      output += "| #{'Number of sales'.rjust(30)} | #{number1.to_s.rjust(10)} |\n"
      output += "| #{'Number of clients'.rjust(30)} | #{clients.length.to_s.rjust(10)} |\n"
      output += "| #{'Total items sold'.rjust(30)} | #{number2.to_s.rjust(10)} |\n"
      output += "| #{'Total sales amount'.rjust(30)} | #{number3.round(2).to_s.rjust(10)} |\n"
      output += "| #{'Average amount/sale'.rjust(30)} | #{number4.to_s.rjust(10)} |\n"
      output += "| #{'Average item price'.rjust(30)} | #{number5.to_s.rjust(10)} |\n"
      output += "+#{Array.new(45, '-').join('')}+\n"
    else
      output += "[ERR] your command is not valid\n"
      output += "Help: \n"
      output += "    - [print]  : show the content of our commerce records in data.csv\n"
      output += "    - [report] : show a summary from data.csv records\n"
    end
    puts output
    output
  end
end
