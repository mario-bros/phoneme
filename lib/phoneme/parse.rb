class Parse
  @@mapping = {
    "AI" => 0,
    "E" => 1.001,
    "O" => 2.001,
    "U" => 3.001,
    "etc" => 4.001,
    "WQ" => 5.001,
    "MBP" => 6.001,
    "L" => 7.001,
    "FV" => 8.001,
    "rest" => 9.001 }

  @@header =<<-eos
Adobe After Effects 8.0 Keyframe Data

\tUnits Per Second\t29.97
\tSource Width\t1000
\tSource Height\t1000
\tSource Pixel Aspect Ratio\t1
\tComp Pixel Aspect Ratio\t1

  eos

  @@footer = "\nEnd of Keyframe Data\n"

  def initialize(file)
    f = File.open(file, 'r')
    @input = f.read
    f.close
    @output = @@header
    @input.split(/\n/).each do |line|
      puts line
      m = /^(\d+)\s+(\w+)$/.match(line)
      if m
        trans = @@mapping[m[2]]
        if trans
          @output += "#{m[1]}\t#{trans}\n"
        end
      end
    end
    @output += @@footer
    m = /^(.+)\.\w+$/.match(File.basename(file))
    new_file = m ? m[1] + ".txt" : File.basename(file) + ".txt"
    File.open(File.join(File.dirname(file), new_file), 'w').write(@output)
  end
end
