class LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :update, :destroy]

  # GET /libraries
  def index
    render_success Library.all
  end

  # GET /libraries/1
  def show
    render_success @library
  end

  # POST /libraries
  def create
    @library = Library.create!(library_params)
    render_success @library, :created
  end

  # PATCH/PUT /libraries/1
  def update
    @library.update!(library_params)
  end

  # DELETE /libraries/1
  def destroy
    @library.destroy
  end

  private

  def set_library
    @library = Library.find(params[:id])
  end

  def library_params
    params.require(:library).permit(:name)
  end
end
