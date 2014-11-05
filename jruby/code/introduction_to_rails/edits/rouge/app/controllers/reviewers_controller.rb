#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
class ReviewersController < AuthenticatedController
  layout 'authenticated'

  # GET /reviewers
  # GET /reviewers.xml
  def index
    @reviewers = Reviewer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviewers }
    end
  end

  # GET /reviewers/1
  # GET /reviewers/1.xml
  def show
    @reviewer = Reviewer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reviewer }
    end
  end

  # GET /reviewers/new
  # GET /reviewers/new.xml
  def new
    @reviewer = Reviewer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reviewer }
    end
  end

  # GET /reviewers/1/edit
  def edit
    @reviewer = Reviewer.find(params[:id])
  end

  # POST /reviewers
  # POST /reviewers.xml
  def create
    @reviewer = Reviewer.new(params[:reviewer])

    respond_to do |format|
      if @reviewer.save
        format.html { redirect_to(@reviewer, :notice => 'Reviewer was successfully created.') }
        format.xml  { render :xml => @reviewer, :status => :created, :location => @reviewer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reviewer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviewers/1
  # PUT /reviewers/1.xml
  def update
    @reviewer = Reviewer.find(params[:id])

    respond_to do |format|
      if @reviewer.update_attributes(params[:reviewer])
        format.html { redirect_to(@reviewer, :notice => 'Reviewer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reviewer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviewers/1
  # DELETE /reviewers/1.xml
  def destroy
    @reviewer = Reviewer.find(params[:id])
    @reviewer.destroy

    respond_to do |format|
      format.html { redirect_to(reviewers_url) }
      format.xml  { head :ok }
    end
  end
end
