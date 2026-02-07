require 'yaml'
require 'fileutils'

def parse_front_matter(file)
  content = File.read(file)
  if content =~ /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m
    begin
      YAML.safe_load($1, permitted_classes: [Date, Time]) # Allow Date/Time just in case
    rescue => e
      puts "Error parsing YAML in #{file}: #{e.message}"
      nil
    end
  else
    nil
  end
end

puts "Generating Polyglot Availability Map..."

availability = Hash.new { |h, k| h[k] = [] }
# Include root level directories that might look like collections if needed?
# Typically _posts, _pages, _portfolio are enough based on workspace.
dirs = ['_posts', '_pages', '_portfolio']

dirs.each do |dir|
  next unless Dir.exist?(dir)
  Dir.glob("#{dir}/**/*.{md,html}").each do |file|
    data = parse_front_matter(file)
    next unless data
    
    lang_ref = data['lang-ref']
    lang = data['lang']
    
    # Debug print if expected ref is missing (optional)
    # puts "Skipping #{file} (no lang-ref)" unless lang_ref
    
    if lang_ref && lang
      availability[lang_ref] << lang
      availability[lang_ref].uniq!
    end
  end
end

output_dir = "_data"
FileUtils.mkdir_p(output_dir)
File.write(File.join(output_dir, 'polyglot_availability.yml'), availability.to_yaml)

puts "Map generated with #{availability.size} entries."
