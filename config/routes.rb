KidsMathsNew::Application.routes.draw do
  get "reports/show"

  get "reports/show/:game_date", to: "reports#show"

  get "questions/start"

  get "questions/next"

  get "questions/skip"

  get "questions/finish"

  get "questions/logout"

  get "questions/logout"

  get "options/index"

  get "options/set"

  get "options/home"

  devise_for :users

  root to: "options#index"

  match '*path' ,to: "options#home"

end
