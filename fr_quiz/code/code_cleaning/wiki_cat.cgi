#!/usr/local/bin/ruby

require 'cgi'

H = 'HomePage'
B = 'wiki.cgi?n=%s'

c = CGI.new 'html4'

n = if c['n'] == '' then H else c['n'] end
d = c['d']

t = File.read(n) rescue t = ''

unless d == ''
  t = CGI.escapeHTML(d)
  File.open(n, "w") { |f| f.write t }
end

c.instance_eval do
  out do 
    h1 { n } +
    a(B % H) { H } +
    pre do
      t.gsub(/([A-Z]\w+){2}/) { |match| a(B % match) { match } }
    end +
    form("get") do
      textarea('d') { t } +
      hidden('n', n) +
      submit
    end
  end
end
