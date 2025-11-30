class HomePagesController < ApplicationController
  allow_unauthenticated_access only: :show

  before_action :set_home_page

  def show
  end

  def edit
  end

  def update
    if @home_page.update(home_page_params)
      redirect_to root_path, notice: "Home page updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_home_page
    @home_page = HomePage.fetch
  end

  def home_page_params
    params.require(:home_page).permit(:title, :content)
  end
end
