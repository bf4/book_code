#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class CustomerSearchTerm
  attr_reader :where_clause, :where_args, :order
  def initialize(search_term)
    search_term = search_term.downcase
    @where_clause = ""
    @where_args = {}
    if search_term =~ /@/
      build_for_email_search(search_term)
    else
      build_for_name_search(search_term)
    end
  end

private

  def build_for_name_search(search_term)
    @where_clause << case_insensitive_search(:first_name)
    @where_args[:first_name] = starts_with(search_term)

    @where_clause << " OR #{case_insensitive_search(:last_name)}"
    @where_args[:last_name] = starts_with(search_term)

    @order = "last_name asc"
  end

  def starts_with(search_term)
    search_term + "%"
  end

  def case_insensitive_search(field_name)
    "lower(#{field_name}) like :#{field_name}"
  end

  def extract_name(email)
    email.gsub(/@.*$/,'').gsub(/[0-9]+/,'')
  end

  def build_for_email_search(search_term)
    @where_clause << case_insensitive_search(:first_name)
    @where_args[:first_name] = starts_with(extract_name(search_term))

    @where_clause << " OR #{case_insensitive_search(:last_name)}"
    @where_args[:last_name] = starts_with(extract_name(search_term))

    @where_clause << " OR #{case_insensitive_search(:email)}"
    @where_args[:email] = search_term

    @order = "lower(email) = " +
      ActiveRecord::Base.connection.quote(search_term) +
      " desc, last_name asc"
  end
end
