class AboutPagesController < ApplicationController
  allow_unauthenticated_access only: :show

  before_action :set_about_page

  def show
  end

  def edit
  end

  def update
    if @about_page.update(about_page_params)
      redirect_to about_path, notice: "About page updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_about_page
      @about_page = AboutPage.fetch
    end

    def about_page_params
      params.require(:about_page).permit(:title, :content)
    end
end
