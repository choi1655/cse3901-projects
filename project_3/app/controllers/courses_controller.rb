class CoursesController < ApplicationController
  def index
  @courses = Course.where(nil) # General scope

  #Filtered entity
  @courses = @courses.filter_by_section(params[:section]) if params[:section].present?
  @courses = @courses.filter_by_number(params[:number]) if params[:number].present?
  @courses = @courses.filter_by_instructors(params[:instructors]) if params[:instructors].present?
  end

end
