rule '.class' => '.java' do |t|
  sh "javac #{t.source}"
end
