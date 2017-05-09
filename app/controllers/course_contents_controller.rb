class CourseContentsController < ApplicationController
    before_action :authenticate_user
    #Display all contents based on course
    def content
        #Add exception for searching details and security for contents
        begin
            @course = Course.find(params[:id])
            if current_user.admin != 3
                @course.user.each do |user|
                    if user = current_user
                        @contents = @course.course_contents
                    end
                end
            else
                @contents = @course.course_contents
            end

            if @contents.nil?
                redirect_to courses_index_path, alert: "You have no access to view this course."
            end
        rescue ActiveRecord::RecordNotFound
            redirect_to courses_index_path, alert: "Course is not existed."
        end
    end

    #Build new course contents and create from CourseContents controller
    def new
        @course = Course.find(params[:id])
        if current_user.admin != 1
            @content = CourseContent.new
        else
            redirect_to content_path(@course), alert: "You are not admin/lecturer."
        end
    end

    #This method allows to create course content for this course
	def create
        #To avoid routing confusion, create method is in this controller only because there is no course id yet
        @content = CourseContent.new(content_params)
        #If it is save then redirect to this path with the identification
        if @content.save
            redirect_to content_path(@content.course_id), notice: "Content has been created successfully."

        #Else, repeat it and display notice
        else
            @course = Course.find(params[:course_content][:course_id])
            render :new
        end

	end

    #For routing purpose, it must be selected for deleting the content to easier identify
    def show

    end

    #Edit contents
    def edit
        begin
            @content = CourseContent.find(params[:id])
            if current_user.admin == 1
                redirect_back(fallback_location: courses_index_path)
                flash[:alert] = "You are not admin/lecturer."
            elsif current_user.admin == 2
                @count = 0
                @content.course.user.each do |user|
                    if user = current_user
                        @count += 1
                    end
                end

                if @count == 0
                    redirect_to display_course_path, alert: "You have no access to this content."
                end
            end
        rescue ActiveRecord::RecordNotFound
            redirect_to courses_index_path, alert: "Content is not existed."
        end
    end

    #Update contents' details and return to content page where course id
    def update
        edit()

        if @content.update(content_params)
            redirect_to content_path(@content.course_id), notice: "Content has been updated successfully."

        else
            render :edit
        end
    end

    #Delete contents and return to the content page where course id
    def destroy
        edit()
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