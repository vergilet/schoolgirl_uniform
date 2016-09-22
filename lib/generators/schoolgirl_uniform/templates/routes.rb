resource :my_form, controller: 'my_form', only: [:show, :create] do
  collection do
    get  :current
    post :next
    get  :previous
    get  :finish
  end
end