class PriceListPagesController < ApplicationController
  allow_unauthenticated_access only: :show

  before_action :set_price_list_page

  def show
  end

  def edit
  end

  def update
    if @price_list_page.update(price_list_page_params)
      redirect_to price_list_path, notice: "Price list page updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_price_list_page
    @price_list_page = PriceListPage.fetch
  end

  def price_list_page_params
    params.require(:price_list_page).permit(:title, :content)
  end
end
