Rails.application.routes.draw do
  scope "/api" do

    root to: "static#home"
  end
end
