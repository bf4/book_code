      require 'sinatra'

      get '/zing' do
        redirect 'http://example.com'
      end
      
      at_exit { File.unlink('/var/folders/0t/wmb8l4z555q1vy_n8wmg0jl00000gn/T/lifeline20130730-5833-ursook') rescue nil }

      run Sinatra::Application
