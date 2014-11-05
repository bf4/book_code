#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class EvalTemplate < ActionView::TemplateHandler
  include ActionView::TemplateHandlers::Compilable
  def compile(template)
    compiled = "controller.headers['Content-Type'] ||= 'text/plain'\n"
    compiled << "output = ''\n"
    
    compiled << template.source.split(/\n/).map do |line|
      <<-ruby_eval
        line = #{line.inspect}
        @eval_template_scope ||= binding
        begin
          output << line + " => " + eval(line,@eval_template_scope).to_s + "\n"
        rescue Exception => err
          output << line + " => " + err.inspect + "\n"
        end
      ruby_eval
    end.join("\n")
  end
end
