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
                                   disable_indented_code_blocks: false,
                                   strikethrough:                true,
                                   superscript:                  true,
                                   underline:                    true,
                                   highlight:                    true,
                                   tables:                       true,
                                   quote:                        false,
                                   footnotes:                    true)

Dir.mkdir './docs/' unless Dir.exist? './docs/'

html = """
<html>
  <head>
    <title>Pokken Matchup Recorder Automation Suite Documentation</title>
    <link href='prettify.css' type='text/css' rel='stylesheet' />
    <script type='text/javascript' src='prettify.js'></script>
    <link href='styles.css' rel='stylesheet'>
  </head>
  <body onload='prettyPrint()'>
    <article class='markdown-body entry-content'>
      #{markdown.render(@data)}
    </article></script></body></html>
"""

File.open('./docs/index.html', 'w') do |f|
  f.write(html)
end
