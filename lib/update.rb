require "open-uri"
require "nokogiri"
require "mvm"

class Update
	URL = "http://www.mpich.org/static/downloads/"
	def self.run(args,options)
		file_url = get_url
		path = File.join(MVM::SETTING_DIR, MVM::VERSIONS)
		open(path,"w") do |f|
			file_url.each do |key,value|
				f.write "#{key}:#{value}\n"
			end
		end
	end

  def self.get_url
    text = open(URL) do |f| f.read end
    doc = Nokogiri::HTML(text)
    replace_br_tag(doc)
    tr_list = Array.new
    doc.xpath('html/body/table/tr').each do |tr|
      tr_list << tr
    end
    source_path = Array.new
    # nightly build not include
    tr_list[3..-3].each do |tr|
      source_path << tr.children[1].children.first.attr('href')
    end

    file_url = Hash.new
    source_path.each do |path|
      url = [URL,path].join
      print "Update from #{url}..."
      text = open(url) do |f| f.read end
      doc = Nokogiri::HTML(text)
      replace_br_tag(doc)
      tr_list = Array.new
      doc.xpath('html/body/table/tr').each do |tr|
        tr_list << tr
      end

      tr_list[3..-2].each do |tr|
        tag = tr.children[1].children.first
        if tag.text =~ /mpich.*\.tar\.gz/
          file_path = tag.attr('href')
          file_name = tag.text
          file_url[file_name] = [url,file_path].join
        end
      end
      print "complete!\n"
    end
    puts "complete all!"
    file_url
  end

  def self.replace_br_tag(doc)
    doc.search('br').each do |n|
      n.replace("\n")
    end
  end
end
