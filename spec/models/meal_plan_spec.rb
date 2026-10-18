require 'rails_helper'

RSpec.describe MealPlan, type: :model do
  let(:start_date) { Date.today }
  let(:end_date) { 6.days.after(Date.today) }

  context "when there are no overlapping meal plans" do
    it "saves a meal plan" do
      MealPlan.create!(start_date: 6.days.before(start_date), end_date: 1.day.before(start_date))

      expect { MealPlan.create!(start_date: start_date, end_date: end_date) }.not_to raise_error
    end
  end

  describe "overlapping meal plans" do
    before { MealPlan.create!(start_date: start_date, end_date: end_date) }

    context "when period is contained within existing meal plan period" do
      it "doesn't allow creation of another plan" do
        expect { MealPlan.create!(start_date: start_date, end_date: end_date) }.to raise_error(ActiveRecord::RecordInvalid)
        expect { MealPlan.create!(start_date: 1.day.after(start_date), end_date: 1.day.before(end_date)) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when start date overlaps an existing meal plan period" do
      it "doesn't allow creation of another plan" do
        expect { MealPlan.create!(start_date: start_date, end_date: 1.day.after(end_date)) }.to raise_error(ActiveRecord::RecordInvalid)
        expect { MealPlan.create!(start_date: 1.day.after(start_date), end_date: 1.day.after(end_date)) }.to raise_error(ActiveRecord::RecordInvalid)
        expect { MealPlan.create!(start_date: end_date, end_date: 1.day.after(end_date)) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when end date overlaps an existing meal plan period" do
      it "doesn't allow creation of another plan" do
        expect { MealPlan.create!(start_date: 5.days.before(start_date), end_date: start_date) }.to raise_error(ActiveRecord::RecordInvalid)
        expect { MealPlan.create!(start_date: 5.days.before(start_date), end_date: 1.day.after(start_date)) }.to raise_error(ActiveRecord::RecordInvalid)
        expect { MealPlan.create!(start_date: 5.days.before(start_date), end_date: end_date) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when existing meal plan period is contained within specified period" do
      it "doesn't allow creation of another plan" do
        expect { MealPlan.create!(start_date: 1.day.before(start_date), end_date: 1.day.after(end_date)) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "editing a meal plan" do
    it "is successful" do
      meal_plan = MealPlan.create!(start_date: start_date, end_date: end_date)

      expect { meal_plan.update!(end_date: 1.day.after(end_date)) }.not_to raise_error
    end
  end
end
