class Api::V1::ExpensesController < ApplicationController
    
    before_action :authenticate_with_token!
    
    def index

        expenses = current_user.expenses
        render json: {expenses: expenses}, status: 200
    end
    
    def show
        expense = current_user.expenses.find(params[:id])
        render json: expense, status: 200
    end
    
    def create
        expense = current_user.expenses.build(expense_params)
        if expense.save
            render json: expense, status: 201
        else
            render json: {errors: expense.errors}, status: 422

        gains = current_user.gains
        render json: {gains: gains}, status: 200
    end
    
    def show
        gain = current_user.gains.find(params[:id])
        render json: gain, status: 200
    end
    
    def create
        gain = current_user.gains.build(gain_params)
        if gain.save
            render json: gain, status: 201
        else
            render json: {errors: gain.errors}, status: 422

        end
    end
    
    def update

        expense = current_user.expenses.find(params[:id])
        if expense.update_attributes(expense_params)
            render json: expense, status: 200
        else
            render json: {errors: expense errors}, status: 422

        gain = current_user.gains.find(params[:id])
        if gain.update_attributes(gain_params)
            render json: gain, status: 200
        else
            render json: {errors: gain errors}, status: 422

        end
    end
    
    def destroy

        expense = current_user.expenses.find(params[:id])
        expense.destroy

        gain = current_user.gains.find(params[:id])
        gain.destroy

        head 204
    
    private
    

    def expense_params
        params.require(:expense).permit(:description, :value, :date)

    def gain_params
        params.require(:gain).permit(:description, :value, :date)

    end
    
end
