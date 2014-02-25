KidsMaths::Application.routes.draw do
  get "home/show_options"

  get "home/set_options"

  get "game/next_question"

  get "game/skip_question"

  get "game/finish_game"

  get "game/play"

  root :to => "home#show_options"
end
