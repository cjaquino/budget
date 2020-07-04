require "sinatra"
require "sinatra/reloader" #if development?
require "sinatra/content_for"
require "tilt/erubis"

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  session[:budgets] ||= {}
  # session[:budgets] = { Vacation: [
  #                         {
  #                           name: 'breakfast',
  #                           cost: 15,
  #                           category: 'food'
  #                         },
  #                         {
  #                           name: 'lunch',
  #                           cost: 20,
  #                           category: 'food'
  #                         },
  #                         {
  #                           name: 'dinner',
  #                           cost: 50,
  #                           category: 'food'
  #                         }
  #                       ],
  #                       Monthly: [
  #                         {
  #                           name: 'breakfast',
  #                           cost: 15,
  #                           category: 'food'
  #                         },
  #                         {
  #                           name: 'lunch',
  #                           cost: 20,
  #                           category: 'food'
  #                         },
  #                         {
  #                           name: 'dinner',
  #                           cost: 50,
  #                           category: 'food'
  #                         }
  #                       ]
  #                      }
end

helpers do
  def available(expenses)
    expenses.map { |expense| expense[:cost] }.sum
  end
end

get "/" do
  redirect "/budgets"
end

# Displays available budgets
get "/budgets" do
  @budgets = session[:budgets]
  erb :overview, layout: :layout
end

# Renders a new budget form
get "/budgets/new" do
  erb :new_budget, layout: :layout
end

# Creates a new budget
post "/budgets/new" do
  session[:budgets][params[:budget_name]] = [{
                            name: 'Dinner',
                            cost: 50,
                            category: 'food'
                          }]
  redirect "/budgets"
end

# Display expenses in a budget
get "/budgets/:budget_name" do
  budgets = session[:budgets]
  @budget_name = params[:budget_name]
  @expenses = budgets[@budget_name] || []
  erb :budget, layout: :layout
end
