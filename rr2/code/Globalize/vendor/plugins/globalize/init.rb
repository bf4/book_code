#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'jcode'
$KCODE = 'u' # Always use UTF-8 internally!

require 'pathname'
require 'singleton'

root_path = directory   # this is set in the initializer that calls init.rb
ml_lib_path = "#{root_path}/lib/globalize"

# Load globalize libs
require "globalize/localization/db_view_translator"
require "globalize/localization/rfc_3066"
require "globalize/localization/locale"
require "globalize/localization/db_translate"
require "globalize/localization/core_ext"
require "globalize/localization/core_ext_hooks"

# Load plugin models
require "globalize/models/translation"
require "globalize/models/model_translation"
require "globalize/models/view_translation"
require "globalize/models/language"
require "globalize/models/country"
require "globalize/models/currency"

# Load overriden Rails modules
require "globalize/rails/active_record"
require "globalize/rails/action_view"
require "globalize/rails/action_mailer"
require "globalize/rails/date_helper"
