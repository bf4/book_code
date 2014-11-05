#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
class SqlTemplatesController < ApplicationController
  before_action :set_sql_template, only: [:show, :edit, :update, :destroy]

  # GET /sql_templates
  # GET /sql_templates.json
  def index
    @sql_templates = SqlTemplate.all
  end

  # GET /sql_templates/1
  # GET /sql_templates/1.json
  def show
  end

  # GET /sql_templates/new
  def new
    @sql_template = SqlTemplate.new
  end

  # GET /sql_templates/1/edit
  def edit
  end

  # POST /sql_templates
  # POST /sql_templates.json
  def create
    @sql_template = SqlTemplate.new(sql_template_params)

    respond_to do |format|
      if @sql_template.save
        format.html { redirect_to @sql_template, notice: 'Sql template was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sql_template }
      else
        format.html { render action: 'new' }
        format.json { render json: @sql_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sql_templates/1
  # PATCH/PUT /sql_templates/1.json
  def update
    respond_to do |format|
      if @sql_template.update(sql_template_params)
        format.html { redirect_to @sql_template, notice: 'Sql template was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sql_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sql_templates/1
  # DELETE /sql_templates/1.json
  def destroy
    @sql_template.destroy
    respond_to do |format|
      format.html { redirect_to sql_templates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sql_template
      @sql_template = SqlTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sql_template_params
      params.require(:sql_template).permit(:body, :path, :format, :locale, :handler, :partial)
    end
end
