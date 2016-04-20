require 'nokogiri'
require 'zip'


class Cfile

  ANALYSIS = ["TMP_TB_ANALYSIS_IN", "TB_analysis", "TB_analysis.xml"]
  PLAYS = ["TMP_TB_PLAYS_IN", "TB_plays", "TB_plays.xml"]

  def initialize(zips, path)
    @exported_file = zips[0]
    @full_file = zips[1]
    @path = path
    counter()
    @CFF = false
  end

  def read_zip()
    count = 0
    Zip::File.open(@exported_file) do |zip|
      zip.each do |entry|
        entry.extract(@path + "/" + entry.name) {true}
        count = count + 1
      end
      if count > 2
        @CFF = true
      end
      modify_xml()
    end
  end

  def create_new()
    Zip::File.open(@full_file, Zip::File::CREATE) do |zipfile|
      zipfile.remove(PLAYS[2])
      zipfile.remove(ANALYSIS[2])
      zipfile.add(PLAYS[2], PLAYS[2])
      zipfile.add(ANALYSIS[2], ANALYSIS[2])

      zipfile.close()
    end

    File.delete(ANALYSIS[2])
    File.delete(PLAYS[2])
    
  end

  private

  def counter()
    if Counter.first 
      Counter.first.increment!(:count)
    else 
      Counter.create
      Counter.first.increment!(:count)
    end
  end
  def modify_xml()
    tb_plays = Nokogiri::XML(File.open(File.join(@path, PLAYS[0] + ".xml"))) 
    tb_plays.xpath("//" + PLAYS[0]).each do |node|
      node.name = PLAYS[1]
    end

    File.write(PLAYS[2], tb_plays.to_xml)

    tb_analysis = Nokogiri::XML(File.open(File.join(@path, ANALYSIS[0] + ".xml")))
    tb_analysis.xpath("//" + ANALYSIS[0]).each do |node|
      node.name = ANALYSIS[1]
    end
    if @CFF
      tb_analysis.xpath("//id").each do |node|
        node.remove
      end
    end

    File.write(ANALYSIS[2], tb_analysis.to_xml)
  end

  
end

