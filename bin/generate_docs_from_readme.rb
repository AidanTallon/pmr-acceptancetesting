# frozen_string_literal: true

require 'redcarpet'

@data = File.read './README.md'

rndr = Redcarpet::Render::HTML.new prettify: true
markdown = Redcarpet::Markdown.new(rndr,
                                   autolink:                     false,
                                   space_after_headers:          true,
                                   prettify:                     true,
                                   no_intra_emphasis:            true,
                                   fenced_code_blocks:           true,
                                   disable_indented_code_blocks: true,
                                   strikethrough:                true,
                                   superscript:                  true,
                                   underline:                    true,
                                   highlight:                    true,
                                   tables:                       true,
                                   quote:                        true,
                                   footnotes:                    true)

Dir.mkdir './docs/' unless Dir.exist? './docs/'

File.open('./docs/index.html', 'w') do |f|
  f.write(markdown.render(@data))
end
