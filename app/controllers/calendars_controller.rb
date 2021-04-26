class CalendarsController < ApplicationController
  def index
    @today = Date.today
    from_date = Date.new(@today.year, @today.month, @today.beginning_of_month.day).beginning_of_week(:sunday)
    to_date = Date.new(@today.year, @today.month, @today.end_of_month.day).end_of_week(:sunday)
    @calendar_data = from_date.upto(to_date)
    # @calendar = Calendar.where(user_id: current_user.id).order(:c_date)
    @top_items = Item.where(user_id: current_user.id).where(choice: 1).order(:c_date)
    @bottom_items = Item.where(user_id: current_user.id).where(choice: 2).order(:c_date)
    @shoes_items = Item.where(user_id: current_user.id).where(choice: 3).order(:c_date)
  end

  def calendar_items
    params.require(:calendar).permit(:top_item, :bottom_item, :shoes_item, :description, :c_date  { category_ids: [] })
  end

  def new
    @calendar = Calendar.new
    @calendar.c_date = params[:c_date]
    @top_items = Item.where(user_id: current_user.id).where(choice: 1).order(:c_date)
    @bottom_items = Item.where(user_id: current_user.id).where(choice: 2).order(:c_date)
    @shoes_items = Item.where(user_id: current_user.id).where(choice: 3).order(:c_date)
    # ↑インスタンス変数 ↑Itemはモデル
    # アイテム一覧の保存されている画像の中から選択できるようにする。

    #@item = Item.new
    #@item.r_date = params[:r_date]
    

  end

  def create
      @calendar = Calendar.new(params[:id])
    if @calendar.save
      redirect_to calendars_index_path, success: '保存に成功しました'
    else
      flash.now[:danger] = "保存に失敗しました"
      render :new
    end
  end
  

  #@calendar = Item.new(params[:id])
  #if @calendar.save
    #redirect_to calendars_index_path, success: '保存に成功しました'
  #else
    #flash.now[:danger] = "保存に失敗しました"
    #render :new
  #end

  
  def show
    @calendar = find_calendar_by_id
    #登録した保存内容を見るためのページ
  end
  #↑　@calendar = Item.find(params[:id])

  def edit
    @calendar = find_calendar_by_id 
   
  end

  def update
    @calenar = find_calendar_by_id
    if @calendar.update(calendar_params)
        redirect_to calendars_index_path, success:"変更に成功しました"
    else
        flash.now[:danger] = "変更に失敗しました"
        render :new
    end
  end

  #@item = find_item_by_id
  #if @item.update(item_params)
     # redirect_to items_index_path, success: "変更に成功しました。"
  #else
   #   flash.now[:danger] = "変更に失敗しました。"
    #  render :new
  #end

  def destroy
    @calendar = find_calendar_by_id
    if @calendar.destroy
        redirect_to calendars_index_path, success: "削除しました"
    else
        flash.now[:danger] = "削除に失敗しました"
        render :new
    end
  end

  #@item = find_item_by_id
  #if @item.destroy
      #redirect_to items_index_path, success: "削除しました。"
  #else
      #flash.now[:danger] = "削除に失敗しました。"
      #render :new
  #end

  private
    def item_params
        params.require(:item).permit(:user_id, :description, :image, :choice)
    end

    def find_item_by_id
        Item.find(params[:id])
    end

    def calendar_params
        params.require(:calendar).permit(:top_item, :bottom_item, :shoes_item, :description, :c_date)
    end

    def find_calendar_by_id
        Calendar.find(params[:id])
    end
end
#　@calendar = item.newにする必要ありなのかも