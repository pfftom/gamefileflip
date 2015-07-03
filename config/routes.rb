Rails.application.routes.draw do
  root "index#index"
  
  post "index/uploadfile", to: "index#uploadfile"
end
