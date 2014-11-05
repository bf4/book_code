#!/usr/bin/ruby -rcgi
H,B=%w'HomePage w7.cgi?n=%s';c=CGI.new'html4';n,d=c['n']!=''?c['n']:H,c['d'];t=`
cat #{n}`;d!=''&&`echo #{t=CGI.escapeHTML(d)} >#{n}`;c.instance_eval{out{h1{n}+
a(B%H){H}+pre{t.gsub(/([A-Z]\w+){2}/){a(B%$&){$&}}}+form("get"){textarea('d'){t
}+hidden('n',n)+submit}}}
