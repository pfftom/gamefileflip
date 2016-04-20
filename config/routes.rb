Rails.application.routes.draw do
  root "index#index"
  
  post "index/uploadfile", to: "index#uploadfile"

  get "/test", to: "test#sample"
end
