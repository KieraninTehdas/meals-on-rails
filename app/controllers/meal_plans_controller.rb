class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[edit update destroy generate_shopping_list]
  before_action :available_recipes, only: %i[create edit]

  def index
    @meal_plans = MealPlan.all
    @current_meal_plan = MealPlan.current.first || MealPlan.last
  end

  def new
    @meal_plan = MealPlan.new
  end

  def edit; end

  def create
    @meal_plan = MealPlan.new(
      start_date: meal_plan_params[:start_date],
      end_date: meal_plan_params[:end_date],
      recipe_ids: meal_plan_params.fetch(:recipe_ids, [])
    )

    if @meal_plan.save
      redirect_to action: "index"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @meal_plan.update!(meal_plan_params)

    redirect_to action: "index"
  end

  def past_meal_plans
    @pagy, @past_meal_plans = pagy(
      :offset,
      MealPlan.past.order(end_date: :desc)
      .includes(:recipes).where.not(recipes: { id: nil }), limit: 3)
  end

  def upcoming_meal_plans
    @upcoming_meal_plans = MealPlan.future.order(start_date: :asc)
  end

  def destroy
    @meal_plan.destroy!
    redirect_to meal_plans_url, notice: "Meal plan was successfully deleted."
  end

  def generate_shopping_list
    render json: @meal_plan.recipes.map(&:ingredients).join("\n").to_json
  end

  private

  def set_meal_plan
    @meal_plan = MealPlan.find(params[:id])
  end

  def available_recipes
    @available_recipes = Recipe.all
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:start_date, :end_date, recipe_ids: [])
  end
end
