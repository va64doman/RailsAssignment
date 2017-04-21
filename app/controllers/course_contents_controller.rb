class CourseContentsController < ApplicationController
    #Display all contents based on course
    def content
        @course = Course.find(params[:id])
        @contents = @course.course_contents
    end

    #Build new course contents and create from CourseContents controller
    def new
        @course = Course.find(params[:id])
        @content = CourseContent.new
    end

    #This method allows to create course content for this course
	def create
        if !@course.nil?
            #To avoid routing confusion, create method is in this controller only because there is no course id yet
            @content = CourseContent.new(content_params)
            #If it is save then redirect to this path with the identification
            if @content.save
                redirect_to content_path(@content.course_id), notice: "Content has been created successfully."

            #Else, repeat it and display notice
            else
                render :new
            end
        else
            flash[:alert] = "Name and Description can't be blank."
            redirect_to new_content_path(params[:course_content][:course_id]) and return
        end
	end

    #For routing purpose, it must be selected for deleting the content to easier identify
    def show
    end

    #Edit contents
    def edit
        @content = CourseContent.find(params[:id])
    end

    #Update contents' details and return to content page where course id
    def update
        @content = CourseContent.find(params[:id])

        if @content.update(content_params)
            redirect_to content_path(@content.course_id), notice: "Content has been updated successfully."

        else
            render :edit
        end
    end

    #Delete contents and return to the content page where course id
    def destroy
        @content = CourseContent.find(params[:id])
        @course = @content.course_id

        @content.destroy
        
        redirect_to content_path(@course), notice: "Content has been deleted."

    end

    #Content params requires all content's details
	private
    	def content_params
    		params.require(:course_content).permit(:name, :description, :course_id)
    	end
end