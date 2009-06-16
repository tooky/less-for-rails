module LessForRails
  STYLESHEETS_PATH = File.join(Rails.root, "public", "stylesheets")
  extend self
  
  # Converts all public/stylesheets/*.less to public/stylesheets/*.css.
  #
  # Options:
  #  compress - Remove all newlines? `true` or `false`.
  def run(options = {})
    Dir[File.join(STYLESHEETS_PATH, "*.less")].each {|less|
      css = Less::Engine.new(File.read(less)).to_css(:desc)
      css = css.delete("\n") if options[:compress]
      
      destination_file = File.basename(less, File.extname(less))
      destination_path = File.join(STYLESHEETS_PATH, "#{destination_file}.css")
      
      File.open(destination_path, "w") {|file|
        file.write css
      }
    }
  end
end