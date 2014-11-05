#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
class ReviewsController < ApplicationController
  before_filter :authenticate

  # GET /reviews
  # GET /reviews.xml
  def index
    @reviews = Review.find(:all, :conditions => ['reviewer_id = ?', @reviewer.id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @review = Review.find_by_id_and_reviewer_id(params[:id], @reviewer)

    raise "Couldn't find Review with ID=#{params[:id]} \
and reviewer=#{@reviewer.name}" unless @review

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.xml
  def new
    @restaurants = Restaurant.alphabetized
    @review = Review.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @restaurants = Restaurant.alphabetized
    @review = Review.find_by_id_and_reviewer_id(params[:id], @reviewer)

    raise "Couldn't find Review with ID=#{params[:id]}\
 and reviewer=#{@reviewer.name}" unless @review
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @review = @reviewer.reviews.build(params[:review])

    respond_to do |format|
      if @review.save
        format.html { redirect_to(@review,
                                  :notice => 'Review was successfully created.') }
        format.xml  { render :xml => @review,
                             :status => :created,
                             :location => @review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @review.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = Review.find_by_id_and_reviewer_id(params[:id], @reviewer)

    raise "Couldn't find Review with ID=#{params[:id]} \
and reviewer=#{@reviewer.name}" unless @review

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to(@review,
                                  :notice => 'Review was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = Review.find_by_id_and_reviewer_id(params[:id], @reviewer)

    raise "Couldn't find Review with ID=#{params[:id]} \
and reviewer=#{@reviewer.name}" unless @review

    @review.destroy

    respond_to do |format|
      format.html { redirect_to(reviews_url) }
      format.xml  { head :ok }
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic("Reviews") do |user_name, password|
      @reviewer = Reviewer.find_by_username_and_password(user_name, password)
    end
  end
end
