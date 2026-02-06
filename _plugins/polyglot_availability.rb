module PolyglotAvailability
    class Generator < Jekyll::Generator
      safe true
      priority :highest
  
      def generate(site)
      end
    end
end
  
Jekyll::Hooks.register :site, :post_read do |site|
    puts "---------------------------------------------------"
    puts " [PolyglotAvailability] Hook running!"
    puts " [PolyglotAvailability] Docs (Documents): #{site.documents.size}"
    puts " [PolyglotAvailability] Pages: #{site.pages.size}"

    availability = Hash.new { |h, k| h[k] = [] }
    
    # Gather all documents (Pages + Collections)
    all_items = site.documents + site.pages
    
    all_items.each do |doc|
      # Check for lang-ref and lang
      lang_ref = doc.data['lang-ref']
      lang = doc.data['lang']
      
      if lang_ref && lang
        availability[lang_ref] << lang
        availability[lang_ref].uniq!
      end
    end

    puts " [PolyglotAvailability] Availability Map Size: #{availability.size}"
    if availability.size > 0
        puts " [PolyglotAvailability] Sample: #{availability.first.inspect}"
    else
        puts " [PolyglotAvailability] NO AVAILABILITY FOUND. CHECK FRONT MATTER."
    end
    
    # Store in site.data
    site.data['polyglot_availability'] = availability
end
