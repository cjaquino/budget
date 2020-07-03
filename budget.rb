require "sinatra"
require "sinatra/reloader" #if development?
require "sinatra/content_for"
require "tilt/erubis"

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  # session[:budgets] ||= {}
  session[:budgets] = { Vacation: [
                          {
                            name: 'breakfast',
                            cost: 15,
                            category: 'food'
                          },
                          {
                            name: 'lunch',
                            cost: 20,
                            category: 'food'
                          },
                          {
                            name: 'dinner',
                            cost: 50,
                            category: 'food'
                          }
                        ],
                        Monthly: [
                          {
                            name: 'breakfast',
                            cost: 15,
                            category: 'food'
                          },
                          {
                            name: 'lunch',
                            cost: 20,
                            category: 'food'
                          },
                          {
                            name: 'dinner',
                            cost: 50,
                            category: 'food'
                          }
                        ]
                       }
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
